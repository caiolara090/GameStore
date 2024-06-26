import { StatusCodes } from "http-status-codes";
import { Request, Response } from "express";
import { UserAuthServices } from "../../../../domain/services/UserAuthServices";
import { IUserAuthServices } from "../../../../domain/ports/User/UserAuthServices";

export const login = async (_req: Request, res: Response) => {
  const user = res.locals.user;
  const userService: IUserAuthServices = new UserAuthServices();

  if (user) {
    try {
      const accessToken = userService.signToken(user._id);

      if (accessToken === "JWT_SECRET_NOT_FOUND") {
        return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
          error: "Internal server error",
        });
      }
      res.cookie("access_token", accessToken, { httpOnly: true });

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
