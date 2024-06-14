import { login } from "../controllers/Auth/Login";
import { loginValidation } from "./../middlewares/Auth/LoginValidation";
import { Router } from "express";
import {
  checkDuplicateEmail,
  checkDuplicateUsername,
} from "../middlewares/Auth/SignupValidation";
import { signUp } from "../controllers/Auth/SignUp";
import { searchUsers } from "../controllers/User";

const router = Router();

router.post("/signup", checkDuplicateEmail, checkDuplicateUsername, signUp);
router.post("/login", loginValidation, login);

router.get("/searchUser", searchUsers);

export { router as userRouter };
