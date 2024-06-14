import { IFriendshipServices } from "../ports/Friendship/FriendshipServices";
import { IFriendshipRepository } from "../ports/Friendship/FriendshipRepository";
import { FriendshipRepository } from "../../adapters/database/repositories/FriendshipRepository";
import { IFriendship } from "../entities/Friendship";

// todo envolver tudo em try
// todo fazer funcionar
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
    await this.friendshipRepository.create(friendshipSent);
    await this.friendshipRepository.create(friendshipReceived);
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
      // todo Talvez reduzir a quantidade de consultas mexendo no repositório
      const friendship1Data = await this.friendshipRepository.findByUsers(userId, friendId);
      const friendship2Data = await this.friendshipRepository.findByUsers(friendId, userId);
  
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
      const friendship2 = await this.friendshipRepository.findByUsers(friendId, userId);
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
    const friendship = await this.friendshipRepository.findByUsers(userId, friendId);
    if (friendship?._id !== undefined) {
      return await this.friendshipRepository.delete(friendship._id);
    }
  }

  async find(friendship: Partial<IFriendship>): Promise<IFriendship | IFriendship[] | null> {
    return this.friendshipRepository.find(friendship);
  }
}
