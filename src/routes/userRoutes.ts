import { Router } from 'express';
import { supabase } from '../config/supabase'; // Importa o cliente configurado e tipado

const router = Router();

// Rota para listar usuários diretamente do Supabase
router.get('/', async (req, res) => {
  try {
    // Graças ao passo de tipagem, o TypeScript vai validar se a tabela 'users' realmente existe!
    const { data, error } = await supabase
      .from('user') 
      .select('*');

    if (error) {
      return res.status(400).json({ error: error.message });
    }

    return res.json(data);
  } catch (err) {
    return res.status(500).json({ error: 'Erro interno no servidor' });
  }
});

export default router;