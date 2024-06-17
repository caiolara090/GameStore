export interface IReview {
  description: string;
  rating: number;
  userId: string;
  gameId: string;
}

export interface IReviewRequest {
  userId: string;
  gameId: string;
  rating: number;
  description: string;
}
