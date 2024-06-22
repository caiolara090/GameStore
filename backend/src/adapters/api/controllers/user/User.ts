import { StatusCodes } from "http-status-codes";
import { Request, Response } from "express";
import { UserServices } from "../../../../domain/services/UserServices";
import { IUserServices } from "../../../../domain/ports/User/UserServices";

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
  const userService: IUserServices = new UserServices();
  const { userId, gameTitle } = req.body;

  try {
    const library = await userService.searchUsersLibrary(userId, gameTitle);

    return res.status(StatusCodes.OK).json({
      library: library,
    });
  } catch (error: any) {
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
      error: error.message,
    });
  }
};

export const toggleUsersGameFavorite = async (req: Request, res: Response) => {
  const userService: IUserServices = new UserServices();
  const { userId, gameId } = req.body;

  try {
    await userService.toggleUsersGameFavorite(userId, gameId);

    return res.status(StatusCodes.OK).json({
      message: "Favorite status updated",
    });
  } catch (error: any) {
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
      error: error.message,
    });
  }
};
