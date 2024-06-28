import { IReviewServices } from "../ports/Review/ReviewServices";
import { IReview } from "../entities/Review";
import { IReviewRepository } from "../ports/Review/ReviewRepository";
import { ReviewRepository } from "../../adapters/database/repositories/ReviewRepository";
import { IGameRepository } from "../ports/Game/GameRepository";
import { GameRepository } from "../../adapters/database/repositories/GameRepository";

export class ReviewServices implements IReviewServices {
  private reviewRepository: IReviewRepository;
  private gameRepository: IGameRepository;

  constructor() {
    this.reviewRepository = new ReviewRepository();
    this.gameRepository = new GameRepository();
  }

  async createReview(review: IReview): Promise<IReview> {
    try {
      const createdReview = await this.reviewRepository.create(review);

      await this.gameRepository.insertReview(review.gameId, createdReview as IReview);

      return createdReview;
    } catch (error: any) {
      throw new Error("Error creating review: " + error.message);
    }
  }

  async deleteReview(_id: string): Promise<void> {
    try {
      const review = await this.reviewRepository.find({ _id }) as IReview;

      await this.gameRepository.removeReview(review.gameId, review as IReview);

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
