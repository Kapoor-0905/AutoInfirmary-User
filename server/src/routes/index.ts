import express from "express";

const router = express.Router();

router.get("/healthcheck", (_, res) => {
    res.status(200)
    res.json({
        message: "Server is up and running, all systems are operational!"
    })
})

export default router;