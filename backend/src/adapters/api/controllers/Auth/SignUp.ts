import { StatusCodes } from 'http-status-codes';
import { Request, Response } from 'express';
import { SignUpRequest } from '../../middlewares/Auth/SignupValidation'; 
import { IUserRepository } from '../../../../domain/ports/User';
import { UserRepository } from '../../../database/repositories/UserRepository';
import bcrypt from 'bcryptjs';

export const signUp = async (req: Request<{}, {}, SignUpRequest>, res: Response) => {
    const userRepository: IUserRepository = new UserRepository();

    try {
        req.body.password = bcrypt.hashSync(req.body.password);
        await userRepository.create(req.body);

        return res.status(StatusCodes.CREATED).json({ 
            message: 'Signup successful' 
        })
    } catch (error: any) {
        return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json(error.message)
    }
}