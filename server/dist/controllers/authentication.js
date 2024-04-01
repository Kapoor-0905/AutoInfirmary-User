"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.register = exports.login = void 0;
const helpers_1 = require("../helpers");
const db_1 = __importDefault(require("../utils/db"));
const logger_1 = __importDefault(require("../utils/logger"));
const bcryptSalt = process.env.BCRYPT_SALT;
const login = async (req, res) => {
    try {
        const { email, password } = req.body;
        if (!email || !password) {
            logger_1.default.info('Missing required fields');
            res.status(400).json({
                message: "Missing required fields"
            }).end();
            return;
        }
        const user = await db_1.default.user.findUnique({
            where: {
                email: email
            }
        });
        if (!user) {
            res.status(403).json({
                message: "User not found"
            }).end();
            return;
        }
        const match = await (0, helpers_1.comparePassword)(password, user.auth.password);
        if (!match) {
            res.status(403).json({
                message: "Password does not match!"
            }).end();
            return;
        }
        const salt = (0, helpers_1.random)();
        user.auth.sessionToken = (0, helpers_1.authentication)(salt, user.id.toString());
        await db_1.default.user.update({
            where: {
                id: user.id
            },
            data: {
                auth: {
                    update: {
                        sessionToken: user.auth.sessionToken
                    }
                }
            }
        });
        const token = await (0, helpers_1.createJWT)(user);
        res.cookie('sessionToken', user.auth.sessionToken, { domain: 'localhost', path: '/', httpOnly: true, secure: true, sameSite: 'none' });
        res.status(200).json({
            user,
            token
        }).end();
    }
    catch (error) {
        logger_1.default.info(error);
        return res.status(400).json({
            message: "Something went wrong"
        }).end();
    }
};
exports.login = login;
const register = async (req, res) => {
    try {
        const { email, password, firstName, lastName } = req.body;
        if (!email || !password || !firstName || !lastName) {
            logger_1.default.info('Missing required fields');
            res.status(400).json({
                message: "Missing required fields"
            }).end();
            return;
        }
        const existingUser = await db_1.default.user.findUnique({
            where: {
                email: email
            }
        });
        if (existingUser) {
            logger_1.default.info('User already exists');
            res.status(400).json({
                message: "User already exists"
            }).end();
            return;
        }
        const salt = (0, helpers_1.random)();
        const user = await db_1.default.user.create({
            data: {
                email: email,
                firstName: firstName,
                lastName: lastName,
                auth: {
                    set: {
                        salt,
                        password: await (0, helpers_1.hashedPassword)(password),
                        sessionToken: (0, helpers_1.random)()
                    }
                },
                phoneNum: req.body.phoneNum,
                address: req.body.address,
                uniqueOrgCode: req.body.uniqueOrgCode
            }
        });
        if (user) {
            logger_1.default.info('user created');
            const token = await (0, helpers_1.createJWT)(user);
            logger_1.default.info(token);
            const sessionToken = await db_1.default.user.findFirst({
                select: {
                    id: true,
                    auth: {
                        select: {
                            sessionToken: true
                        }
                    }
                }
            });
            res.status(200).send({
                message: "user created seccessfully",
                token,
                sessionToken
            }).end();
        }
        else {
            logger_1.default.info('user not created');
            res.send({
                message: "user not created"
            });
        }
    }
    catch (error) {
        logger_1.default.info(error);
        return res.status(400).json({
            message: "Something went wrong"
        }).end();
    }
};
exports.register = register;
//# sourceMappingURL=authentication.js.map