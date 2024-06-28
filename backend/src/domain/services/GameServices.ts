import { GameRepository } from "../../adapters/database/repositories/GameRepository";
import { IGame } from "../entities/Game";
import { IGameRepository } from "../ports/Game/GameRepository";
import { IGameServices } from "../ports/Game/GameServices";

export class GameServices implements IGameServices {
  private gameRepository: IGameRepository;
  constructor() {
    this.gameRepository = new GameRepository();
  }
  async searchGames(gameTitle: string, fields: string): Promise<IGame[] | null> {
    return await this.gameRepository.searchGames(gameTitle, fields);
  }

  async getPopularGames(): Promise<IGame[] | null> {
    return await this.gameRepository.getPopularGames();
  }
}
