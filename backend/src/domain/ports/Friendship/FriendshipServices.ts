import { IFriendship } from "../../entities/Friendship";

export interface IFriendshipServices {
  createFriendshipRequest(userId: string, friendId: string): Promise<void>;
  acceptFriendshipRequest(userId: string, friendId: string): Promise<void>;
  rejectFriendshipRequest(userId: string, friendId: string): Promise<void>;
  delete(userId: string, friendId: string): Promise<void>;
  find(friendship: Partial<IFriendship>): Promise<IFriendship | IFriendship[] | null>;
}
