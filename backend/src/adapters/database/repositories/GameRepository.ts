import { IGameRepository } from "../../../domain/ports/Game";
import { IGame } from "../../../domain/entities/Game";
import { GameModel } from "../models/Game";

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
        .sort(gameTitle)
        .select(fields)

      return games;
    } catch (error: any) {
      throw new Error("Error searching for games: " + error.message);
    }
  }

  async getPopularGames(): Promise<IGame[] | null> {
    try {
      const games = await GameModel.find().sort({ rating: -1 }).limit(10);
      return games;
    } catch (error: any) {
      throw new Error("Error getting popular games: " + error.message);
    }
  }
}
