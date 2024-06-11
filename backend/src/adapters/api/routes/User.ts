import { login } from '../controllers/Auth/Login';
import { loginValidation } from './../middlewares/Auth/LoginValidation';
import { Router } from "express";
import { checkDuplicateEmail, checkDuplicateUsername } from '../middlewares/Auth/SignupValidation';
import { signUp } from '../controllers/Auth/SignUp';

const router = Router();

router.post('/login', loginValidation, login);

router.post('/signup', checkDuplicateEmail, checkDuplicateUsername, signUp);

export { router as userRouter };