import { IUserRepository } from './../../../../domain/ports/User/UserRepository';
import { StatusCodes } from 'http-status-codes';
import { Request, RequestHandler, Response } from 'express';
import bcrypt from "bcryptjs";
import { UserRepository } from '../../../database/repositories/UserRepository';

interface IUserLogin {
    email: string;
    password: string;
}

export const loginValidation: RequestHandler = async (req: Request<{}, {}, IUserLogin>, res: Response, next) => {
    const userRepository: IUserRepository = new UserRepository();
    
    try {
        const user = await userRepository.find({ email: req.body.email });

        if (!user) return res.status(StatusCodes.UNAUTHORIZED).json({ error: 'Invalid email or password' });

        else if (!(user instanceof Array)) {
            if (!bcrypt.compareSync(req.body.password, user.password)) {
                return res.status(StatusCodes.UNAUTHORIZED).json({ error: 'Invalid email or password' });
            }
        }
        res.locals.user = user;
        next();

    } catch (error: any) {
        return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json(error.message);
    }
};