import { Types } from 'mongoose';

export interface IUserGame {
  game: Types.ObjectId,
  favorite: boolean,
}

export interface IUser {
  username: string;
  email: string;
  password: string;
  games: IUserGame[];
  id?: Types.ObjectId;
}

export class User implements IUser {
  constructor(
    public username: string,
    public email: string,
    public password: string,
    public games: IUserGame[],
    public id?: Types.ObjectId,
  ) {}
}
