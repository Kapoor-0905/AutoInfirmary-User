import express from 'express';
import { get, identity, merge } from 'lodash';
import logger from '../utils/logger';
import prisma from '../utils/db';

export const isOwner = async (
    req: express.Request,
    res: express.Response,
    next: express.NextFunction) => {
    try {
        const { id } = req.params;
        const currentUserId = get(req, 'identity.id') as string;

        if (!currentUserId) {
            return res.sendStatus(403);
        }

        if (currentUserId.toString() !== id) {
            return res.sendStatus(403);
        }

        next();
    } catch (error) {
        logger.info(error);
        return res.sendStatus(400);
    }
}

export const isAuthenticated = async (
    req: express.Request,
    res: express.Response,
    next: express.NextFunction) => {
    try {
        const sessionToken: string = req.cookies.sessionToken || req.cookies['session-token'];

        if (!sessionToken) {
            return res.sendStatus(403);
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
            return res.sendStatus(403);
        }

        merge(req, {
            identity: existingUser
        })

        return next();
    } catch (error) {
        logger.info(error);
        return res.sendStatus(400);
    }
}    