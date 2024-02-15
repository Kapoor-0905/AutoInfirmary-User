import { createUserHandler } from "controllers/user.controller";
import express from "express";
import validateResource from "middleware/validateResourse";
import { createUserSchema } from "schema/user.schema";

const router = express.Router();

router.post("/api/users", validateResource(createUserSchema), createUserHandler);

export default router;