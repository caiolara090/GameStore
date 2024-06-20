import { GameRepository } from "../../adapters/database/repositories/GameRepository";
import { IGame } from "../entities/Game";
import { IGameRepository } from "../ports/Game/GameRepository";
import { IGameServices } from "../ports/Game/GameServices";

export class GameServices implements IGameServices {
  async searchGames(gameTitle: string, fields: string): Promise<IGame[] | null> {
    const gameRepository: IGameRepository = new GameRepository();

    return await gameRepository.searchGames(gameTitle, fields);
  }

  async getPopularGames(): Promise<IGame[] | null> {
    const gameRepository: IGameRepository = new GameRepository();

    return await gameRepository.getPopularGames();
  }
}
