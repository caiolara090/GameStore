import { login } from "../controllers/Auth/Login";
import { loginValidation } from "./../middlewares/Auth/LoginValidation";
import { Router } from "express";
import {
  checkDuplicateEmail,
  checkDuplicateUsername,
} from "../middlewares/Auth/SignupValidation";
import { signUp } from "../controllers/Auth/SignUp";
import { 
  getUserLibrary, 
  getUserGames 
} from "../controllers/UserLibrary";

const router = Router();

router.post("/signup", checkDuplicateEmail, checkDuplicateUsername, signUp);
router.post("/login", loginValidation, login);

router.get("/library", getUserLibrary);

router.get("/userGames", getUserGames);

export { router as userRouter };
