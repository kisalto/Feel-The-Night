CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public."user" (user_id, nickname, discord_id, is_mod, is_veteran)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'nickname', 'NewUser'),
    COALESCE(NEW.raw_user_meta_data->>'discord_id', ''),
    COALESCE((NEW.raw_user_meta_data->>'is_mod')::boolean, false),
    COALESCE((NEW.raw_user_meta_data->>'is_veteran')::boolean, false)
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE TRIGGER on_auth_user_created
AFTER INSERT ON auth.users
FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();