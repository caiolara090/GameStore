import { StatusCodes } from "http-status-codes";
import { Request, RequestHandler } from "express";
import { IUserAuthServices } from "../../../../domain/ports/User/UserAuthServices";
import { UserAuthServices } from "../../../../domain/services/userAuthServices";

export interface SignUpRequest {
  username: string;
  age: number;
  email: string;
  password: string;
}

export const checkDuplicateEmail: RequestHandler = async (
  req: Request<{}, {}, SignUpRequest>,
  res,
  next
) => {
  const userAuthService: IUserAuthServices = new UserAuthServices();

  try {
    const user = await userAuthService.findByEmail(req.body.email);
    if (user)
      return res.status(StatusCodes.BAD_REQUEST).json({
        error: "E-mail already registered",
      });
  } catch (error: any) {
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
      error: error.message,
    });
  }

  return next();
};

export const checkDuplicateUsername: RequestHandler = async (
  req: Request<{}, {}, SignUpRequest>,
  res,
  next
) => {
  const userAuthService: IUserAuthServices = new UserAuthServices();

  try {
    const user = await userAuthService.findByEmail(req.body.username);
    if (user)
      return res.status(StatusCodes.BAD_REQUEST).json({
        error: "Username already registered",
      });
  } catch (error: any) {
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
      error: error.message,
    });
  }

  return next();
};
