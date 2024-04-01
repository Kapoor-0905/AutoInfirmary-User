"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const authentication_1 = __importDefault(require("./authentication"));
const api_1 = __importDefault(require("./api"));
const users_1 = __importDefault(require("./users"));
const emergencyContact_1 = __importDefault(require("./emergencyContact"));
const appointmentBooking_1 = __importDefault(require("./appointmentBooking"));
const emergencyBooking_1 = __importDefault(require("./emergencyBooking"));
const router = express_1.default.Router();
exports.default = () => {
    (0, authentication_1.default)(router);
    (0, api_1.default)(router);
    (0, users_1.default)(router);
    (0, emergencyContact_1.default)(router);
    (0, appointmentBooking_1.default)(router);
    (0, emergencyBooking_1.default)(router);
    return router;
};
//# sourceMappingURL=index.js.map