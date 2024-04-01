"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.updateUser = exports.deleteUser = exports.getSingleUser = exports.getAllUsers = void 0;
const logger_1 = __importDefault(require("../utils/logger"));
const db_1 = __importDefault(require("../utils/db"));
// export const getSingleUser = async (req: express.Request, res: express.Response) => {
//     try {
//         const { id } = req.params;
//         const user = await prisma.user.findUnique({
//             where: {
//                 id: id
//             }
//         })
//         if (user) {
//             logger.info('User found!');
//             res.status(200).json(user).end();
//         } else {
//             logger.info('user not found');
//             res.send({
//                 message: "user not found"
//             })
//         }
//     } catch (error) {
//         logger.info(error);
//         return res.json({
//             message: "something went wrong!"
//         }).status(400);
//     }
// }
const getAllUsers = async (req, res) => {
    try {
        const users = await db_1.default.user.findMany({
            select: {
                id: true,
                email: true,
                firstName: true,
                lastName: true,
                address: true,
                uniqueOrgCode: true
            }
        });
        console.log(req.user);
        if (users) {
            logger_1.default.info('Users found');
            res.status(200).json(users).end();
        }
        else {
            logger_1.default.info('users not found');
            res.send({
                message: "user not found"
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
exports.getAllUsers = getAllUsers;
const getSingleUser = async (req, res) => {
    try {
        const { id } = req.params;
        const user = await db_1.default.user.findUnique({
            where: {
                id: id
            }
        });
        if (user) {
            logger_1.default.info('User found!');
            res.status(200).json(user).end();
        }
        else {
            logger_1.default.info('user not found');
            res.send({
                message: "user not found"
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
exports.getSingleUser = getSingleUser;
const deleteUser = async (req, res) => {
    try {
        const { id } = req.params;
        const deletedUser = await db_1.default.user.delete({
            where: {
                id: id
            }
        });
        if (deletedUser) {
            logger_1.default.info('User deleted');
            res.status(200).json(deletedUser).end();
        }
        else {
            logger_1.default.info('User not found');
            res.send({
                message: "User not found"
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
exports.deleteUser = deleteUser;
const updateUser = async (req, res) => {
    try {
        const { id } = req.params;
        const { email, password, firstName, lastName, address, phoneNum } = req.body;
        const updatedUser = await db_1.default.user.update({
            where: {
                id: id
            },
            data: {
                email: email,
                auth: {
                    update: {
                        password: password
                    }
                },
                firstName: firstName,
                lastName: lastName,
                address: address,
                phoneNum: phoneNum,
                uniqueOrgCode: req.body.uniqueOrgCode
            }
        });
        if (updatedUser) {
            logger_1.default.info('User updated');
            res.status(200).json(updatedUser).end();
        }
        else {
            logger_1.default.info('User not found');
            res.send({
                message: "User not found"
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
exports.updateUser = updateUser;
//# sourceMappingURL=users.js.map