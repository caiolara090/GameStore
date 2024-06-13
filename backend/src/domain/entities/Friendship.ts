export interface IFriendship {
  userId: string;
  friendId: string;
  status: number;
}

export class Friendship implements IFriendship {
  constructor(
    public userId: string,
    public friendId: string,
    public status: number,
  ) {}
}
