import { IUserLibraryServices, ILibrary } from "../ports/User/UserLibraryServices";
import { IUserRepository } from "../ports/User/UserRepository";
import { UserRepository } from "../../adapters/database/repositories/UserRepository";
import { IUserRepositoryGame } from "../ports/User/UserRepository"; 
import { IUserGame } from "../entities/User";

export class UserLibraryServices implements IUserLibraryServices{
  private userRepository: IUserRepository;

  constructor() {
    this.userRepository = new UserRepository();
  }

  async getUserLibrary(userId: string): Promise<ILibrary> {
    try {
      const games = await this.userRepository.getGames(userId);
      const favorites = games.filter(game => game.favorite)
      const notFavorites = games.filter(game => !game.favorite)
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

  async searchUsersLibrary(userId: string, gameTitle: string): Promise<IUserGame[]>{
    return await this.userRepository.searchUsersLibrary(userId, gameTitle);
  }

  async setGameFavorite(userId: string, gameId: string): Promise<void> {
    return await this.userRepository.setGameFavorite(userId, gameId);
  }
}
