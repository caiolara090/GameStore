import {
  IUserLibraryServices,
  ILibrary,
} from "../ports/User/UserLibraryServices";
import { IUserRepository } from "../ports/User/UserRepository";
import { UserRepository } from "../../adapters/database/repositories/UserRepository";
import { IUserRepositoryGame } from "../ports/User/UserRepository";
import { IUserGame } from "../entities/User";

export class UserLibraryServices implements IUserLibraryServices {
  private userRepository: IUserRepository;

  constructor() {
    this.userRepository = new UserRepository();
  }

  async getUserLibrary(userId: string): Promise<ILibrary> {
    try {
      const games = await this.userRepository.getGames(userId);
      const favorites = games.filter((game) => game.favorite);
      const notFavorites = games.filter((game) => !game.favorite);
      return { favorites, notFavorites };
    } catch (error: any) {
      throw new Error("Error getting user library: " + error.message);
    }
  }

  async getUserGames(userId: string): Promise<IUserRepositoryGame[]> {
    try {
      return await this.userRepository.getGames(userId);
    } catch (error: any) {
      throw new Error("Error getting user games: " + error.message);
    }
  }

  async searchUserLibrary(
    userId: string,
    gameTitle: string
  ): Promise<IUserGame[]> {
    const games = await this.userRepository.retrieveUserLibrary(userId);

    return games
      .filter((gameEntry) =>
        gameEntry.game.name.toLowerCase().includes(gameTitle.toLowerCase())
      )
      .map((gameEntry) => ({
        game: {
          name: gameEntry.game.name,
          description: gameEntry.game.description,
          image: gameEntry.game.image,
        },
        favorite: gameEntry.favorite,
      })) as IUserGame[];
  }

  async setGameFavorite(userId: string, gameId: string): Promise<void> {
    const user = await this.userRepository.findById(userId);

    if (!user) throw new Error("User not found");
    if (user.games === undefined) throw new Error("User has no games");

    const game = user.games.find((game) => game.game._id === gameId);
    if (!game) throw new Error("Game not found in user's library");

    game.favorite = !game.favorite;

    await this.userRepository.update(user);
  }
}
