import { IGameRepository } from "../../../domain/ports/Game";
import { Game } from "../../../domain/entities/Game";
import { GameModel } from "../models/Game";

export class GameRepository implements IGameRepository {
  async create(game: Game): Promise<Game> {
    try {
      const createdGame = await GameModel.create(game);
      return createdGame;
    } catch (error: any) {
      throw new Error("Error creating game: " + error.message);
    }
  }

  async update(id: string, game: Partial<Game>): Promise<Game> {
    try {
      const updatedGame = await GameModel.findByIdAndUpdate(id, game, { new: true });
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

  async find(game: Partial<Game>): Promise<Game | Game[] | null> {
    try {
      const foundGame = await GameModel.find(game);
      // Se a lista tiver só um elemento, retorna apenas ele
      if (foundGame.length === 1) return foundGame[0];
      // Caso contrário, retorna a lista
      return foundGame;
    } catch (error: any) {
      throw new Error("Error finding game: " + error.message);
    }
  }
}
