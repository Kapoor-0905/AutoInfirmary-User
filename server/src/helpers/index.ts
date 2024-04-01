import crypto from 'crypto';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import config from '../config';
import { User } from '@prisma/client';

const jwtSecret = config.jwtSecret;
const salt = Number(config.bcryptSalt as string);

export const createJWT = async (user: User) => {
    const token = jwt.sign({
        email: user.email,
        id: user.id,
    }, jwtSecret)
    return token
}

export const random = () => {
    return crypto.randomBytes(128).toString('base64');
}

export const authentication = (salt: String, password: String) => {
    return crypto.createHmac('sha256', [salt, password].join('/')).update(jwtSecret).digest('hex');
}

export const hashedPassword = async (password: String) => {
    const hashPass = (await bcrypt.hash(password.toString(), salt)).toString()
    return hashPass
}

export const comparePassword = async (password: String, hash: String) => {
    const match = await bcrypt.compare(password.toString(), hash.toString())
    return match
}

