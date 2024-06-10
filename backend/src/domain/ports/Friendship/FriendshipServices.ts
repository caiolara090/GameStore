import { IFriendship } from "../../entities/Friendship";
import { IFriendshipRepository } from "./FriendshipRepository";

export interface IFriendshipServices {
  create(friendship: IFriendship): Promise<void>;
  delete(_id: string): Promise<void>;
  find(friendship: Partial<IFriendship>): Promise<IFriendship | IFriendship[] | null>;
}

export class FriendshipServices implements IFriendshipServices {
  constructor(private readonly friendshipRepository: IFriendshipRepository) {}

  async create(friendship: IFriendship): Promise<void> {
    return this.friendshipRepository.create(friendship);
  }

  async delete(_id: string): Promise<void> {
    return this.friendshipRepository.delete(_id);
  }

  async find(friendship: Partial<IFriendship>): Promise<IFriendship | IFriendship[] | null> {
    return this.friendshipRepository.find(friendship);
  }
}
