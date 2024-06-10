import { IReview } from "../../entities/Review";

export interface IReviewRepository {
  create(review: IReview): Promise<IReview>;
  update(_id: string, review: Partial<IReview>): Promise<IReview>;
  delete(_id: string): Promise<void>;
  find(review: Partial<IReview>): Promise<IReview | IReview[] | null>;
}
