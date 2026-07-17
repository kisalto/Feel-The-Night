import 'dotenv/config'; 
import express from 'express'; 
import { supabase } from '../src/config/supabase';
import userRoutes from '../src/routes/userRoutes';

const app = express();
app.use(express.json());

app.use('/api/users', userRoutes);

// O Vercel não precisa do app.listen(), mas seu ambiente local precisa!
if (process.env.NODE_ENV !== 'production') {
  const PORT = process.env.PORT || 3000;
  app.listen(PORT, () => console.log(`Servidor rodando na porta ${PORT}`));
}

export default app;