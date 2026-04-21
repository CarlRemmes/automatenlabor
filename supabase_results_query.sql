select
  student_name as vorname,
  current_index + 1 as letzte_frage,
  jsonb_object_length(coalesce(answers, '{}'::jsonb)) as beantwortet,
  jsonb_array_length(coalesce(skipped, '[]'::jsonb)) as uebersprungen,
  finished_at as abgeschlossen_am,
  downloaded_at as heruntergeladen_am,
  updated_at as zuletzt_gespeichert
from public.worksheet_attempts
where coalesce(student_name, '') <> ''
order by updated_at desc;
