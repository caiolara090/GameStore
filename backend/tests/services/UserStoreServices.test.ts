import { UserStoreServices } from "../../src/domain/services/UserStoreServices";
import { IUserRepository } from "../../src/domain/ports/User/UserRepository";
import { IGameRepository } from "../../src/domain/ports/Game/GameRepository";

describe("UserStoreServices", () => {
  let userStoreServices: UserStoreServices;
  let mockUserRepository: jest.Mocked<Partial<IUserRepository>> & {
    findById: jest.Mock;
    addGame: jest.Mock;
    addCredits: jest.Mock;
  };
  let mockGameRepository: jest.Mocked<Partial<IGameRepository>> & {
    findById: jest.Mock;
  };

  beforeEach(() => {
    mockUserRepository = {
      findById: jest.fn(),
      addGame: jest
        .fn()
        .mockImplementation(async (_userId: string, _gameId: string) => {}),
      addCredits: jest
        .fn()
        .mockImplementation(async (_userId: string, _credits: number) => {}),
    };

    mockGameRepository = {
      findById: jest.fn(),
    };

    userStoreServices = new UserStoreServices();
    (userStoreServices as any).userRepository = mockUserRepository;
    (userStoreServices as any).gameRepository = mockGameRepository;
  });

  it("should buy a game successfully", async () => {
    const gameId = "id1";
    const game = { _id: gameId, price: 50 };
    const userId = "id2";
    const user: { _id: string; credits: number; games: (typeof game)[] } = {
      _id: userId,
      credits: 100,
      games: [],
    };

    mockUserRepository.findById.mockResolvedValue(user);
    mockGameRepository.findById.mockResolvedValue(game);

    mockUserRepository.addGame.mockImplementation(
      async (_userId: string, _gameId: string) => {
        user.games.push(game);
      }
    );

    mockUserRepository.addCredits.mockImplementation(
      async (_userId: string, credits: number) => {
        user.credits += credits;
      }
    );

    await userStoreServices.buyGame(userId, gameId);

    expect(user.credits).toBe(50);
    expect(user.games[0]).toEqual(game);
  });

  it("should throw an error when user is not found", async () => {
    mockUserRepository.findById.mockResolvedValue(null);

    await expect(
      userStoreServices.buyGame("invalidUser", "game1")
    ).rejects.toThrow("User not found");
  });

  it("should throw an error when game is not found", async () => {
    const user = { _id: "user1", credits: 100, games: [] };

    mockUserRepository.findById.mockResolvedValue(user);
    mockGameRepository.findById.mockResolvedValue(null);

    await expect(
      userStoreServices.buyGame("user1", "invalidGame")
    ).rejects.toThrow("Game not found");
  });

  it("should throw an error when game is already bought", async () => {
    const userId = "user1";
    const gameId = "game1";
    const user = {
      _id: userId,
      credits: 100,
      games: [{ game: { _id: gameId } }],
    };
    const game = { _id: gameId, price: 50 };

    mockUserRepository.findById.mockResolvedValue(user);
    mockGameRepository.findById.mockResolvedValue(game);

    await expect(userStoreServices.buyGame(userId, gameId)).rejects.toThrow(
      "Game already bought"
    );
  });

  it("should throw an error when user has insufficient credits", async () => {
    const userId = "user1";
    const gameId = "game1";
    const user = { _id: userId, credits: 30, games: [] };
    const game = { _id: gameId, price: 50 };

    mockUserRepository.findById.mockResolvedValue(user);
    mockGameRepository.findById.mockResolvedValue(game);

    await expect(userStoreServices.buyGame(userId, gameId)).rejects.toThrow(
      "Insufficient credits"
    );
  });

  it("should add credits successfully", async () => {
    const userId = "user1";
    const credits = 100;
    const user = { _id: userId, credits: 0 };

    mockUserRepository.addCredits.mockImplementation(
      async (_userId: string, credits: number) => {
        user.credits += credits;
      }
    );

    await userStoreServices.addCredits(userId, credits);

    expect(user.credits).toBe(100);
  });

  it("should throw an error when adding credits fails", async () => {
    mockUserRepository.addCredits.mockImplementation(
      async (_userId: string, _credits: number) => {
        throw new Error("Failed to add credits");
      }
    );

    await expect(userStoreServices.addCredits("user1", 100)).rejects.toThrow(
      "Error adding credits: Failed to add credits"
    );
  });
});
