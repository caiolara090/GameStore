import { IUserRepository } from "../../../domain/ports/User";
import { UserModel } from "../models/User";
import { IUser } from "../../../domain/entities/User";
import { IGame } from "../../../domain/entities/Game";
import { IUserRepositoryGame } from "../../../domain/ports/User/UserRepository";

export class UserRepository implements IUserRepository {
  async create(user: IUser): Promise<IUser> {
    try {
      const createdUser = await UserModel.create(user);
      return createdUser;
    } catch (error: any) {
      throw new Error("Error creating user: " + error.message);
    }
  }

  async update(_id: string, user: Partial<IUser>): Promise<IUser> {
    try {
      const updatedUser = await UserModel.findByIdAndUpdate(_id, user, {
        new: true,
      });
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

  async find(user: Partial<IUser>): Promise<IUser | IUser[] | null> {
    try {
      const foundUser = await UserModel.find(user);
      // Se não encontrar nenhum usuário, retorna null
      if (foundUser.length === 0) return null;
      // Se a lista tiver só um elemento, retorna apenas ele
      if (foundUser.length === 1) return foundUser[0];
      // Caso contrário, retorna a lista
      return foundUser;
    } catch (error: any) {
      throw new Error("Error finding user: " + error.message);
    }
  }

  async findByEmail(email: string): Promise<IUser | null> {
    try {
      const foundUser = await UserModel.findOne({email});
      return foundUser;
    } catch (error: any) {
      throw new Error("Error finding user by email: " + error.message);
    }
  }

  async findByUsername(username: string): Promise<IUser | null> {
    try {
      const foundUser = await UserModel.findOne({username});
      return foundUser;
    } catch (error: any) {
      throw new Error("Error finding user by username: " + error.message);
    }
  }

  async findById(_id: string): Promise<IUser | null> {
    try {
      const foundUser = await UserModel.findById(_id);
      return foundUser;
    } catch (error: any) {
      throw new Error("Error finding user by id: " + error.message);
    }
  }

  async addCredits(_id: string, credits: number): Promise<void> {
    try {
      await UserModel.findByIdAndUpdate(_id, {$inc: {credits}});
    } catch (error: any) {
      throw new Error("Error adding credits to user: " + error.message);
    }
  }

  async addGame(_id: string, game: string): Promise<void> {
    try {
      await UserModel.findByIdAndUpdate(_id, {$push: {games: {game, favorites: false}}});
    } catch (error: any) {
      throw new Error("Error adding game to user: " + error.message);
    }
  }

  async getGames(_id: string): Promise<IUserRepositoryGame[]> {
    try {
      const user = await UserModel.findById(_id).populate("games.game");
      let games = [] as IUserRepositoryGame[];
      if (user?.games !== undefined) {
        games = user.games as unknown as IUserRepositoryGame[];
      }
      if (user?.games !== undefined) {
        return games;
      }
      return [];
    } catch (error: any) {
      throw new Error("Error getting games from user: " + error.message);
    }
  }
}
