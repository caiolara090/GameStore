import { Router } from 'express';
import { createReview, deleteReview, findReview } from '../controllers/review/Review';
import { checkJwtToken } from '../middlewares/Auth/CheckJWTToken';

const router = Router();

router.post('/review', checkJwtToken, createReview);

router.delete('/review/:reviewId', checkJwtToken, deleteReview);

router.get('/review', findReview);

export { router as reviewRouter };
