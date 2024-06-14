import { GameRepository } from "../../adapters/database/repositories/GameRepository";
import { GameSearchResult } from "../entities/Game";
import { IGameRepository } from "../ports/Game/GameRepository";
import { IGameServices } from "../ports/Game/GameServices";

export class GameServices implements IGameServices {
  async searchGames(
    gameTitle: string,
    fields: string,
    sortField: string,
    page: number,
    limit: number
  ): Promise<GameSearchResult | null> {
    const gameRepository: IGameRepository = new GameRepository();

    return await gameRepository.searchGames(
      gameTitle,
      fields,
      sortField,
      page,
      limit
    );
  }
}
