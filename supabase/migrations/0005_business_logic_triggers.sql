-- 1. Trigger function for guide counts
CREATE OR REPLACE FUNCTION public.increment_guide_count()
RETURNS trigger AS $$
BEGIN
    UPDATE public."user"
    SET guides_count = guides_count + 1
    WHERE user_id = NEW.user_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_guide_count
AFTER INSERT ON public.guide
FOR EACH ROW EXECUTE FUNCTION public.increment_guide_count();

-- 2. Trigger function for event counts and dashboard update
CREATE OR REPLACE FUNCTION public.increment_event_count_and_dashboard()
RETURNS trigger AS $$
BEGIN
    -- Update user counter
    UPDATE public."user"
    SET events_count = events_count + 1
    WHERE user_id = NEW.user_id;

    -- Manage dashboard state table (upsert logic for the single dashboard row)
    INSERT INTO public.latest_event (id, title, event_id)
    VALUES (1, NEW.title, NEW.event_id)
    ON CONFLICT (id) DO UPDATE
    SET title = EXCLUDED.title,
        event_id = EXCLUDED.event_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_event_count_and_dashboard_trigger
AFTER INSERT ON public.event
FOR EACH ROW EXECUTE FUNCTION public.increment_event_count_and_dashboard();
