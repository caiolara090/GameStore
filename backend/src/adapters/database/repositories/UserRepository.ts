import { IUserRepository, IUserRepositoryGame } from "../../../domain/ports/User/UserRepository";
import { UserModel } from "../models/User";
import { IUser, IUserGame } from "../../../domain/entities/User";

export class UserRepository implements IUserRepository {
  async create(user: IUser): Promise<IUser> {
    try {
      return await UserModel.create(user);
    } catch (error: any) {
      throw new Error("Error creating user: " + error.message);
    }
  }

  async find(user: Partial<IUser>): Promise<IUser | IUser[] | null> {
    try {
      const foundUser = await UserModel.find(user);

      if (foundUser.length === 0) return null;
      if (foundUser.length === 1) return foundUser[0];

      return foundUser;
    } catch (error: any) {
      throw new Error("Error finding user: " + error.message);
    }
  }

  async findByEmail(email: string): Promise<IUser | null> {
    try {
      return await UserModel.findOne({ email });
    } catch (error: any) {
      throw new Error("Error finding user by email: " + error.message);
    }
  }

  async findByUsername(username: string): Promise<IUser | null> {
    try {
      return await UserModel.findOne({ username });
    } catch (error: any) {
      throw new Error("Error finding user by username: " + error.message);
    }
  }

  async findById(_id: string): Promise<IUser | null> {
    try {
      return await UserModel.findById(_id);
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
      return user?.games as unknown as IUserRepositoryGame[] || [];
    } catch (error: any) {
      throw new Error("Error getting games from user: " + error.message);
    }
  }  
  
  async retrieveUserLibrary(userId: string): Promise<IUserGame[]> {
    try {
      const user = await UserModel.findById(userId)
        .populate({
          path: 'games.game',
          select: 'name description image',
        })
        .exec();
  
      if (!user) throw new Error('User not found');
  
      return user.games as IUserGame[];
    } catch (error: any) {
      throw new Error("Error retrieving user's games:" +  error.message);
    }
  }

  async update(user: IUser): Promise<void> {
    try {
      await UserModel.updateOne({ _id: user.userId }, { $set: user });
    } catch (error: any) {
      throw new Error("Error saving user: " + error.message);
    }
  }
}
