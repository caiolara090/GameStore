import { GameServices } from '../../../src/domain/services/GameServices';
import { IGameRepository } from '../../../src/domain/ports/Game/GameRepository';
import { IGame } from '../../../src/domain/entities/Game';

describe('GameServices', () => {
  let gameServices: GameServices;
  let mockGameRepository: jest.Mocked<IGameRepository>;

  beforeEach(() => {
    mockGameRepository = {
      retrieveGames: jest.fn(),
      getPopularGames: jest.fn(),
    } as unknown as jest.Mocked<IGameRepository>;

    gameServices = new GameServices();
    (gameServices as any).gameRepository = mockGameRepository;
  });

  describe('searchGames', () => {
    it('should return games matching the search title', async () => {
      const games = [{ name: 'Game1' }, { name: 'Game2' }] as IGame[];
      mockGameRepository.retrieveGames.mockResolvedValueOnce(games);

      const result = await gameServices.searchGames('Game', 'name');

      expect(result).toEqual(games);
      expect(mockGameRepository.retrieveGames).toHaveBeenCalledWith(
        { name: { $regex: 'Game', $options: 'iu' } },
        'name'
      );
    });

    it('should return null if no games match the search title', async () => {
      mockGameRepository.retrieveGames.mockResolvedValueOnce(null);

      const result = await gameServices.searchGames('NonExistentGame', 'name');

      expect(result).toBeNull();
      expect(mockGameRepository.retrieveGames).toHaveBeenCalledWith(
        { name: { $regex: 'NonExistentGame', $options: 'iu' } },
        'name'
      );
    });

    it('should throw an error if retrieveGames fails', async () => {
      mockGameRepository.retrieveGames.mockRejectedValueOnce(new Error('Database error'));

      await expect(gameServices.searchGames('Game', 'name')).rejects.toThrow('Database error');
    });
  });

  describe('getPopularGames', () => {
    it('should return popular games', async () => {
      const games = [{ name: 'PopularGame1' }, { name: 'PopularGame2' }] as IGame[];
      mockGameRepository.getPopularGames.mockResolvedValueOnce(games);

      const result = await gameServices.getPopularGames();

      expect(result).toEqual(games);
      expect(mockGameRepository.getPopularGames).toHaveBeenCalled();
    });

    it('should return null if no popular games are found', async () => {
      mockGameRepository.getPopularGames.mockResolvedValueOnce(null);

      const result = await gameServices.getPopularGames();

      expect(result).toBeNull();
      expect(mockGameRepository.getPopularGames).toHaveBeenCalled();
    });

    it('should throw an error if getPopularGames fails', async () => {
      mockGameRepository.getPopularGames.mockRejectedValueOnce(new Error('Database error'));

      await expect(gameServices.getPopularGames()).rejects.toThrow('Database error');
    });
  });
});
