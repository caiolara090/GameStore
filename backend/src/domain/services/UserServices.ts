import { UserRepository } from "../../adapters/database/repositories/UserRepository";
import { IUser, IUserGame } from "../entities/User";
import { IUserRepository } from "../ports/User";
import { IUserServices } from "../ports/User/UserServices";

export class UserServices implements IUserServices {
  async searchUsers(username: string, fields: string): Promise<IUser[] | null> {
    const userRepository: IUserRepository = new UserRepository();

    return await userRepository.searchUsers(username, fields);
  }

  async searchUsersLibrary(userId: string, gameTitle: string): Promise<IUserGame[]>{
    const userRepository: IUserRepository = new UserRepository();

    return await userRepository.searchUsersLibrary(userId, gameTitle);
  }

  async toggleUsersGameFavorite(userId: string, gameId: string, isFavorite: boolean): Promise<void> {
    const userRepository: IUserRepository = new UserRepository();

    return await userRepository.toggleUsersGameFavorite(userId, gameId, isFavorite);
  }
}
