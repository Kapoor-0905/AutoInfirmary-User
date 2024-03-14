import express from 'express';
import logger from '../utils/logger';
import prisma from '../utils/db';

export const getAllEmergencyContacts = async (req: express.Request, res: express.Response) => {
    try {
        const userID = req.user as { id: string }
        const emergencyContacts = await prisma.emergencyContact.findMany({
            where: {
                userId: userID.id
            } 
        })
        if (emergencyContacts) {
            logger.info('Emergency Contacts found');
            res.status(200).json(emergencyContacts).end();
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

export const getSingleEmergencyContact = async (req: express.Request, res: express.Response) => {
    try {
        const { id } = req.params;
        const userID = req.user as { id: string }
        const emergencyContact = await prisma.emergencyContact.findFirst({
            where: {
                id: id,
                userId: userID.id
            }
        })


        if (emergencyContact) {
            logger.info('Emergency Contact found!');
            res.status(200).json(emergencyContact).end();
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

        const userID = req.user as { id: string }

        const newEmergencyContact = await prisma.emergencyContact.create({
            data: {
                name: name,
                phoneNum: phoneNum,
                email: email,
                relationship: relationship,
                userId: userID.id
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
        const userID = req.user as { id: string }
        const updatedEmergencyContact = await prisma.emergencyContact.update({
            where: {
                id_userId: {
                    id: id,
                    userId: userID.id
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
        const userID = req.user as { id: string }
        const deletedEmergencyContact = await prisma.emergencyContact.delete({
            where: {
                id_userId: {
                    id: id,
                    userId: userID.id
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