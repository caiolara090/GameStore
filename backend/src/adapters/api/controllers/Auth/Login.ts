import { StatusCodes } from 'http-status-codes';
import { Request, Response } from 'express';
import { sign } from '../../../../utils/Token';

export const login = async (_req: Request, res: Response) => {
    const user = res.locals.user;

    if (user) {
        try {
            const accessToken = sign({ uid: user._id });
            if(accessToken === 'JWT_SECRET_NOT_FOUND') {
                return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({ 
                    error: 'Internal server error' 
                });
            }
            res.cookie('access_token', accessToken, { httpOnly: true });
    
            return res.status(StatusCodes.OK).json({ 
                message: 'Login successful', info: user 
            });
        } catch (error: any) {
            return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json(error.message);
        }
    }
};