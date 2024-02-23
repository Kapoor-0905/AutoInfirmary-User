import express from "express";
import userModel from "../models/user.model";
const router = express.Router();


router.get("/healthcheck", (_, res) => {
    res.status(200)
    res.json({
        message: "Server is up and running, all systems are operational!"
    })
})

// router.post('/register', async(req, res) => {
//     try {
//         const user = new userModel(req.body);
//         await user.save();
//         res.status(201);
//         res.json({
//             message: 'User created successfully'
//         });
//     } catch (error) {
//         console.error(error);
//     }
// });

export default router;
//gM7kk1cdbpG5Ekum