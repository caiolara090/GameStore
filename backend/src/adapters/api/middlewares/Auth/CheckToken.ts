import { RequestHandler } from "express";
import { StatusCodes } from "http-status-codes";
import { verify } from "../../../../utils/Token";

export const checkJwtToken: RequestHandler = async (req, res, next) => {
  const token = req.cookies["access_token"];
  const userId = req.body.userId || req.query.userId;

  if (!token)
    return res.status(StatusCodes.FORBIDDEN).json({
      error: "Access denied",
    });

  const jwtData = verify(token);

  if (jwtData === "JWT_SECRET_NOT_FOUND") {
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
      error: "The JWT_SECRET was not defined",
    });
  } else if (jwtData === "INVALID_TOKEN") {
    return res.status(StatusCodes.FORBIDDEN).json({
      error: "Token verification failed",
    });
  } else if (
    userId !== String(jwtData.uid) &&
    String(jwtData.uid) !== process.env.ADMIN
  ) {
    return res.status(StatusCodes.FORBIDDEN).json({
      error: "Access denied",
    });
  }
  return next();
};
