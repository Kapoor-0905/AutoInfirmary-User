import express from 'express';
import prisma from '../utils/db';
import logger from '../utils/logger';
import { P } from 'pino';

export const createAppointmentBooking = async (req : express.Request, res: express.Response) => {
    try {
        const { fullName, email, department, location, issueFacing, bookingDate } = req.body;

        if (!fullName|| !email ||!department || !location || !issueFacing || !bookingDate) {
            logger.info('Missing required fields');
            res.status(400).json({
                message: "Please provide all the required fields"
            }).end()
            return;
        }

        const existingAppointmentBooking = await prisma.appointmentBooking.findFirst({
            where: {
                email: email
            }
        })

        if (existingAppointmentBooking) {
            logger.info('Appointment already exists');
            res.status(400).json({
                message: "Appointment already exists"
            }).end();
        }
        // For Postman testing
        const userID = req.user as { id: string }

        // For application: Flutter
        // const userID = req.body.userId
        
        const newAppointmentBooking = await prisma.appointmentBooking.create({
            data: {
                fullName: fullName,
                email: email,
                department: department,
                location: location,
                issueFacing: issueFacing,
                bookingDate: bookingDate,
                // For Postman testing
                userId: userID.id

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

export const getUserAppointmentBookings = async (req: express.Request, res: express.Response) => {
    try {
        // For Postman testing
        // const userID = req.user as { id: string }

        // For application: Flutter
        const { userId } = req.params;

        const user = await prisma.user.findUnique({
            where: {
                id: userId
            }, include: {
                AppointmentBookings: true
            }
        })
        if (user.AppointmentBookings) {
            logger.info('Appointment bookings found');
            res.status(200).json(user.AppointmentBookings).end();
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

export const getAppointmentBookings = async (req: express.Request, res: express.Response) => {
    try {
        const appointmentBooking = await prisma.appointmentBooking.findMany();
        if (appointmentBooking) {
            logger.info('Appointment bookings found');
            res.status(200).json(appointmentBooking).end();
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

export const updateAppointmentBooking = async (req: express.Request, res: express.Response) => {
    try {
        const { id } = req.params;
        const { fullName, email, department, location, issueFacing, bookingDate } = req.body;

        // For Postman testing
        // const userID = req.user as { id: string }

        // For application: Flutter
        const userID = req.body.userId


        const updatedAppointmentBooking = await prisma.appointmentBooking.update({
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
                bookingDate: bookingDate
            }
        });
        if (updateAppointmentBooking) {
            logger.info('Appointment booking updated');
            res.status(200).json(updateAppointmentBooking).end();
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

export const deleteAppointmentBooking = async (req: express.Request, res: express.Response) => {
    try {
        const { id } = req.params;
        // For Postman testing
        // const userID = req.user as { id: string }

        // For application: Flutter
        const userID = req.body.userId

        const deletedAppointmentBooking = await prisma.appointmentBooking.delete({
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
        if (deletedAppointmentBooking) {
            logger.info('Appointment booking deleted');
            res.status(200).json(deletedAppointmentBooking).end();
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