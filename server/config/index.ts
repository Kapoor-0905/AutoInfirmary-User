import 'dotenv/config';

export default {
    jwtSecret: process.env.JWT_SECRET,
    bcryptSalt: process.env.BCRYPT_SALT
}