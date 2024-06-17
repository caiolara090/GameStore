import { IGame } from "./Game";

export interface IUserGame {
  game: IGame,
  favorite: boolean,
}

export interface IUser {
  userId?: string;
  username: string;
  age: number;
  email: string;
  password: string;
  credits?: number;
  games?: IUserGame[];
}
