import { supabase } from '../config/supabase'

export const UserModel = {
  findAll: async () => {
    const { data, error } = await supabase.from('users').select('*')
    if (error) throw error
    return data
  },
  create: async (input: { username: string; email: string }) => {
    const { data, error } = await supabase.from('users').insert(input).select().single()
    if (error) throw error
    return data
  },
}