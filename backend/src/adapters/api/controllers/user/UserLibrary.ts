import { Request, Response } from 'express';
import { IUserLibraryServices } from '../../../../domain/ports/User/UserLibraryServices';
import { UserLibraryServices } from '../../../../domain/services/UserLibraryServices';

export const getUserLibrary = async (req: Request, res: Response) => {
  const userLibraryServices: IUserLibraryServices = new UserLibraryServices();

  try {
    const user = req.query.userId as string;
    if (!user) {
      res.status(400).send("Error getting user library: userId is required");
      return;
    }
    const library = await userLibraryServices.getUserLibrary(user);
    res.status(200).json(library);
  } catch (error: any) {
    res.status(400).send("Error getting user library: " + error.message);
  }
}

export const getUserGames = async (req: Request, res: Response) => {
  const userLibraryServices: IUserLibraryServices = new UserLibraryServices();

  try {
    const user = req.query.userId as string;
    if (!user) {
      res.status(400).send("Error getting user games: userId is required");
      return;
    }
    const games = await userLibraryServices.getUserGames(user);
    res.status(200).json(games);
  } catch (error: any) {
    res.status(400).send("Error getting user games: " + error.message);
  }
}
