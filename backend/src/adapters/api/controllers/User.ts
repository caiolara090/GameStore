import { StatusCodes } from "http-status-codes";
import { Request, Response } from "express";
import { UserServices } from "../../../domain/services/UserServices";
import { IUserServices } from "../../../domain/ports/User/UserServices";

export const searchUsers = async (req: Request, res: Response) => {
  const userService: IUserServices = new UserServices();
  const { name, fields, page, limit } = req.body;

  try {
    const users = userService.searchUsers(name, fields, page, limit);

    return res.status(StatusCodes.OK).json({
      users: users,
    });
  } catch (error: any) {
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
      error: error.message,
    });
  }
};
