import { IReviewServices } from "../ports/Review/ReviewServices";
import { IReview } from "../entities/Review";
import { IReviewRepository } from "../ports/Review/ReviewRepository";
import { ReviewRepository } from "../../adapters/database/repositories/ReviewRepository";
import { IGameRepository } from "../ports/Game/GameRepository";
import { GameRepository } from "../../adapters/database/repositories/GameRepository";
import { IGame } from "../entities/Game";

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

      this.updateGameReview(createdReview, true);

      return createdReview;
    } catch (error: any) {
      throw new Error("Error creating review: " + error.message);
    }
  }

  async deleteReview(_id: string): Promise<void> {
    try {
      const review = (await this.reviewRepository.find({ _id })) as IReview;

      this.updateGameReview(review, false);

      return this.reviewRepository.delete(_id);
    } catch (error: any) {
      throw new Error("Error deleting review: " + error.message);
    }
  }

  async findReview(
    review: Partial<IReview>
  ): Promise<IReview | IReview[] | null> {
    try {
      return this.reviewRepository.find(review);
    } catch (error: any) {
      throw new Error("Error finding review: " + error.message);
    }
  }

  async updateGameReview(review: IReview, isCreating: Boolean): Promise<void> {
    const game = await this.gameRepository.findById(review.gameId);

    if (isCreating) {
      game!.reviews!.push(review._id as string);
      game!.rating =
        (game!.rating! * (game!.reviews!.length - 1) + review.rating) /
        game!.reviews!.length;
    } else {
      game!.reviews = game!.reviews!.filter(
        (gameReview) => gameReview !== (review._id as string)
      );
      game!.rating =
        (game!.rating! * (game!.reviews!.length + 1) - review.rating) /
        game!.reviews!.length;
    }

    this.gameRepository.update(game!._id as string, game as IGame);
  }
}
