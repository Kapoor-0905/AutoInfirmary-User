"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const logger_1 = __importDefault(require("../utils/logger"));
exports.default = (router) => {
    router.get('/api/healthcheck', (req, res) => {
        logger_1.default.info('Healthcheck');
        res.send({
            message: "Healthcheck endpoint"
        });
    });
    router.get('/', (req, res) => {
        logger_1.default.info('route working!');
        res.send({
            message: "Hello, from express"
        });
    });
};
//# sourceMappingURL=api.js.map