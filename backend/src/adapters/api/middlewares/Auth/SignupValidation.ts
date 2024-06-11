import { StatusCodes } from "http-status-codes";
import { Request, RequestHandler } from "express";
import { IUserRepository } from "../../../../domain/ports/User";
import { UserRepository } from "../../../database/repositories/UserRepository";

export interface SignUpRequest {
    username: string;
    age: number;
    email: string;
    password: string;
}

export const checkDuplicateEmail : RequestHandler = async (req: Request<{}, {}, SignUpRequest>, res, next) => {
    const userRepository: IUserRepository = new UserRepository();

    try {
        const user = await userRepository.find({ email: req.body.email });
        if (user) return res.status(StatusCodes.BAD_REQUEST).json({ 
            error: 'E-mail already registered' 
        });
    } catch (err) {
        return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({ err });
    }

    return next();
}

export const checkDuplicateUsername : RequestHandler = async (req: Request<{}, {}, SignUpRequest>, res, next) => {
    const userRepository: IUserRepository = new UserRepository();

    try {
        const user = await userRepository.find({ username: req.body.username });
        if (user) return res.status(StatusCodes.BAD_REQUEST).json({ 
            error: 'Username already registered' 
        });
    } catch (err) {
        return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({ err });
    }

    return next();
}