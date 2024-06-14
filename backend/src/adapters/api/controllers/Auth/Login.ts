import { StatusCodes } from "http-status-codes";
import { Request, Response } from "express";
import { UserAuthServices } from "../../../../domain/services/userAuthServices";
import { IUserAuthServices } from "../../../../domain/ports/User/UserAuthServices";

export const login = async (_req: Request, res: Response) => {
  const user = res.locals.user;
  const userService: IUserAuthServices = new UserAuthServices();

  if (user) {
    try {
      const id = user._id;
      userService.signToken(id);

      return res.status(StatusCodes.OK).json({
        message: "Login successful",
        info: user,
      });
    } catch (error: any) {
      return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
        error: error.message,
      });
    }
  }
};
