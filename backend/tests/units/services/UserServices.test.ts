import { UserServices } from "../../../src/domain/services/UserServices";
import { IUserRepository } from "../../../src/domain/ports/User/UserRepository";

describe("UserServices", () => {
  let userServices: UserServices;
  let mockUserRepository: jest.Mocked<Partial<IUserRepository>> & {
    findById: jest.Mock;
    find: jest.Mock;
  };

  beforeEach(() => {
    mockUserRepository = {
      findById: jest.fn(),
      find: jest.fn().mockImplementation(),
    };
    userServices = new UserServices();
    (userServices as any).userRepository = mockUserRepository;
  });

  it("should search users by username", async () => {
    const users = [
      {
        _id: "userId",
        credits: 100,
        games: [],
        username: "example",
        age: 25,
        email: "example@example.com",
        password: "password",
      },
      {
        _id: "userId2",
        credits: 50,
        games: [],
        username: "example2",
        age: 25,
        email: "something@example.com",
        password: "password",
      },
    ];
    mockUserRepository.find.mockResolvedValue(users);

    const result = await userServices.searchUsers("user");

    expect(result).toBe(users);
  });

  it("should return null when no users found by username", async () => {
    const users = [
      {
        _id: "userId",
        credits: 100,
        games: [],
        username: "example",
        age: 25,
        email: "example@example.com",
        password: "password",
      },
    ];

    mockUserRepository.find.mockResolvedValue(null);

    const result = await userServices.searchUsers("nonexistinguser");

    expect(result).toBeNull();
  });
});
