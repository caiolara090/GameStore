import { Request, Response } from 'express';
import { IReviewServices } from '../../../../domain/ports/Review/ReviewServices';
import { ReviewServices } from '../../../../domain/services/ReviewServices';
import { IReview } from '../../../../domain/entities/Review';

export const createReview = async (req: Request, res: Response) => {
  const reviewServices: IReviewServices = new ReviewServices();

  const review: IReview = req.body;
  try {
    await reviewServices.createReview(review);
    res.status(201).send();
  } catch (error: any) {
    res.status(400).send(error.message);
  }
}

export const findReview = async (req: Request, res: Response) => {
  const reviewServices: IReviewServices = new ReviewServices();

  const review: Partial<IReview> = req.body;
  try {
    await reviewServices.findReview(review);
    res.status(200).send();
  } catch (error: any) {
    res.status(400).send(error.message);
  }
}

export const deleteReview = async (req: Request, res: Response) => {
  const reviewServices: IReviewServices = new ReviewServices();

  const _id = req.params.reviewId;
  try {
    await reviewServices.deleteReview(_id);
    res.status(200).send();
  } catch (error: any) {
    res.status(400).send(error.message);
  }
}