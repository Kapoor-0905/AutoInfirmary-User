import 'dotenv/config';

export default {
    jwtSecret: process.env.JWT_SECRET,
    bcryptSalt: process.env.BCRYPT_SALT,
    port: process.env.port || 3000
}