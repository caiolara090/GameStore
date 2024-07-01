import { IUserStoreServices } from "../ports/User/UserStoreServices";
import { IUserRepository } from "../ports/User/UserRepository";
import { UserRepository } from "../../adapters/database/repositories/UserRepository";
import { IGameRepository } from "../ports/Game/GameRepository";
import { GameRepository } from "../../adapters/database/repositories/GameRepository";

export class UserStoreServices implements IUserStoreServices {
  private userRepository: IUserRepository;
  private gameRepository: IGameRepository;

  constructor() {
    this.userRepository = new UserRepository();
    this.gameRepository = new GameRepository();
  }

  async buyGame(userId: string, gameId: string): Promise<void> {
    try {
      const user = await this.userRepository.findById(userId);
      if (user === null) {
        throw new Error("User not found");
      }

      const game = await this.gameRepository.findById(gameId);

      if (game?._id !== undefined && game !== null) {
        for (const userGame of user.games!)
          if (userGame!.game._id?.toString() === gameId)
            throw new Error("Game already bought");

        if (user.credits! < game.price)
          throw new Error("Insufficient credits");
  
        this.userRepository.addGame(userId, game._id);
        this.userRepository.addCredits(userId, -game.price);
      } else {
        throw new Error("Game not found");
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