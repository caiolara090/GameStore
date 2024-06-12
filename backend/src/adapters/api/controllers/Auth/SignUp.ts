import { StatusCodes } from "http-status-codes";
import { Request, Response } from "express";
import { SignUpRequest } from "../../middlewares/Auth/SignupValidation";
import { UserAuthServices } from "../../../../domain/services/userAuthServices";
import { IUserAuthServices } from "../../../../domain/ports/User/UserAuthServices";

export const signUp = async (
  req: Request<{}, {}, SignUpRequest>,
  res: Response
) => {
  const userService: IUserAuthServices = new UserAuthServices();

  try {
    userService.createUser(req.body);
    return res.status(StatusCodes.CREATED).json({
      message: "Signup successful",
    });
  } catch (error: any) {
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
      error: error.message,
    });
  }
};
