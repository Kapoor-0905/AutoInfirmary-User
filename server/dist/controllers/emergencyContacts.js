"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteEmergencyContact = exports.updateEmergencyContact = exports.createEmergencyContact = exports.getAllUserEmergencyContacts = void 0;
const logger_1 = __importDefault(require("../utils/logger"));
const db_1 = __importDefault(require("../utils/db"));
const getAllUserEmergencyContacts = async (req, res) => {
    try {
        // For Postman testing
        // const userID = req.user as { id: string }
        // For application: Flutter
        const { userId } = req.params;
        const user = await db_1.default.user.findUnique({
            where: {
                // For Postman testing
                // id: userID.id
                // For flutter application
                id: userId
            }, include: {
                EmergencyContacts: true
            }
        });
        if (user.EmergencyContacts) {
            logger_1.default.info('Emergency Contacts found');
            res.status(200).json(user.EmergencyContacts).end();
        }
        else {
            logger_1.default.info('Emergency Contacts not found');
            res.send({
                message: "Emergency Contacts not found"
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
exports.getAllUserEmergencyContacts = getAllUserEmergencyContacts;
const createEmergencyContact = async (req, res) => {
    try {
        const { name, phoneNum, email, relationship } = req.body;
        if (!name || !phoneNum || !email || !relationship) {
            logger_1.default.info('Missing required fields');
            res.status(400).json({
                message: "Missing required fields"
            }).end();
            return;
        }
        const existingEmergencyContact = await db_1.default.emergencyContact.findFirst({
            where: {
                email: email
            }
        });
        if (existingEmergencyContact) {
            logger_1.default.info('Contact already exists');
            res.status(400).json({
                message: "Contact already exists"
            }).end();
            return;
        }
        // For Postman testing
        // const userID = req.user as { id: string }
        // For application: Flutter
        const userID = req.body.userId;
        const newEmergencyContact = await db_1.default.emergencyContact.create({
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
            logger_1.default.info('Emergency Contact created');
            res.status(200).json(newEmergencyContact).end();
        }
        else {
            logger_1.default.info('Emergency Contact not created');
            res.send({
                message: "Emergency Contact not created"
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
exports.createEmergencyContact = createEmergencyContact;
const updateEmergencyContact = async (req, res) => {
    try {
        const { id } = req.params;
        const { name, phoneNum, email, relationship } = req.body;
        // For Postman testing
        // const userID = req.user as { id: string }
        // For application: Flutter
        const userID = req.body.userId;
        const updatedEmergencyContact = await db_1.default.emergencyContact.update({
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
            logger_1.default.info('Emergency Contact updated');
            res.status(200).json(updatedEmergencyContact).end();
        }
        else {
            logger_1.default.info('Emergency Contact not found');
            res.send({
                message: "Emergency Contact not found"
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
exports.updateEmergencyContact = updateEmergencyContact;
const deleteEmergencyContact = async (req, res) => {
    try {
        const { id } = req.params;
        // For Postman testing
        // const userID = req.user as { id: string }
        // For application: Flutter
        const userID = req.body.userId;
        const deletedEmergencyContact = await db_1.default.emergencyContact.delete({
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
            logger_1.default.info('Emergency Contact deleted');
            res.status(200).json(deletedEmergencyContact).end();
        }
        else {
            logger_1.default.info('Emergency Contact not found');
            res.send({
                message: "Emergency Contact not found"
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
exports.deleteEmergencyContact = deleteEmergencyContact;
//# sourceMappingURL=emergencyContacts.js.map