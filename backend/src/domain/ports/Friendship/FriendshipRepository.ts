import { IFriendship } from "../../entities/Friendship";

export interface IFriendshipRepository {
  create(friendship: IFriendship): Promise<void>;
  delete(_id: string): Promise<void>;
  find(friendship: Partial<IFriendship>): Promise<IFriendship | IFriendship[] | null>;
  findByUsers(userId: string, friendId: string): Promise<IFriendship | null>;
  update(_id: string, friendship: Partial<IFriendship>): Promise<void>;
}
