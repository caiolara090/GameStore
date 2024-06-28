import { IFriendshipServices } from "../ports/Friendship/FriendshipServices";
import { IFriendshipRepository } from "../ports/Friendship/FriendshipRepository";
import { FriendshipRepository } from "../../adapters/database/repositories/FriendshipRepository";
import { IFriendship } from "../entities/Friendship";

export class FriendshipServices implements IFriendshipServices {
  private friendshipRepository: IFriendshipRepository;

  constructor() {
    this.friendshipRepository = new FriendshipRepository();
  }

  async createFriendshipRequest(userId: string, friendId: string): Promise<void> {
    const friendshipSent = {
      userId,
      friendId,
      status: 0,
    };
    const friendshipReceived = {
      userId: friendId,
      friendId: userId,
      status: 1,
    };
    try {

      if (await this.friendshipRepository.findByUsers(userId, friendId)) 
        throw new Error("Friendship already exists.");

      await this.friendshipRepository.create(friendshipSent);
      await this.friendshipRepository.create(friendshipReceived);
    } catch (error: any) {
      throw new Error("Error creating friendship: " + error.message);
    }
  }

  async acceptFriendshipRequest(userId: string, friendId: string): Promise<void> {
    const friendship1 = {
      userId,
      friendId,
      status: 2,
    };
    const friendship2 = {
      userId: friendId,
      friendId: userId,
      status: 2,
    };
    try {
      const friendship1Data = await this.friendshipRepository.findByUsers(userId, friendId);
      if (friendship1Data?.status != 1) {
        throw new Error("Friendship request not found");
      }
      const friendship2Data = await this.friendshipRepository.findByUsers(friendId, userId);
      if (friendship2Data?.status != 0) {
        throw new Error("Friendship request not found");
      }
  
      if (friendship1Data?._id !== undefined) {
        await this.friendshipRepository.update(friendship1Data._id, friendship1);
      }
  
      if (friendship2Data?._id !== undefined) {
        await this.friendshipRepository.update(friendship2Data._id, friendship2);
      }
    } catch (error: any) {
      throw new Error("Error accepting friendship: " + error.message);
    }
  }

  async rejectFriendshipRequest(userId: string, friendId: string): Promise<void> {
    try {
      const friendship1 = await this.friendshipRepository.findByUsers(userId, friendId);
      if (friendship1?.status != 1) {
        throw new Error("Friendship request not found");
      }
      const friendship2 = await this.friendshipRepository.findByUsers(friendId, userId);
      if (friendship2?.status != 0) {
        throw new Error("Friendship request not found");
      }
      if (friendship1?._id !== undefined) {
        await this.friendshipRepository.delete(friendship1._id);
      }
      if (friendship2?._id !== undefined) {
        await this.friendshipRepository.delete(friendship2._id);
      }
    } catch (error: any) {
      throw new Error("Error rejecting friendship: " + error.message);
    }
  }

  async delete(userId: string, friendId: string): Promise<void> {
    try {
      const friendship = await this.friendshipRepository.findByUsers(userId, friendId);
      if (friendship?._id !== undefined) {
        await this.friendshipRepository.delete(friendship._id);
      }
      const friendship2 = await this.friendshipRepository.findByUsers(friendId, userId);
      if (friendship2?._id !== undefined) {
        await this.friendshipRepository.delete(friendship2._id);
      }
    } catch (error: any) {
      throw new Error("Error deleting friendship: " + error.message);
    }
  }

  async find(friendship: Partial<IFriendship>): Promise<IFriendship | IFriendship[] | null> {
    return this.friendshipRepository.find(friendship);
  }
}
