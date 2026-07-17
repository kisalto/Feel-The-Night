import { createClient } from '@supabase/supabase-js';
import { Database } from '../types/supabase'; // Caminho para o arquivo gerado no Passo 2

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  throw new Error('Faltam as variáveis de ambiente do Supabase.');
}

// Criando o cliente injetando os tipos do Database
export const supabase = createClient<Database>(supabaseUrl, supabaseServiceKey);