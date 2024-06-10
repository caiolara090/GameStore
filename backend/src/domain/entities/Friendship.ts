export interface IFriendship {
  user: string;
  friend: string;
  status: number;
}

export class Friendship implements IFriendship {
  constructor(
    public user: string,
    public friend: string,
    public status: number,
  ) {}
}
