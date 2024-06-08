import { IUserRepository } from "../../../domain/ports/User";
import { UserModel } from "../models/User";
import { User } from "../../../domain/entities/User";

export class UserRepository implements IUserRepository {
  async create(user: User): Promise<User> {
    try {
      const createdUser = await UserModel.create(user);
      return createdUser;
    } catch (error: any) {
      throw new Error("Error creating user: " + error.message);
    }
  }

  async update(_id: string, user: Partial<User>): Promise<User> {
    try {
      const updatedUser = await UserModel.findByIdAndUpdate(_id, user, { new: true });
      return updatedUser!; // todo dar uma olhada nisso depois
    } catch (error: any) {
      throw new Error("Error updating user: " + error.message);
    }
  }

  async delete(_id: string): Promise<void> {
    try {
      await UserModel.findByIdAndDelete(_id);
    } catch (error: any) {
      throw new Error("Error deleting user: " + error.message);
    }
  }

  async find(user: Partial<User>): Promise<User | User[] | null> {
    try {
      const foundUser = await UserModel.find(user);
      // Se a lista tiver só um elemento, retorna apenas ele
      if (foundUser.length === 1) return foundUser[0];
      // Caso contrário, retorna a lista
      return foundUser;
    } catch (error: any) {
      throw new Error("Error finding user: " + error.message);
    }
  }
}
