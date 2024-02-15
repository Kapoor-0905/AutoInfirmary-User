import {Request, Response,  NextFunction } from 'express';
import jwt from 'jsonwebtoken';

const auth = async (req: Request, res: Response, next: NextFunction) => { 
    try {
        const token = req.header("x-auth-token");
        if (!token) {
            return res.status(401).json({ message: "No authentication token, access denied" });
        }

        const verified: any = jwt.verify(token, "passwordKey");
        if (!verified) {
            return res.status(401).json({ message: "Token verification failed, authorization denied" });
        }

        req.user = verified.id;
        req.headers.authorization = token;
        next();
    } catch (error) {
        
    }
};

export default auth;