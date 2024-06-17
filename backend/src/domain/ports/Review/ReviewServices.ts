import { IReview } from "../../entities/Review";

export interface IReviewServices {
  createReview(review: IReview): Promise<IReview>;
  deleteReview(_id: string): Promise<void>;
  findReview(review: Partial<IReview>): Promise<IReview | IReview[] | null>;
}
