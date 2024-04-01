"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.comparePassword = exports.hashedPassword = exports.authentication = exports.random = exports.createJWT = void 0;
const crypto_1 = __importDefault(require("crypto"));
const bcrypt_1 = __importDefault(require("bcrypt"));
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const config_1 = __importDefault(require("../config"));
const jwtSecret = config_1.default.jwtSecret;
const salt = Number(config_1.default.bcryptSalt);
const createJWT = async (user) => {
    const token = jsonwebtoken_1.default.sign({
        email: user.email,
        id: user.id,
    }, jwtSecret);
    return token;
};
exports.createJWT = createJWT;
const random = () => {
    return crypto_1.default.randomBytes(128).toString('base64');
};
exports.random = random;
const authentication = (salt, password) => {
    return crypto_1.default.createHmac('sha256', [salt, password].join('/')).update(jwtSecret).digest('hex');
};
exports.authentication = authentication;
const hashedPassword = async (password) => {
    const hashPass = (await bcrypt_1.default.hash(password.toString(), salt)).toString();
    return hashPass;
};
exports.hashedPassword = hashedPassword;
const comparePassword = async (password, hash) => {
    const match = await bcrypt_1.default.compare(password.toString(), hash.toString());
    return match;
};
exports.comparePassword = comparePassword;
//# sourceMappingURL=index.js.map