"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteEmergencyAppointmentBooking = exports.updateEmergencyAppointmentBooking = exports.getEmergencyAppointmentBookings = exports.getUserEmergencyAppointmentBookings = exports.createEmergencyBooking = void 0;
const db_1 = __importDefault(require("../utils/db"));
const logger_1 = __importDefault(require("../utils/logger"));
const createEmergencyBooking = async (req, res) => {
    try {
        const { fullName, email, department, location, issueFacing, bookingDate, approxTimeOfArrival } = req.body;
        if (!fullName || !email || !department || !location || !issueFacing || !bookingDate || !approxTimeOfArrival) {
            logger_1.default.info('Missing required fields');
            res.status(400).json({
                message: "Please provide all the required fields"
            }).end();
            return;
        }
        const existingAppointmentBooking = await db_1.default.emergencyBooking.findFirst({
            where: {
                email: email
            }
        });
        if (existingAppointmentBooking) {
            logger_1.default.info('Emergency appointment already exists');
            res.status(400).json({
                message: "Emergency appointment already exists"
            }).end();
        }
        // For Postman testing
        // const userID = req.user as { id: string }
        // For application: Flutter
        const userID = req.body.userId;
        const newAppointmentBooking = await db_1.default.emergencyBooking.create({
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
exports.createEmergencyBooking = createEmergencyBooking;
const getUserEmergencyAppointmentBookings = async (req, res) => {
    try {
        // For Postman testing
        // const userID = req.user as { id: string }
        // For application: Flutter
        const { userId } = req.params;
        const user = await db_1.default.user.findUnique({
            where: {
                id: userId
            }, include: {
                EmergencyBookings: true
            }
        });
        if (user.EmergencyBookings) {
            logger_1.default.info('Appointment bookings found');
            res.status(200).json(user.EmergencyBookings).end();
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
exports.getUserEmergencyAppointmentBookings = getUserEmergencyAppointmentBookings;
const getEmergencyAppointmentBookings = async (req, res) => {
    try {
        const emergencyAppointmentBooking = await db_1.default.emergencyBooking.findMany();
        if (emergencyAppointmentBooking) {
            logger_1.default.info('Appointment bookings found');
            res.status(200).json(emergencyAppointmentBooking).end();
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
exports.getEmergencyAppointmentBookings = getEmergencyAppointmentBookings;
const updateEmergencyAppointmentBooking = async (req, res) => {
    try {
        const { id } = req.params;
        const { fullName, email, department, location, issueFacing, bookingDate, approxTimeOfArrival } = req.body;
        // For Postman testing
        // const userID = req.user as { id: string }
        // For application: Flutter
        const userID = req.body.userId;
        const updatedEmergencyAppointmentBooking = await db_1.default.emergencyBooking.update({
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
        if (exports.updateEmergencyAppointmentBooking) {
            logger_1.default.info('Appointment booking updated');
            res.status(200).json(exports.updateEmergencyAppointmentBooking).end();
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
exports.updateEmergencyAppointmentBooking = updateEmergencyAppointmentBooking;
const deleteEmergencyAppointmentBooking = async (req, res) => {
    try {
        const { id } = req.params;
        // For Postman testing
        // const userID = req.user as { id: string }
        // For application: Flutter
        const userID = req.body.userId;
        const deletedEmergencyAppointmentBooking = await db_1.default.emergencyBooking.delete({
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
        if (exports.deleteEmergencyAppointmentBooking) {
            logger_1.default.info('Appointment booking deleted');
            res.status(200).json(exports.deleteEmergencyAppointmentBooking).end();
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
exports.deleteEmergencyAppointmentBooking = deleteEmergencyAppointmentBooking;
//# sourceMappingURL=emergencyBooking.js.map