import { Friendship } from "../../entities/Friendship";

export interface IFriendshipRepository {
  create(friendship: Friendship): Promise<void>;
  delete(_id: string): Promise<void>;
  find(friendship: Partial<Friendship>): Promise<Friendship | Friendship[] | null>;
}
