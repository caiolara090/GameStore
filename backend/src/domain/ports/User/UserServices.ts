export interface IUserServices {
  checkCredentials(username: string, password: string): Promise<boolean>;
}
