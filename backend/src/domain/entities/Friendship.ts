import { Types } from 'mongoose';

export interface IFriendship {
  user: string;
  friend: string;
  _id?: string;
}

export class Friendship implements IFriendship {
  constructor(
    public user: string,
    public friend: string,
    public _id?: string,
  ) {}
}
