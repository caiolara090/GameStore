import { searchUsersLibrary, toggleUsersGameFavorite } from './../controllers/user/User';
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
import { buyGame, addCredits, hasGame } from "../controllers/user/UserStore";
import { checkJwtToken } from '../middlewares/Auth/CheckJWTToken';

const router = Router();

router.post("/signup", checkDuplicateEmail, checkDuplicateUsername, signUp);
router.post("/login", loginValidation, login);

router.get("/library", checkJwtToken, getUserLibrary);

router.get("/userGames", getUserGames);

router.post("/searchUser", searchUsers);

router.post("/searchUserLibrary", checkJwtToken, searchUsersLibrary);

router.post("/buyGame", checkJwtToken, buyGame);

router.post("/addCredits", checkJwtToken, addCredits);

router.post("/setFavorite", checkJwtToken, toggleUsersGameFavorite);

router.get("/hasGame", hasGame);

export { router as userRouter };
