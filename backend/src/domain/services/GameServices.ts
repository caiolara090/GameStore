import { GameRepository } from "../../adapters/database/repositories/GameRepository";
import { IGame } from "../entities/Game";
import { IGameRepository } from "../ports/Game/GameRepository";
import { IGameServices } from "../ports/Game/GameServices";

export class GameServices implements IGameServices {
  async getLibraryGames(userId: string): Promise<Partial<IGame>[] | null> {
    const gameRepository: IGameRepository = new GameRepository();

    const userGames = await gameRepository.getUserGames(userId);

    return userGames
      ? userGames.map((game) => ({
          price: game.price,
          description: game.description,
          name: game.name,
          image: game.image,
          favorite: game.favorite,
        }))
      : null;
  }
}
