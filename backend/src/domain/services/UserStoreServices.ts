import { IUserStoreServices } from "../ports/User/UserStoreServices";
import { IUserRepository } from "../ports/User/UserRepository";
import { UserRepository } from "../../adapters/database/repositories/UserRepository";
import { IGameRepository } from "../ports/Game";
import { GameRepository } from "../../adapters/database/repositories/GameRepository";

export class UserStoreServices implements IUserStoreServices {
  private userRepository: IUserRepository;

  constructor() {
    this.userRepository = new UserRepository();
  }

  async buyGame(userId: string, gameId: string): Promise<void> {
    try {
      const user = await this.userRepository.findById(userId);
      if (user === null) {
        throw new Error("User not found");
      }
      
      const gameRepository: IGameRepository = new GameRepository();
      const game = await gameRepository.findById(gameId);
      if (game === null) {
        throw new Error("Game not found");
      }

      if (game._id !== undefined) {
        this.userRepository.addGame(userId, game._id);
        this.userRepository.addCredits(userId, -game.price);
      }

    } catch (error: any) {
      throw new Error("Error buying game: " + error.message);
    }
  }

  async addCredits(userId: string, credits: number): Promise<void> {
    try {
      await this.userRepository.addCredits(userId, credits);
    } catch (error: any) {
      throw new Error("Error adding credits: " + error.message);
    }
  }
}