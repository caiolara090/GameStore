import { Router } from "express";
import { searchGames } from "../controllers/Game";

const router = Router();

router.get("/searchGame", searchGames);

export { router as gameRouter };
