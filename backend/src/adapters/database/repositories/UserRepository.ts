import { IUserRepository } from "../../../domain/ports/User";
import { UserModel } from "../models/User";
import { IUser, UserSearchResult } from "../../../domain/entities/User";

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
      const foundUser = await UserModel.findOne({ email });
      return foundUser;
    } catch (error: any) {
      throw new Error("Error finding user by email: " + error.message);
    }
  }

  async findByUsername(username: string): Promise<IUser | null> {
    try {
      const foundUser = await UserModel.findOne({ username });
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

  async searchUsers(
    username: string,
    fields: string,
    page: number = 1,
    limit: number = 10
  ): Promise<UserSearchResult | null> {
    try {
      const query = {} as any;
      query.username = { $regex: username, $options: "iu" };

      const users = await UserModel.find(query)
        .sort(username)
        .select(fields)
        .skip((Number(page) - 1) * Number(limit))
        .limit(Number(limit));

      const resPage = {
        currentPage: page,
        totalPages: Math.ceil(
          (await UserModel.find(query).countDocuments()) / limit
        ),
        size: users.length,
      };

      return { users: users, resPage: resPage };
    } catch (error: any) {
      throw new Error("Error searching for users: " + error.message);
    }
  }

  async searchUsersLibrary(
    username: string,
    gameTitle: string,
    fields: string,
    page: number = 1,
    limit: number = 5
  ): Promise<UserSearchResult | null> {
    try {
      const query = {} as any;
      query.username = username;
      query.games = {
        $elemMatch: { game: { $regex: gameTitle, $options: "iu" } },
      };

      const library = await UserModel.find(query)
        .sort(gameTitle)
        .select(fields)
        .populate("games.game")
        .skip((page - 1) * limit)
        .limit(limit);

      const resPage = {
        currentPage: page,
        totalPages: Math.ceil(
          (await UserModel.find(query).countDocuments()) / limit
        ),
        size: library.length,
      };

      return { users: library, resPage: resPage };
    } catch (error: any) {
      throw new Error("Error searching for user's library: " + error.message);
    }
  }

  async toggleGameFavorite(
    username: string,
    gameId: string,
    isFavorite: boolean
  ): Promise<void> {
    try {
      const user = await UserModel.findOne({ username });
      if (!user) {
        throw new Error("User not found");
      }
  
      const gameIndex = user?.games?.findIndex((game) => game.id == gameId);
      if (gameIndex === undefined || gameIndex < 0) {
        throw new Error("Game not found in user's library");
      }
      user?.games?[gameIndex].favorite = isFavorite;
      await user.save();
    } catch (error: any) {
      throw new Error("Error toggling game favorite: " + error.message);
    }
  }
}
