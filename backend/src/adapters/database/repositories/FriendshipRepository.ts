import { IFriendshipRepository } from "../../../domain/ports/Friendship/FriendshipRepository";
import { FriendshipModel } from "../models/Friendship";
import { IFriendship } from "../../../domain/entities/Friendship";

export class FriendshipRepository implements IFriendshipRepository {
  async create(friendship: IFriendship): Promise<void> {
    try {
      await FriendshipModel.create(friendship);
    } catch (error: any) {
      throw new Error("Error creating friendship: " + error.message);
    }
  }

  async delete(_id: string): Promise<void> {
    try {
      await FriendshipModel.findByIdAndDelete(_id);
    } catch (error: any) {
      throw new Error("Error deleting friendship: " + error.message);
    }
  }

  async find(friendship: Partial<IFriendship>): Promise<IFriendship | IFriendship[] | null> {
    try {
      const foundFriendship = await FriendshipModel.find(friendship).populate("userId friendId");
      // Se a lista tiver só um elemento, retorna apenas ele
      if (foundFriendship.length === 1) return foundFriendship[0];
      // Caso contrário, retorna a lista
      return foundFriendship;
    } catch (error: any) {
      throw new Error("Error finding friendship: " + error.message);
    }
  }

  async findByUsers(userId: string, friendId: string): Promise<IFriendship | null> {
    try {
      const friendship = await FriendshipModel.findOne({ userId, friendId }).populate("userId friendId");
      return friendship;
    } catch (error: any) {
      throw new Error("Error finding friendship: " + error.message);
    }
  }

  async update(_id: string, friendship: Partial<IFriendship>): Promise<void> {
    try {
      await FriendshipModel.findByIdAndUpdate(_id, friendship);
    } catch (error: any) {
      throw new Error("Error updating friendship: " + error.message);
    }
  }
}
