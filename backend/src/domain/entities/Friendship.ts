// Status 0 para enviada, 1 para pendente, 2 para aceita
export interface IFriendship {
  userId: string;
  friendId: string;
  status: number;
  _id?: string;
}

export class Friendship implements IFriendship {
  constructor(
    public userId: string,
    public friendId: string,
    public status: number,
    public _id?: string
  ) {}
}
