import { StatusCodes } from "http-status-codes";
import { Request, RequestHandler, Response } from "express";
import bcrypt from "bcryptjs";
import { IUserAuthServices } from "../../../../domain/ports/User/UserAuthServices";
import { UserAuthServices } from "../../../../domain/services/userAuthServices";

export interface LoginRequest {
  email: string;
  password: string;
}

export const loginValidation: RequestHandler = async (
  req: Request<{}, {}, LoginRequest>,
  res: Response,
  next
) => {
  const userAuthService: IUserAuthServices = new UserAuthServices();

  try {
    const user = await userAuthService.findByEmail(req.body.email);

    if (!user)
      return res.status(StatusCodes.UNAUTHORIZED).json({
        error: "Invalid email or password",
      });
    else if (!(user instanceof Array)) {
      if (!bcrypt.compareSync(req.body.password, user.password)) {
        return res.status(StatusCodes.UNAUTHORIZED).json({
          error: "Invalid email or password",
        });
      }
    }
    res.locals.user = user;
    next();
  } catch (error: any) {
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
      error: error.message,
    });
  }
};
