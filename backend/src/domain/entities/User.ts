export interface IUserGame {
  game: string;
  favorite: boolean;
}

export interface IUser {
  username: string;
  age: number;
  email: string;
  password: string;
  credits?: number;
  games?: IUserGame[];
}

export class User implements IUser {
  constructor(
    public username: string,
    public age: number,
    public email: string,
    public password: string,
    public credits?: number,
    public games?: IUserGame[]
  ) {}
}
