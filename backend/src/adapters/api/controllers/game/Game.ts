import { StatusCodes } from "http-status-codes";
import { Request, Response } from "express";
import { IGameServices } from "../../../../domain/ports/Game/GameServices";
import { GameServices } from "../../../../domain/services/GameServices";

export const searchGames = async (req: Request<{}, {}>, res: Response) => {
  const gameService: IGameServices = new GameServices();
  const { name, fields, sortField, page, limit } = req.body;

  try {
    const games = gameService.searchGames(name, fields, sortField, page, limit);

    return res.status(StatusCodes.OK).json({
      games: games,
    });
  } catch (error: any) {
    return res.status(StatusCodes.INTERNAL_SERVER_ERROR).json({
      error: error.message,
    });
  }
};
