import { IGameRepository } from "../../../domain/ports/Game/GameRepository";
import { IGame } from "../../../domain/entities/Game";
import { GameModel } from "../models/Game";
import { IReview } from "../../../domain/entities/Review";

export class GameRepository implements IGameRepository {
  async create(game: IGame): Promise<IGame> {
    try {
      const createdGame = await GameModel.create(game);
      return createdGame;
    } catch (error: any) {
      throw new Error("Error creating game: " + error.message);
    }
  }

  async update(id: string, game: Partial<IGame>): Promise<IGame> {
    try {
      const updatedGame = await GameModel.findByIdAndUpdate(id, game, {
        new: true,
      });
      return updatedGame!;
    } catch (error: any) {
      throw new Error("Error updating game: " + error.message);
    }
  }

  async delete(id: string): Promise<void> {
    try {
      await GameModel.findByIdAndDelete(id);
    } catch (error: any) {
      throw new Error("Error deleting game: " + error.message);
    }
  }

  async find(game: Partial<IGame>): Promise<IGame | IGame[] | null> {
    try {
      const foundGame = await GameModel.find(game);

      if (foundGame.length === 0) return null;
      if (foundGame.length === 1) return foundGame[0];

      return foundGame;
    } catch (error: any) {
      throw new Error("Error finding game: " + error.message);
    }
  }

  async findById(_id: string): Promise<IGame | null> {
    try {
      const foundGame = await GameModel.findById(_id);
      return foundGame;
    } catch (error: any) {
      throw new Error("Error finding game: " + error.message);
    }
  }
  
  async searchGames(gameTitle: string, fields: string): Promise<IGame[] | null> {
    try {
      const query = {} as any;
      query.name = { $regex: gameTitle, $options: "iu" };

      const games = await GameModel.find(query)
        .populate({
          path: 'reviews',
          populate: {
            path: 'userId',
            model: 'User',
            select: 'username email'
          }
        })
        .sort('name')
        .select(fields)

      return games;
    } catch (error: any) {
      throw new Error("Error searching for games: " + error.message);
    }
  }

  async getPopularGames(): Promise<IGame[] | null> {
    try {
      const games = await GameModel.find()
      .sort({ rating: -1 })
      .limit(10)
      .populate({
        path: 'reviews',
        populate: {
          path: 'userId',
          model: 'User',
          select: 'username email'
        }
      });
      return games;
    } catch (error: any) {
      throw new Error("Error getting popular games: " + error.message);
    }
  }

  async insertReview(gameId: string, review: IReview): Promise<void> {
    try {
      const game = await GameModel.findById(gameId);
      game!.reviews!.push(review._id as string);
      game!.rating = (game!.rating! * (game!.reviews!.length - 1) + review.rating) / game!.reviews!.length;
      await game!.save();
    } catch (error: any) {
      throw new Error("Error inserting review: " + error.message);
    }
  }

  async removeReview(gameId: string, review: IReview): Promise<void> {
    try {
      const game = await GameModel.findById(gameId);
      game!.reviews = game!.reviews!.filter((gameReview) => gameReview !== review._id as string);
      game!.rating = (game!.rating! * (game!.reviews!.length + 1) - review.rating) / game!.reviews!.length;
      await game!.save();
    } catch (error: any) {
      throw new Error("Error removing review: " + error.message);
    }
  }
}
