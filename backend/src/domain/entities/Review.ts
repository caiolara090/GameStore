export interface IReview {
  description: string;
  rating: number;
  userId: string;
  gameId: string;
  _id?: string;
}

export interface IReviewRequest {
  userId: string;
  gameId: string;
  rating: number;
  description: string;
  _id?: string;
}
