import { IFriendship } from "../../entities/Friendship";

export interface IFriendshipServices {
  create(friendship: IFriendship): Promise<void>;
  delete(_id: string): Promise<void>;
  find(friendship: Partial<IFriendship>): Promise<IFriendship | IFriendship[] | null>;
}

export class FrienshipServices implements IFriendshipServices {
  constructor(private readonly friendshipRepository: IFriendshipServices) {}

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
