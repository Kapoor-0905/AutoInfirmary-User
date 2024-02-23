import crypto from 'crypto';

const SECRET_KEY = '';

export const random = () => {
    return crypto.randomBytes(128).toString('base64');
}

export const authentication = (salt: String, password: String) => {
    return crypto.createHmac('sha256', [salt, password].join('/')).update(SECRET_KEY).digest('hex');
}

