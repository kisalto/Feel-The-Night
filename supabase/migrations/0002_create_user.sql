CREATE TABLE IF NOT EXISTS public."user" (
    user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    nickname TEXT NOT NULL,
    discord_id TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    events_count INT DEFAULT 0,
    guides_count INT DEFAULT 0,
    is_mod BOOLEAN DEFAULT false,
    is_veteran BOOLEAN DEFAULT false
);

ALTER TABLE public."user" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read access to profiles"
ON public."user" FOR SELECT
TO public
USING (true);

CREATE POLICY "Allow users to update their own profile"
ON public."user" FOR UPDATE
TO authenticated
USING (auth.uid() = user_id);
