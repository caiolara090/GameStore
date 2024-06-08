import { Review } from "../../entities/Review";

export interface IReviewRepository {
  create(review: Review): Promise<Review>;
  update(_id: string, review: Partial<Review>): Promise<Review>;
  delete(_id: string): Promise<void>;
  find(review: Partial<Review>): Promise<Review | Review[] | null>;
}
