import { searchUsers } from "./../../src/adapters/api/controllers/user/User";
import { searchGames } from "./../../src/adapters/api/controllers/game/Game";
import { UserServices } from "../../src/domain/services/UserServices";
import { IUserRepository } from "../../src/domain/ports/User/UserRepository";

describe("UserServices", () => {
  let userServices: UserServices;
  let mockUserRepository: jest.Mocked<Partial<IUserRepository>> & {
    findById: jest.Mock;
    searchUsers: jest.Mock;
  };

  beforeEach(() => {
    mockUserRepository = {
      findById: jest.fn(),
      searchUsers: jest.fn().mockImplementation(),
    };
    userServices = new UserServices();
    (userServices as any).userRepository = mockUserRepository;
  });

  it("should search users by username", async () => {
    const usernames = ["user1", "user2", "test"];
    const user = "user";

    mockUserRepository.searchUsers!.mockImplementation(() => {
      return usernames.filter((u) => u.includes(user));
    });

    const result = await userServices.searchUsers(user);

    expect(result!.length).toBe(2);
    expect(result).toStrictEqual(["user1", "user2"]);
  });

  it("should return null when no users found by username", async () => {
    const usernames = ["user1", "user2", "test"];
    const user = "nonexistinguser";

    mockUserRepository.searchUsers!.mockImplementation(
      async (username: string) => {
        const users = usernames.filter((u) => u.includes(username));

        if (!users.length) return null;
        return users;
      }
    );

    const result = await userServices.searchUsers(user);

    expect(result).toBeNull();
  });
});
