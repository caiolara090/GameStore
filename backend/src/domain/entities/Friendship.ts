export interface IFriendship {
  user: string;
  friend: string;
}

export class Friendship implements IFriendship {
  constructor(
    public user: string,
    public friend: string,
  ) {}
}
