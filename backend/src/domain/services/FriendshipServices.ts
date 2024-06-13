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
    const friendship = {
      userId,
      friendId,
      status: 0,
    };
    await this.friendshipRepository.create(friendship);
  }

  async acceptFriendshipRequest(userId: string, friendId: string): Promise<void> {
    const friendship = {
      userId,
      friendId,
      status: 1,
    };
    await this.friendshipRepository.update(friendship);
  }

  async rejectFriendshipRequest(userId: string, friendId: string): Promise<void> {
    const friendship = {
      userId,
      friendId,
      status: 2,
    };
    await this.friendshipRepository.update(friendship);
  }

  async delete(userId: string, friendId: string): Promise<void> {
    return this.friendshipRepository.delete(_id);
  }

  async find(friendship: Partial<IFriendship>): Promise<IFriendship | IFriendship[] | null> {
    return this.friendshipRepository.find(friendship);
  }
}
