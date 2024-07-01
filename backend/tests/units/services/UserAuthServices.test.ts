import { UserAuthServices } from "../../../src/domain/services/UserAuthServices";
import { Types } from "mongoose";

describe("UserAuthServices", () => {
  let userAuthServices: UserAuthServices;

  beforeEach(() => {
    userAuthServices = new UserAuthServices();
  });

  describe("signToken", () => {
    test("Signs a token correctly", () => {
      process.env.JWT_SECRET = "test";

      const token = userAuthServices.signToken(new Types.ObjectId() as any);

      expect(token).toBeTruthy();
    });

    test("Try to sign before a secret is defined", () => {
      delete process.env.JWT_SECRET;

      expect(() =>
        userAuthServices.signToken(new Types.ObjectId() as any)
      ).toThrow("Internal Server Error");
    });
  });
});
