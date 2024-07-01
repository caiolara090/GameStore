import { Request, Response } from 'express';
import { IUserLibraryServices } from '../../../../domain/ports/User/UserLibraryServices';
import { UserLibraryServices } from '../../../../domain/services/UserLibraryServices';
import { StatusCodes } from 'http-status-codes';

export const getUserLibrary = async (req: Request, res: Response) => {
  const userLibraryServices: IUserLibraryServices = new UserLibraryServices();

  try {
    const user = req.query.userId as string;
    if (!user) {
      res.status(StatusCodes.BAD_REQUEST).send("Error getting user library: userId is required");
      return;
    }
    const library = await userLibraryServices.getUserLibrary(user);
    res.status(StatusCodes.OK).json(library);
  } catch (error: any) {
    res.status(StatusCodes.BAD_REQUEST).send("Error getting user library: " + error.message);
  }
}

export const getUserGames = async (req: Request, res: Response) => {
  const userLibraryServices: IUserLibraryServices = new UserLibraryServices();

  try {
    const user = req.query.userId as string;
    if (!user) {
      res.status(StatusCodes.BAD_REQUEST).send("Error getting user games: userId is required");
      return;
    }
    const games = await userLibraryServices.getUserGames(user);
    res.status(StatusCodes.OK).json(games);
  } catch (error: any) {
    res.status(StatusCodes.BAD_REQUEST).send("Error getting user games: " + error.message);
  }
}

export const searchUsersLibrary = async (req: Request, res: Response) => {
  const userLibraryService: IUserLibraryServices = new UserLibraryServices();
  const { userId, gameTitle } = req.body;

  try {
    const library = await userLibraryService.searchUserLibrary(userId, gameTitle);

    return res.status(StatusCodes.OK).json({
      library: library,
    });
  } catch (error: any) {
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
      error: error.message,
    });
  }
};

export const setGameFavorite = async (req: Request, res: Response) => {
  const userLibraryService: IUserLibraryServices = new UserLibraryServices();
  const { userId, gameId } = req.body;

  try {
    await userLibraryService.setGameFavorite(userId, gameId);

    return res.status(StatusCodes.OK).json({
      message: "Favorite status updated",
    });
  } catch (error: any) {
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
      error: error.message,
    });
  }
};
