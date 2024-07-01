import { UserServices } from "../../src/domain/services/UserServices";
import { IUserRepository } from "../../src/domain/ports/User/UserRepository";

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
    const usersList = ["user1", "user2", "test"];
    const username = "user";

    mockUserRepository.find.mockImplementation(async (query: any) => {
      return usersList.filter((u) => u.includes(query.username.$regex));
    });

    const result = await userServices.searchUsers(username);

    expect(result).toStrictEqual(["user1", "user2"]);
  });

  it("should return null when no users found by username", async () => {
    const usersList = ["user1", "user2", "test"];
    const username = "nonexistinguser";

    mockUserRepository.find.mockImplementation(async (user: any) => {
      const users = usersList.filter((u) => u.includes(user.username.$regex));

      if (!users.length) return null;
      return users;
    });

    const result = await userServices.searchUsers(username);

    expect(result).toBeNull();
  });
});
