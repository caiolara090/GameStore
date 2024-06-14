// Status 0 para enviada, 1 para pendente, 2 para aceita
export interface IFriendship {
  userId: string;
  friendId: string;
  status: number;
  _id?: string;
}

export interface IFriendshipRequest {
  userId: string;
  friendId: string;
}
