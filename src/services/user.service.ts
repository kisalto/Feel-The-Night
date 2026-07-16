import { UserModel } from '../models/user.model'

export const UserService = {
  listUsers: () => UserModel.findAll(),
  registerUser: (input: { username: string; email: string }) => UserModel.create(input),
}