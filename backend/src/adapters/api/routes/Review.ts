import { Router } from "express";
import {
  createReview,
  deleteReview,
  findReview,
} from "../controllers/review/Review";
import { checkJwtToken } from "../middlewares/Auth/CheckToken";

const router = Router();

router.post("/review", checkJwtToken, createReview);

router.delete("/review", checkJwtToken, deleteReview);

router.get("/review", findReview);

export { router as reviewRouter };
