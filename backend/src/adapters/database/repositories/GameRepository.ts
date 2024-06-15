import { IGameRepository } from "../../../domain/ports/Game";
import { GameSearchResult, IGame } from "../../../domain/entities/Game";
import { GameModel } from "../models/Game";
import { UserModel } from "../models/User";

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
      // Se a lista tiver só um elemento, retorna apenas ele
      if (foundGame.length === 1) return foundGame[0];
      // Caso contrário, retorna a lista
      return foundGame;
    } catch (error: any) {
      throw new Error("Error finding game: " + error.message);
    }
  }

  async searchGames(
    gameTitle: string,
    fields: string,
    sortField: string,
    page: number = 1,
    limit: number = 5
  ): Promise<GameSearchResult | null> {
    try {
      const query = {} as any;
      query.name = { $regex: gameTitle, $options: "iu" };

      const games = await GameModel.find(query)
        .sort(sortField)
        .select(fields)
        .skip((page - 1) * limit)
        .limit(limit);

      const resPage = {
        currentPage: page,
        totalPages: Math.ceil(
          (await GameModel.find(query).countDocuments()) / limit
        ),
        size: games.length,
      };

      return { games: games, resPage: resPage };
    } catch (error: any) {
      throw new Error("Error searching for games: " + error.message);
    }
  }
}
