import express from 'express';
import logger from '../utils/logger';
import prisma from '../utils/db';

export const getAllUserEmergencyContacts = async (req: express.Request, res: express.Response) => {
    try {
        // For Postman testing
        // const userID = req.user as { id: string }

        // For application: Flutter
        const { userId } = req.params;

        const user = await prisma.user.findUnique({
            where: {
                // For Postman testing
                // id: userID.id

                // For flutter application
                id: userId
            }, include: {
                EmergencyContacts: true
            }
        })
        if (user.EmergencyContacts) {
            logger.info('Emergency Contacts found');
            res.status(200).json(user.EmergencyContacts).end();
        } else {
            logger.info('Emergency Contacts not found');
            res.send({
                message: "Emergency Contacts not found"
            })
        }
    } catch (error) {
        logger.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
}

export const createEmergencyContact = async (req: express.Request, res: express.Response) => {
    try {
        const { name, phoneNum, email, relationship } = req.body;

        if (!name || !phoneNum || !email || !relationship) {
            logger.info('Missing required fields');
            res.status(400).json({
                message: "Missing required fields"
            }).end();
            return;
        }

        const existingEmergencyContact = await prisma.emergencyContact.findFirst({
            where: {
                email: email
            }
        })

        if (existingEmergencyContact) {
            logger.info('Contact already exists');
            res.status(400).json({
                message: "Contact already exists"
            }).end();
            return;
        }

        // For Postman testing
        // const userID = req.user as { id: string }

        // For application: Flutter
        const userID = req.body.userId

        const newEmergencyContact = await prisma.emergencyContact.create({
            data: {
                name: name,
                phoneNum: phoneNum,
                email: email,
                relationship: relationship,
                // For Postman testing
                // userId: userID.id

                // For flutter application
                userId: userID
            }
        });

        if (newEmergencyContact) {
            logger.info('Emergency Contact created');
            res.status(200).json(newEmergencyContact).end();
        } else {
            logger.info('Emergency Contact not created');
            res.send({
                message: "Emergency Contact not created"
            })
        }
    } catch (error) {
        logger.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
}

export const updateEmergencyContact = async (req: express.Request, res: express.Response) => {
    try {
        const { id } = req.params;
        const { name, phoneNum, email, relationship } = req.body;
        // For Postman testing
        // const userID = req.user as { id: string }

        // For application: Flutter
        const userID = req.body.userId
        const updatedEmergencyContact = await prisma.emergencyContact.update({
            where: {
                id_userId: {
                    id: id,
                    // For Postman testing
                    // userId: userID.id
                    // For flutter application
                    userId: userID
                }
            },
            data: {
                name: name,
                phoneNum: phoneNum,
                email: email,
                relationship: relationship
            }
        });

        if (updatedEmergencyContact) {
            logger.info('Emergency Contact updated');
            res.status(200).json(updatedEmergencyContact).end();
        } else {
            logger.info('Emergency Contact not found');
            res.send({
                message: "Emergency Contact not found"
            })
        }
    } catch (error) {
        logger.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
}

export const deleteEmergencyContact = async (req: express.Request, res: express.Response) => {
    try {
        const { id } = req.params;
        // For Postman testing
        // const userID = req.user as { id: string }

        // For application: Flutter
        const userID = req.body.userId

        const deletedEmergencyContact = await prisma.emergencyContact.delete({
            where: {
                id_userId: {
                    id: id,
                    // For Postman testing
                    // userId: userID.id

                    // For flutter application
                    userId: userID
                }
            }
        });

        if (deletedEmergencyContact) {
            logger.info('Emergency Contact deleted');
            res.status(200).json(deletedEmergencyContact).end();
        } else {
            logger.info('Emergency Contact not found');
            res.send({
                message: "Emergency Contact not found"
            })
        }
    } catch (error) {
        logger.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
}