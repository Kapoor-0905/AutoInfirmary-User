import express from 'express';
import userModel from '../models/user.model';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';

const router = express.Router();

router.post('/register', async(req, res) => {
    try {
        const user = new userModel(req.body);
        const existingUser = await userModel.findOne({ email: user.email });
        if (existingUser) {
            return res.status(400).json({ message: "User already exists" }); // 400 = Bad Request
        }
        const encryptedPassword = await bcrypt.hash(user.password, 8);
        let newuser = new userModel({
            name: req.body.name,
            email: req.body.email,
            password: encryptedPassword,
            phoneNumber: req.body.phoneNumber,
            uniqueOrgCode: req.body.uniqueOrgCode,
            address: req.body.address
        });

        await newuser.save();
        res.json(newuser);
    } catch (error) {
        console.error(error);
    }
});


router.post('/login', async (req, res) => { 
    try {
        const { email, password } = req.body;
        const exisitingUser = await userModel.findOne({ email });
        if (!exisitingUser) {
            return res.status(404).json({ message: "User does not exist" });
        }
        const isPasswordCorrect = await bcrypt.compare(password, exisitingUser.password);
        if (!isPasswordCorrect) {
            return res.status(400).json({ message: "Invalid credentials" }); // 400 = Bad Request
        }

        const token = jwt.sign({
            id: exisitingUser._id
        }, "passwordKey");

        res.json({token, ...exisitingUser._id});

    } catch (error) {
        
    }
});
export default router