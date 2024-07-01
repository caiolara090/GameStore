import { UserAuthServices } from "../../../src/domain/services/UserAuthServices";
import { IUserRepository } from "../../../src/domain/ports/User/UserRepository";
import { IUser } from "../../../src/domain/entities/User";
import { SignUpRequest } from "../../../src/adapters/api/middlewares/Auth/SignupValidation";
import bcrypt from "bcryptjs";
import { Types } from "mongoose";
import { sign } from "../../../src/utils/Token";

jest.mock("../../../src/utils/Token");
jest.mock("bcryptjs");

describe("UserAuthServices", () => {
  let userAuthServices: UserAuthServices;
  let mockUserRepository: jest.Mocked<IUserRepository>;

  beforeEach(() => {
    mockUserRepository = {
      create: jest.fn(),
      find: jest.fn(),
      findById: jest.fn(),
      update: jest.fn(),
    } as unknown as jest.Mocked<IUserRepository>;

    userAuthServices = new UserAuthServices();
    userAuthServices["userRepository"] = mockUserRepository;
  });

  describe("signToken", () => {
    test("Throws an error if JWT_SECRET is not found", () => {
      (sign as jest.Mock).mockReturnValue("JWT_SECRET_NOT_FOUND");

      expect(() =>
        userAuthServices.signToken(new Types.ObjectId() as any)
      ).toThrow("Internal Server Error");
    });

    test("Returns a valid token if JWT_SECRET is found", () => {
      const token = "valid_token";
      (sign as jest.Mock).mockReturnValue(token);

      const result = userAuthServices.signToken(new Types.ObjectId() as any);

      expect(result).toBe(token);
    });
  });

  describe("createUser", () => {
    test("Hashes the password and creates a new user", async () => {
      const body: SignUpRequest = {
        username: "test",
        age: 25,
        email: "test@example.com",
        password: "password123",
      };
      const hashedPassword = "hashed_password";
      (bcrypt.hashSync as jest.Mock).mockReturnValue(hashedPassword);
      const createdUser: IUser = { ...body, password: hashedPassword } as IUser;
      mockUserRepository.create.mockResolvedValue(createdUser);

      const result = await userAuthServices.createUser(body);

      expect(result).toEqual(createdUser);
    });
  });

  describe("findByEmail", () => {
    test("Finds a user by email", async () => {
      const email = "test@example.com";
      const foundUser: IUser = {
        username: "test",
        email,
        password: "password123",
      } as IUser;
      mockUserRepository.find.mockResolvedValue(foundUser);

      const result = await userAuthServices.findByEmail(email);

      expect(result).toEqual(foundUser);
    });
  });

  describe("findByUsername", () => {
    test("Finds a user by username", async () => {
      const username = "test";
      const foundUser: IUser = {
        username,
        email: "test@example.com",
        password: "password123",
      } as IUser;
      mockUserRepository.find.mockResolvedValue(foundUser);

      const result = await userAuthServices.findByUsername(username);

      expect(result).toEqual(foundUser);
    });
  });
});
