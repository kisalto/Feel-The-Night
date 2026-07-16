import { Request, Response } from 'express'
import { UserService } from '../services/user.service'

export const UserController = {
  index: async (req: Request, res: Response) => {
    res.json(await UserService.listUsers())
  },
  store: async (req: Request, res: Response) => {
    const user = await UserService.registerUser(req.body)
    res.status(201).json(user)
  },
}