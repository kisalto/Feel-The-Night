-- CHARACTERS
CREATE TABLE IF NOT EXISTS public.character (
    character_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    image_url TEXT,
    type TEXT NOT NULL
);

-- GUIDES
CREATE TABLE IF NOT EXISTS public.guide (
    guide_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    banner_url TEXT,
    type TEXT,
    description TEXT NOT NULL,
    link TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    likes INT DEFAULT 0,
    dislikes INT DEFAULT 0,
    user_id UUID NOT NULL REFERENCES public."user"(user_id) ON DELETE CASCADE,
    character_id UUID REFERENCES public.character(character_id) ON DELETE SET NULL
);

-- EVENTS
CREATE TABLE IF NOT EXISTS public.event (
    event_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    banner_url TEXT,
    date TIMESTAMP WITH TIME ZONE NOT NULL,
    user_id UUID NOT NULL REFERENCES public."user"(user_id) ON DELETE CASCADE
);

-- LAST EVENT DASHBOARD STATE
CREATE TABLE IF NOT EXISTS public.latest_event (
    id INT PRIMARY KEY DEFAULT 1,
    title TEXT NOT NULL,
    event_id UUID NOT NULL REFERENCES public.event(event_id) ON DELETE CASCADE,
    CONSTRAINT single_row CHECK (id = 1)
);

-- Enable RLS
ALTER TABLE public.character ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.guide ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.event ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.latest_event ENABLE ROW LEVEL SECURITY;

-- Public Select Policies
CREATE POLICY "Public Read Character" 
ON public.character 
FOR SELECT 
TO public USING (true);

CREATE POLICY "Public Read Guide" 
ON public.guide 
FOR SELECT 
TO public USING (true);

CREATE POLICY "Public Read Event" 
ON public.event 
FOR SELECT 
TO public USING (true);

CREATE POLICY "Public Read Latest Event" 
ON public.latest_event 
FOR SELECT 
TO public USING (true);

