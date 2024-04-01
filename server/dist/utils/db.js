"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.connect = void 0;
const client_1 = require("@prisma/client");
const logger_1 = __importDefault(require("./logger"));
const prisma = new client_1.PrismaClient();
const connect = async () => {
    await prisma.$connect();
    logger_1.default.info("Connected to the database");
};
exports.connect = connect;
(0, exports.connect)();
exports.default = prisma;
//# sourceMappingURL=db.js.map