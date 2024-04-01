"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.isAuthenticated = exports.isOwner = void 0;
const lodash_1 = require("lodash");
const logger_1 = __importDefault(require("../utils/logger"));
const db_1 = __importDefault(require("../utils/db"));
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const jwtSecret = process.env.JWT_SECRET;
const isOwner = async (req, res, next) => {
    try {
        const { id } = req.params;
        const currentUserId = (0, lodash_1.get)(req, 'identity.id');
        if (!currentUserId) {
            return res.json({
                message: "not authorized!"
            }).status(403);
        }
        if (currentUserId.toString() !== id) {
            return res.json({
                message: "not authorized!"
            }).status(403);
        }
        next();
    }
    catch (error) {
        logger_1.default.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
};
exports.isOwner = isOwner;
const isAuthenticated = async (req, res, next) => {
    try {
        const jwtToken = req.headers.authorization || req.headers['authorization'];
        const sessionToken = req.cookies.sessionToken || req.cookies['session-token'];
        if (!jwtToken && !sessionToken) {
            return res.json({
                message: 'not authorized!'
            }).status(403).end();
            return;
        }
        const [, token] = jwtToken.split(' ');
        if (!token) {
            res.json({
                message: 'not a valid token!'
            }).status(403).end();
            return;
        }
        const existingUser = await db_1.default.user.findFirst({
            where: {
                auth: {
                    is: {
                        sessionToken: sessionToken
                    }
                }
            }
        });
        if (!existingUser) {
            return res.json({
                message: "user not found!"
            }).status(403);
        }
        (0, lodash_1.merge)(req, {
            identity: existingUser
        });
        const user = jsonwebtoken_1.default.verify(token, jwtSecret); // Add type annotation for 'id'
        req.user = user;
        return next();
    }
    catch (error) {
        logger_1.default.info(error);
        return res.json({
            message: "something went wrong!"
        }).status(400);
    }
};
exports.isAuthenticated = isAuthenticated;
//# sourceMappingURL=index.js.map