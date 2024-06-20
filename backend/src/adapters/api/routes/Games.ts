import { Router } from "express";
import { searchGames, getPopularGames } from "../controllers/game/Game";

const router = Router();

router.post("/searchGame", searchGames);

router.get("/popular", getPopularGames);

export { router as gameRouter };
