import { Router } from "express";
import { searchGames } from "../controllers/game/Game";

const router = Router();

router.get("/searchGame", searchGames);

export { router as gameRouter };
