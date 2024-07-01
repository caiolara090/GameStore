import { UserLibraryServices } from "../../../src/domain/services/UserLibraryServices";
import { IUserRepository } from "../../../src/domain/ports/User/UserRepository";
import { IUserRepositoryGame } from "../../../src/domain/ports/User/UserRepository";
import { ILibrary } from "../../../src/domain/ports/User/UserLibraryServices";
import { IUserGame } from "../../../src/domain/entities/User";

describe("UserLibraryServices", () => {
  let userLibraryServices: UserLibraryServices;
  let mockUserRepository: jest.Mocked<IUserRepository>;

  beforeEach(() => {
    mockUserRepository = {
      getGames: jest.fn(),
      findById: jest.fn(),
      update: jest.fn(),
      retrieveUserLibrary: jest.fn(),
    } as unknown as jest.Mocked<IUserRepository>;

    userLibraryServices = new UserLibraryServices();
    (userLibraryServices as any).userRepository = mockUserRepository;
  });

  describe("getUserLibrary", () => {
    it("should return favorites and notFavorites games", async () => {
      const games: IUserRepositoryGame[] = [
        { name: "Game 1", image: "", favorite: true },
        { name: "Game 2", image: "", favorite: false },
      ];
      mockUserRepository.getGames.mockResolvedValue(games);

      const result: ILibrary = await userLibraryServices.getUserLibrary(
        "userId"
      );
      expect(result.favorites).toEqual([games[0]]);
      expect(result.notFavorites).toEqual([games[1]]);
    });

    it("should throw an error when there is an issue getting the games", async () => {
      mockUserRepository.getGames.mockRejectedValue(
        new Error("Error fetching games")
      );
      await expect(
        userLibraryServices.getUserLibrary("userId")
      ).rejects.toThrow("Error getting user library: Error fetching games");
    });
  });

  describe("getUserGames", () => {
    it("should return user games", async () => {
      const games: IUserRepositoryGame[] = [
        { name: "Game 1", image: "", favorite: false },
      ];
      mockUserRepository.getGames.mockResolvedValue(games);

      const result = await userLibraryServices.getUserGames("userId");
      expect(result).toEqual(games);
    });

    it("should throw an error when there is an issue getting user games", async () => {
      mockUserRepository.getGames.mockRejectedValue(
        new Error("Error fetching user games")
      );
      await expect(userLibraryServices.getUserGames("userId")).rejects.toThrow(
        "Error getting user games: Error fetching user games"
      );
    });
  });

  describe("searchUserLibrary", () => {
    it("should return filtered games by title", async () => {
      const games: IUserGame[] = [
        {
          game: {
            _id: "1",
            name: "Game 1",
            description: "",
            image: "",
            price: 0,
          },
          favorite: false,
        },
        {
          game: {
            _id: "2",
            name: "Game 2",
            description: "",
            image: "",
            price: 10,
          },
          favorite: true,
        },
      ];
      mockUserRepository.retrieveUserLibrary.mockResolvedValue(games);

      const result = await userLibraryServices.searchUserLibrary(
        "userId",
        "Game"
      );
      expect(result).toEqual([
        {
          game: { name: "Game 1", description: "", image: "" },
          favorite: false,
        },
        {
          game: { name: "Game 2", description: "", image: "" },
          favorite: true,
        },
      ]);
    });

    it("should return an empty array when no games match the title", async () => {
      const games: IUserGame[] = [
        {
          game: {
            _id: "1",
            name: "Game 1",
            description: "",
            image: "",
            price: 0,
          },
          favorite: false,
        },
        {
          game: {
            _id: "2",
            name: "Game 2",
            description: "",
            image: "",
            price: 10,
          },
          favorite: true,
        },
      ];
      mockUserRepository.retrieveUserLibrary.mockResolvedValue(games);

      const result = await userLibraryServices.searchUserLibrary(
        "userId",
        "Nonexistent"
      );
      expect(result).toEqual([]);
    });
  });

  describe("setGameFavorite", () => {
    it("should set game as favorite/unfavorite", async () => {
      const user = {
        _id: "userId",
        credits: 100,
        games: [
          {
            game: {
              _id: "1",
              name: "Game 1",
              description: "",
              price: 0,
              image: "",
            },
            favorite: false,
          },
          {
            game: {
              _id: "2",
              name: "Game 2",
              description: "",
              price: 0,
              image: "",
            },
            favorite: true,
          },
        ],
        username: "example",
        age: 25,
        email: "example@example.com",
        password: "password",
      };

      mockUserRepository.findById.mockResolvedValue(user);

      await userLibraryServices.setGameFavorite("userId", "1");
      expect(user.games[0].favorite).toBe(true);

      await userLibraryServices.setGameFavorite("userId", "1");
      expect(user.games[0].favorite).toBe(false);
    });

    it("should throw an error if user is not found", async () => {
      mockUserRepository.findById.mockResolvedValue(null);
      await expect(
        userLibraryServices.setGameFavorite("userId", "1")
      ).rejects.toThrow("User not found");
    });

    it("should throw an error if user has no games", async () => {
      const user = {
        _id: "userId",
        credits: 100,
        games: undefined,
        username: "example",
        age: 25,
        email: "example@example.com",
        password: "password",
      };
      mockUserRepository.findById.mockResolvedValue(user);

      await expect(
        userLibraryServices.setGameFavorite("userId", "1")
      ).rejects.toThrow("User has no games");
    });

    it("should throw an error if game is not found in user library", async () => {
      const user = {
        _id: "userId",
        games: [
          {
            game: {
              _id: "2",
              name: "Game 2",
              description: "",
              price: 0,
              image: "",
            },
            favorite: true,
          },
        ],
        username: "example",
        age: 25,
        email: "example@example.com",
        password: "password",
      };
      mockUserRepository.findById.mockResolvedValue(user);

      await expect(
        userLibraryServices.setGameFavorite("userId", "1")
      ).rejects.toThrow("Game not found in user's library");
    });
  });
});
