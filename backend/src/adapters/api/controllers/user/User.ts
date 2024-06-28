import { StatusCodes } from "http-status-codes";
import { Request, Response } from "express";
import { UserServices } from "../../../../domain/services/UserServices";
import { IUserServices } from "../../../../domain/ports/User/UserServices";
import { UserLibraryServices } from "../../../../domain/services/UserLibraryServices";
import { IUserLibraryServices } from "../../../../domain/ports/User/UserLibraryServices";

export const searchUsers = async (req: Request, res: Response) => {
  const userService: IUserServices = new UserServices();
  const { username, fields } = req.body;

  try {
    const users = await userService.searchUsers(username, fields);
    console.log(users);
    return res.status(StatusCodes.OK).json({
      users: users,
    });
  } catch (error: any) {
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
      error: error.message,
    });
  }
};

export const searchUsersLibrary = async (req: Request, res: Response) => {
  const userLibraryService: IUserLibraryServices = new UserLibraryServices();
  const { userId, gameTitle } = req.body;

  try {
    const library = await userLibraryService.searchUsersLibrary(userId, gameTitle);

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
