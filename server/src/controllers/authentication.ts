import express from 'express';
import { authentication, random } from '../helpers';
import prisma from '../utils/db';
import logger from '../utils/logger';

export const login = async (req: express.Request, res: express.Response) => {
    try {
        const { email, password } = req.body;
        if (!email || !password) {
            logger.info('Missing required fields');
            res.status(400).json({
                message: "Missing required fields"
            }).end();
            return;
        }

        const user = await prisma.user.findUnique({
            where: {
                email: email
            }
        });

        if (!user) {
            return res.send(403);
        }

        const expectedHash = authentication(user.auth.salt, password);

        if (user.auth.password != expectedHash) {
            return res.sendStatus(403);
        }

        const salt = random();
        user.auth.sessionToken = authentication(salt, user.id.toString());

        await prisma.user.update({
            where: {
                id: user.id
            },
            data: {
                auth: {
                    update: {
                        sessionToken: user.auth.sessionToken
                    }
                }
            }
        });

        res.cookie('sessionToken', user.auth.sessionToken, { domain: 'localhost', path: '/', httpOnly: true, secure: true, sameSite: 'none' });

        res.status(200).json(user).end();
    } catch (error) {
        logger.info(error);
        return res.status(400).json({
            message: "Something went wrong"
        }).end();
    }
}

export const register = async (req: express.Request, res: express.Response) => {
    try {
        const { email, password, firstName, lastName } = req.body;
        if (!email || !password || !firstName || !lastName) {
            logger.info('Missing required fields');
            res.status(400).json({
                message: "Missing required fields"
            }).end();
            return;
        }

        const existingUser = await prisma.user.findUnique({
            where: {
                email: email
            }
        })

        if (existingUser) {
            logger.info('User already exists');
            res.status(400).json({
                message: "User already exists"
            }).end();
            return;
        }

        const salt = random();
        const user = await prisma.user.create({
            data: {
                email: email,
                firstName: firstName,
                lastName: lastName,
                auth: {
                    set: {
                        salt,
                        password: authentication(salt, password),
                        sessionToken: random()
                    }
                },
                address: req.body.address,
                uniqueOrgCode: req.body.uniqueOrgCode
            }
        });

        if (user) {
            logger.info('user created');
            const token = await prisma.user.findFirst({
                select: {
                    id : true,
                    auth: {
                        select: {
                            sessionToken: true
                        }
                    }
                }    
            })
            res.status(200).send({ 
                message: "user created seccessfully",
                token
            }).end();
        } else {
            logger.info('user not created');
            res.send({
                message: "user not created"
            })
        }
    } catch (error) {
        logger.info(error);
        return res.status(400).json({
            message: "Something went wrong"
        }).end();
    }
}