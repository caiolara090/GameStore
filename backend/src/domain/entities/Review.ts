export interface IReview {
  description: string;
  rating: number;
  userId: string;
  gameId: string;
}

export class Review implements IReview {
  constructor(
    public description: string,
    public rating: number,
    public userId: string,
    public gameId: string
  ) {}
}
