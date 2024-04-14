import 'dotenv/config';

export default {
    jwtSecret: process.env.JWT_SECRET,
    bcryptSalt: process.env.BCRYPT_SALT,
    port: process.env.PORT || 3000,
}