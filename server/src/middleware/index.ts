import express from 'express';
import { get, merge } from 'lodash';
import logger from '../utils/logger';
import prisma from '../utils/db';
import jwt from "jsonwebtoken";

const jwtSecret = process.env.JWT_SECRET as string;

export const isOwner = async (
    req: express.Request,
    res: express.Response,
    next: express.NextFunction) => {
    try {
        const { id } = req.params;
        const currentUserId = get(req, 'identity.id') as string;

        if (!currentUserId) {
            return res.json({
                message: "not authorized!"
            }).status(403);
        }

        if (currentUserId.toString() !== id) {
            return res.json({
                message: "not authorized!"
            }).status(403);
        }

        next();
    } catch (error) {
        logger.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
}

export const isAuthenticated = async (
    req: express.Request,
    res: express.Response,
    next: express.NextFunction) => {
    try {
        const jwtToken = req.headers.authorization || req.headers['authorization']
        const sessionToken: string = req.cookies.sessionToken || req.cookies['session-token'];

        if (!jwtToken && !sessionToken) {
            return res.json({
                message: 'not authorized!'
            }).status(403).end();
            return;
        }

        const [, token] = jwtToken.split(' ')

        if (!token) {
            res.json({
                message: 'not a valid token!'
            }).status(403).end();
            return;
        }

        const existingUser = await prisma.user.findFirst({
            where: {
                auth: {
                    is: {
                        sessionToken: sessionToken
                    }
                }
            }
        })

        if (!existingUser) {
            return res.json({
                message: "user not found!"
            }).status(403);
        }

        merge(req, {
            identity: existingUser
        })

        const user = jwt.verify(token, jwtSecret) as { id: string, email: string }; // Add type annotation for 'id'
        req.user = user;
        return next();
    } catch (error) {
        logger.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
}