"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteAppointmentBooking = exports.updateAppointmentBooking = exports.getAppointmentBookings = exports.getUserAppointmentBookings = exports.createAppointmentBooking = void 0;
const db_1 = __importDefault(require("../utils/db"));
const logger_1 = __importDefault(require("../utils/logger"));
const createAppointmentBooking = async (req, res) => {
    try {
        const { fullName, email, department, location, issueFacing, bookingDate } = req.body;
        if (!fullName || !email || !department || !location || !issueFacing || !bookingDate) {
            logger_1.default.info('Missing required fields');
            res.status(400).json({
                message: "Please provide all the required fields"
            }).end();
            return;
        }
        const existingAppointmentBooking = await db_1.default.appointmentBooking.findFirst({
            where: {
                email: email
            }
        });
        if (existingAppointmentBooking) {
            logger_1.default.info('Appointment already exists');
            res.status(400).json({
                message: "Appointment already exists"
            }).end();
        }
        // For Postman testing
        // const userID = req.user as { id: string }
        // For application: Flutter
        const userID = req.body.userId;
        const newAppointmentBooking = await db_1.default.appointmentBooking.create({
            data: {
                fullName: fullName,
                email: email,
                department: department,
                location: location,
                issueFacing: issueFacing,
                bookingDate: bookingDate,
                // For Postman testing
                // userId: userID.id
                // For flutter application
                userId: userID
            }
        });
        if (newAppointmentBooking) {
            logger_1.default.info('Appointment created');
            res.status(200).json(newAppointmentBooking).end();
        }
        else {
            logger_1.default.info('Appointment not created');
            res.send({
                message: "Appointment not created"
            });
        }
    }
    catch (error) {
        logger_1.default.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
};
exports.createAppointmentBooking = createAppointmentBooking;
const getUserAppointmentBookings = async (req, res) => {
    try {
        // For Postman testing
        // const userID = req.user as { id: string }
        // For application: Flutter
        const { userId } = req.params;
        const user = await db_1.default.user.findUnique({
            where: {
                id: userId
            }, include: {
                AppointmentBookings: true
            }
        });
        if (user.AppointmentBookings) {
            logger_1.default.info('Appointment bookings found');
            res.status(200).json(user.AppointmentBookings).end();
        }
        else {
            logger_1.default.info('No appointment bookings found');
            res.send({
                message: "No appointment bookings found"
            });
        }
    }
    catch (error) {
        logger_1.default.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
};
exports.getUserAppointmentBookings = getUserAppointmentBookings;
const getAppointmentBookings = async (req, res) => {
    try {
        const appointmentBooking = await db_1.default.appointmentBooking.findMany();
        if (appointmentBooking) {
            logger_1.default.info('Appointment bookings found');
            res.status(200).json(appointmentBooking).end();
        }
        else {
            logger_1.default.info('No appointment bookings found');
            res.send({
                message: "No appointment bookings found"
            });
        }
    }
    catch (error) {
        logger_1.default.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
};
exports.getAppointmentBookings = getAppointmentBookings;
const updateAppointmentBooking = async (req, res) => {
    try {
        const { id } = req.params;
        const { fullName, email, department, location, issueFacing, bookingDate } = req.body;
        // For Postman testing
        // const userID = req.user as { id: string }
        // For application: Flutter
        const userID = req.body.userId;
        const updatedAppointmentBooking = await db_1.default.appointmentBooking.update({
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
        if (exports.updateAppointmentBooking) {
            logger_1.default.info('Appointment booking updated');
            res.status(200).json(exports.updateAppointmentBooking).end();
        }
        else {
            logger_1.default.info('Appointment booking not updated');
            res.send({
                message: "Appointment booking not updated"
            });
        }
    }
    catch (error) {
        logger_1.default.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
};
exports.updateAppointmentBooking = updateAppointmentBooking;
const deleteAppointmentBooking = async (req, res) => {
    try {
        const { id } = req.params;
        // For Postman testing
        // const userID = req.user as { id: string }
        // For application: Flutter
        const userID = req.body.userId;
        const deletedAppointmentBooking = await db_1.default.appointmentBooking.delete({
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
            logger_1.default.info('Appointment booking deleted');
            res.status(200).json(deletedAppointmentBooking).end();
        }
        else {
            logger_1.default.info('Appointment booking not deleted');
            res.send({
                message: "Appointment booking not deleted"
            });
        }
    }
    catch (error) {
        logger_1.default.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
};
exports.deleteAppointmentBooking = deleteAppointmentBooking;
//# sourceMappingURL=appointmentBooking.js.map