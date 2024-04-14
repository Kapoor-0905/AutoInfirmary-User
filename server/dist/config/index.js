"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
require("dotenv/config");
exports.default = {
    jwtSecret: process.env.JWT_SECRET,
    bcryptSalt: process.env.BCRYPT_SALT,
    port: process.env.port || 3000
};
//# sourceMappingURL=index.js.map