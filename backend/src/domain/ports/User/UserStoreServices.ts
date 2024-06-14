export interface IUserStoreServices {
  buyGame(userId: string, gameId: string): Promise<void>;
  addCredits(userId: string, credits: number): Promise<void>;
}