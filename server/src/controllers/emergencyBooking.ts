import express from 'express';
import prisma from '../utils/db';
import logger from '../utils/logger';

export const createEmergencyBooking = async (req: express.Request, res: express.Response) => {
    try {
        const { fullName, email, department, location, issueFacing, bookingDate, approxTimeOfArrival } = req.body;

        if (!fullName || !email || !department || !location || !issueFacing || !bookingDate || !approxTimeOfArrival) {
            logger.info('Missing required fields');
            res.status(400).json({
                message: "Please provide all the required fields"
            }).end()
            return;
        }

        const existingAppointmentBooking = await prisma.emergencyBooking.findFirst({
            where: {
                email: email
            }
        })

        if (existingAppointmentBooking) {
            logger.info('Emergency appointment already exists');
            res.status(400).json({
                message: "Emergency appointment already exists"
            }).end();
        }
        // For Postman testing
        // const userID = req.user as { id: string }

        // For application: Flutter
        const userID = req.body.userId

        const newAppointmentBooking = await prisma.emergencyBooking.create({
            data: {
                fullName: fullName,
                email: email,
                department: department,
                location: location,
                issueFacing: issueFacing,
                bookingDate: bookingDate,
                approxTimeOfArrival: approxTimeOfArrival,
                // For Postman testing
                userId: userID

                // For flutter application
                // userId: userID
            }
        });

        if (newAppointmentBooking) {
            logger.info('Appointment created');
            res.status(200).json(newAppointmentBooking).end();
        } else {
            logger.info('Appointment not created');
            res.send({
                message: "Appointment not created"
            })
        }
    } catch (error) {
        logger.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
}

export const getUserEmergencyAppointmentBookings = async (req: express.Request, res: express.Response) => {
    try {
        // For Postman testing
        // const userID = req.user as { id: string }

        // For application: Flutter
        const { userId } = req.params;

        const user = await prisma.user.findUnique({
            where: {
                id: userId
            }, include: {
                EmergencyBookings: true
            }
        })
        if (user.EmergencyBookings) {
            logger.info('Appointment bookings found');
            res.status(200).json(user.EmergencyBookings).end();
        } else {
            logger.info('No appointment bookings found');
            res.send({
                message: "No appointment bookings found"
            })
        }
    } catch (error) {
        logger.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
}

export const getEmergencyAppointmentBookings = async (req: express.Request, res: express.Response) => {
    try {
        const emergencyAppointmentBooking = await prisma.emergencyBooking.findMany();
        if (emergencyAppointmentBooking) {
            logger.info('Appointment bookings found');
            res.status(200).json(emergencyAppointmentBooking).end();
        } else {
            logger.info('No appointment bookings found');
            res.send({
                message: "No appointment bookings found"
            })
        }
    } catch (error) {
        logger.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
}

export const updateEmergencyAppointmentBooking = async (req: express.Request, res: express.Response) => {
    try {
        const { userID, id } = req.params;
        const { fullName, email, department, location, issueFacing, bookingDate, approxTimeOfArrival } = req.body;

        // For Postman testing
        // const userID = req.user as { id: string }

        // For application: Flutter
        // const userID = req.body.userId


        const updatedEmergencyAppointmentBooking = await prisma.emergencyBooking.update({
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
                fullName: fullName,
                email: email,
                department: department,
                location: location,
                issueFacing: issueFacing,
                bookingDate: bookingDate,
                approxTimeOfArrival: approxTimeOfArrival
            }
        });
        if (updateEmergencyAppointmentBooking) {
            logger.info('Appointment booking updated');
            res.status(200).json(updateEmergencyAppointmentBooking).end();
        } else {
            logger.info('Appointment booking not updated');
            res.send({
                message: "Appointment booking not updated"
            })
        }
    } catch (error) {
        logger.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
}

export const deleteEmergencyAppointmentBooking = async (req: express.Request, res: express.Response) => {
    try {
        const { userID, id } = req.params;
        // For Postman testing
        // const userID = req.user as { id: string }

        // For application: Flutter
        // const userID = req.body.userId

        const deletedEmergencyAppointmentBooking = await prisma.emergencyBooking.delete({
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
        if (deleteEmergencyAppointmentBooking) {
            logger.info('Appointment booking deleted');
            res.status(200).json(deleteEmergencyAppointmentBooking).end();
        } else {
            logger.info('Appointment booking not deleted');
            res.send({
                message: "Appointment booking not deleted"
            })
        }
    } catch (error) {
        logger.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
}