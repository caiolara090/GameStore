import { Router } from 'express';
import { createReview, deleteReview, findReview } from '../controllers/Review';

const router = Router();

router.post('/review', createReview);

router.delete('/review/:reviewId', deleteReview);

router.get('/review', findReview);

export { router as reviewRouter };
