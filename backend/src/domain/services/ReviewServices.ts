import { IReviewServices } from "../ports/Review/ReviewServices";
import { IReview } from "../entities/Review";
import { IReviewRepository } from "../ports/Review/ReviewRepository";
import { ReviewRepository } from "../../adapters/database/repositories/ReviewRepository";

export class ReviewServices implements IReviewServices {
  private reviewRepository: IReviewRepository;

  constructor() {
    this.reviewRepository = new ReviewRepository();
  }

  createReview(review: IReview): Promise<IReview> {
    try {
      return this.reviewRepository.create(review);
    } catch (error: any) {
      throw new Error("Error creating review: " + error.message);
    }
  }

  deleteReview(_id: string): Promise<void> {
    try {
      return this.reviewRepository.delete(_id);
    } catch (error: any) {
      throw new Error("Error deleting review: " + error.message);
    }
  }

  async findReview(review: Partial<IReview>): Promise<IReview | IReview[] | null> {
    try {
      return this.reviewRepository.find(review);
    } catch (error: any) {
      throw new Error("Error finding review: " + error.message);
    }
  }
}
