import { ReviewServices } from "../../../src/domain/services/ReviewServices";
import { IReviewRepository } from "../../../src/domain/ports/Review/ReviewRepository";
import { IGameRepository } from "../../../src/domain/ports/Game/GameRepository";
import { IReview } from "../../../src/domain/entities/Review";
import { IGame } from "../../../src/domain/entities/Game";

describe("ReviewServices", () => {
  let reviewServices: ReviewServices;
  let mockReviewRepository: jest.Mocked<IReviewRepository>;
  let mockGameRepository: jest.Mocked<IGameRepository>;

  beforeEach(() => {
    mockReviewRepository = {
      create: jest.fn(),
      delete: jest.fn(),
      find: jest.fn(),
    } as unknown as jest.Mocked<IReviewRepository>;

    mockGameRepository = {
      findById: jest.fn(),
      update: jest.fn(),
    } as unknown as jest.Mocked<IGameRepository>;

    reviewServices = new ReviewServices();
    (reviewServices as any).reviewRepository = mockReviewRepository;
    (reviewServices as any).gameRepository = mockGameRepository;
  });

  describe("createReview", () => {
    it("should create a review successfully", async () => {
      const review = { _id: "1", gameId: "game1", rating: 5 } as IReview;
      const game = { _id: "game1", reviews: [], rating: 0 } as unknown as IGame;

      mockReviewRepository.create.mockResolvedValueOnce(review);
      mockGameRepository.findById.mockResolvedValueOnce(game);

      const result = await reviewServices.createReview(review);

      expect(result).toEqual(review);
    });

    it("should throw an error when creating a review fails", async () => {
      const review = { _id: "1", gameId: "game1", rating: 5 } as IReview;

      mockReviewRepository.create.mockRejectedValueOnce(
        new Error("Creation error")
      );

      await expect(reviewServices.createReview(review)).rejects.toThrow(
        "Error creating review: Creation error"
      );
    });
  });

  describe("deleteReview", () => {
    it("should delete a review successfully", async () => {
      const review = { _id: "1", gameId: "game1", rating: 5 } as IReview;
      const game = { _id: "game1", reviews: ["1"], rating: 5 } as IGame;

      mockReviewRepository.find.mockResolvedValueOnce(review);
      mockGameRepository.findById.mockResolvedValueOnce(game);

      await reviewServices.deleteReview("1");

      expect(mockReviewRepository.delete).toHaveBeenCalledWith("1");
    });

    it("should throw an error when deleting a review fails", async () => {
      mockReviewRepository.find.mockRejectedValueOnce(
        new Error("Deletion error")
      );

      await expect(reviewServices.deleteReview("1")).rejects.toThrow(
        "Error deleting review: Deletion error"
      );
    });
  });

  describe("findReview", () => {
    it("should find reviews based on criteria", async () => {
      const review = { _id: "1", gameId: "game1", rating: 5 } as IReview;

      mockReviewRepository.find.mockResolvedValueOnce([review]);

      const result = await reviewServices.findReview({ gameId: "game1" });

      expect(result).toEqual([review]);
    });

    it("should throw an error when finding reviews fails", async () => {
      mockReviewRepository.find.mockRejectedValueOnce(
        new Error("Finding error")
      );

      await expect(
        reviewServices.findReview({ gameId: "game1" })
      ).rejects.toThrow("Finding error");
    });
  });

  describe("updateGameReview", () => {
    it("should update the game rating when a review is created", async () => {
      const review = { _id: "1", gameId: "game1", rating: 5 } as IReview;
      const game = { _id: "game1", reviews: [], rating: 0 } as unknown as IGame;

      mockGameRepository.findById.mockResolvedValueOnce(game);

      await reviewServices.updateGameReview(review, true);

      expect(game.reviews).toContain("1");
      expect(game.rating).toBe(5);
    });

    it("should update the game rating when a review is deleted", async () => {
      const review = { _id: "1", gameId: "game1", rating: 5 } as IReview;
      const game = { _id: "game1", reviews: ["1"], rating: 5 } as IGame;

      mockGameRepository.findById.mockResolvedValueOnce(game);

      await reviewServices.updateGameReview(review, false);

      expect(game.reviews).not.toContain("1");
      expect(game.rating).toBe(0);
    });
  });
});
