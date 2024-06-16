import { searchUsersLibrary } from './../controllers/user/User';
import { login } from "../controllers/Auth/Login";
import { loginValidation } from "./../middlewares/Auth/LoginValidation";
import { Router } from "express";
import { checkDuplicateEmail, checkDuplicateUsername,} from "../middlewares/Auth/SignupValidation";
import { signUp } from "../controllers/Auth/SignUp";
import { 
  getUserLibrary, 
  getUserGames 
} from "../controllers/user/UserLibrary";
import { searchUsers } from "../controllers/user/User";

const router = Router();

router.post("/signup", checkDuplicateEmail, checkDuplicateUsername, signUp);
router.post("/login", loginValidation, login);

router.get("/library", getUserLibrary);

router.get("/userGames", getUserGames);

router.post("/searchUser", searchUsers);
router.post("/searchUserLibrary", searchUsersLibrary);

export { router as userRouter };
