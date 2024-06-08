import { Types } from 'mongoose';

export interface IFriendship {
  user: Types.ObjectId;
  friend: Types.ObjectId;
  id?: Types.ObjectId;
}

export class Friendship implements IFriendship {
  constructor(
    public user: Types.ObjectId,
    public friend: Types.ObjectId,
    public id?: Types.ObjectId,
  ) {}
}
