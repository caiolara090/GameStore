import { UserRepository } from "../../adapters/database/repositories/UserRepository";
import { IUser } from "../entities/User";
import { IUserRepository } from "../ports/User";
import { IUserServices } from "../ports/User/UserServices";

export class UserServices implements IUserServices {
  private userRepository: IUserRepository;

  constructor() {
    this.userRepository = new UserRepository();
  }
  async searchUsers(username: string, fields: string): Promise<IUser[] | null> {
    return await this.userRepository.searchUsers(username, fields);
  }

  async findById(userId: string): Promise<IUser | null> {
    return await this.userRepository.findById(userId);
  }
}
