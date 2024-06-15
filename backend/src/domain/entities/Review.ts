export interface IReview {
  description: string;
  rating: number;
  user: string;
  game: string;
}

export class Review implements IReview {
  constructor(
    public description: string,
    public rating: number,
    public user: string,
    public game: string
  ) {}
}
