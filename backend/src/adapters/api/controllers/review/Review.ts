import { Request, Response } from 'express';
import { IReviewServices } from '../../../../domain/ports/Review/ReviewServices';
import { ReviewServices } from '../../../../domain/services/ReviewServices';
import { IReview } from '../../../../domain/entities/Review';
import { IReviewRequest } from '../../../../domain/entities/Review';

export const createReview = async (req: Request<{}, {}, IReviewRequest>, res: Response) => {
  const reviewServices: IReviewServices = new ReviewServices();

  const review: IReview = req.body;
  try {
    await reviewServices.createReview(review);
    res.status(201).send();
  } catch (error: any) {
    res.status(400).send(error.message);
  }
}

export const findReview = async (req: Request<{}, {}, IReviewRequest>, res: Response) => {
  const reviewServices: IReviewServices = new ReviewServices();

  const review: Partial<IReview> = req.query;
  try {
    const foundReview = await reviewServices.findReview(review);
    res.status(200).send(foundReview);
  } catch (error: any) {
    res.status(400).send(error.message);
  }
}

export const deleteReview = async (req: Request, res: Response) => {
  const reviewServices: IReviewServices = new ReviewServices();

  const _id = req.query.reviewId as string;
  if (!_id) {
    res.status(400).send("Error deleting review: reviewId is required");
    return;
  }
  try {
    await reviewServices.deleteReview(_id);
    res.status(200).send();
  } catch (error: any) {
    res.status(400).send(error.message);
  }
}