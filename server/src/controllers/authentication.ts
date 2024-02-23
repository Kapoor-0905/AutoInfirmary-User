import express from 'express';
import { authentication, random } from '../helpers';
import prisma from '../utils/db';
import logger from '../utils/logger';

export const register = async (req: express.Request, res: express.Response) => {
    try {
        const { email, password, firstName, lastName, username, street, city, state, zip, country } = req.body;
        if (!email || !password || !firstName || !lastName || !username || !street || !city || !state || !zip || !country) {
            logger.info('Missing required fields');
            res.status(400).json({
                message: "Missing required fields"
            });
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
            });
            return;
        }

        const salt = random();
        const user = await prisma.user.create({
            data: {
                email: email,
                firstName: firstName,
                lastName: lastName,
                username: username,
                auth: {
                    set: {
                        salt,
                        password: authentication(salt, password),
                        sessionToken: random()
                    }
                },
                address: {
                    set: {
                        street: req.body.street,
                        city: req.body.city,
                        state: req.body.state,
                        zip: req.body.zip,
                        country: req.body.country
                    }
                },
                uniqueOrgCode: req.body.uniqueOrgCode
            }
        });

        if (user) {
            logger.info('user created');
            res.send({
                message: "user created seccessfully",
            })
        
        }
    } catch (error) {
        logger.info(error);
        return res.sendStatus(400);
    }
}