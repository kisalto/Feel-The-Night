-- IMPORTANT: Enable Row Level Security on Supabase storage objects table
-- ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

-- =========================================================================
-- CHARACTER IMAGES BUCKET
-- =========================================================================
INSERT INTO storage.buckets (id, name, public) 
VALUES ('character-images', 'character-images', true)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "Public Access Character Images" 
ON storage.objects FOR SELECT TO public 
USING (bucket_id = 'character-images');

CREATE POLICY "Authenticated Uploads Character Images" 
ON storage.objects FOR INSERT TO authenticated 
WITH CHECK (bucket_id = 'character-images');


-- =========================================================================
-- GUIDE BANNERS BUCKET
-- =========================================================================
INSERT INTO storage.buckets (id, name, public) 
VALUES ('guide-banner', 'guide-banner', true)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "Public Access Guide Banners" 
ON storage.objects FOR SELECT TO public 
USING (bucket_id = 'guide-banner');

CREATE POLICY "Authenticated Uploads Guide Banners" 
ON storage.objects FOR INSERT TO authenticated 
WITH CHECK (bucket_id = 'guide-banner');


-- =========================================================================
-- EVENT BANNERS BUCKET
-- =========================================================================
INSERT INTO storage.buckets (id, name, public) 
VALUES ('event-banner', 'event-banner', true)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "Public Access Event Banners" 
ON storage.objects FOR SELECT TO public 
USING (bucket_id = 'event-banner');

CREATE POLICY "Authenticated Uploads Event Banners" 
ON storage.objects FOR INSERT TO authenticated 
WITH CHECK (bucket_id = 'event-banner');
