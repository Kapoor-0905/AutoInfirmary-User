import express from 'express';
import logger from '../utils/logger';
import prisma from '../utils/db';

export const getSingleEmergencyContact = async (req: express.Request, res: express.Response) => {
    try {
        const { id } = req.params;
        const emergencyContact = await prisma.emergencyContact.findFirst({
            where: {
                id: id
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
        }).sendStatus(400);
    }
}

export const getAllEmergencyContacts = async (req: express.Request, res: express.Response) => {
    try {
        const emergencyContacts = await prisma.emergencyContact.findMany({
            select: {
                id: true,
                name: true,
                phone: true,
                email: true,
                address: true
            }
        });

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
        }).sendStatus(400);
    }
}