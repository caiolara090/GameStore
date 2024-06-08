import { Types } from 'mongoose';

export interface IUserGame {
  game: string,
  favorite: boolean,
}

export interface IUser {
  username: string;
  email: string;
  password: string;
  games: IUserGame[];
  _id?: string;
}

export class User implements IUser {
  constructor(
    public username: string,
    public email: string,
    public password: string,
    public games: IUserGame[],
    public _id?: string,
  ) {}
}
