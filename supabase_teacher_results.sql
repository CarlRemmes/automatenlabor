create or replace function public.list_worksheet_results(input_pin text)
returns table (
  vorname text,
  letzte_frage integer,
  beantwortet integer,
  uebersprungen integer,
  abgeschlossen_am timestamptz,
  heruntergeladen_am timestamptz,
  zuletzt_gespeichert timestamptz
)
language plpgsql
stable
security definer
set search_path = public
as $$
begin
  if not public.verify_helper_pin(input_pin) then
    raise exception 'invalid pin';
  end if;

  return query
  select
    a.student_name as vorname,
    a.current_index + 1 as letzte_frage,
    jsonb_object_length(coalesce(a.answers, '{}'::jsonb))::integer as beantwortet,
    jsonb_array_length(coalesce(a.skipped, '[]'::jsonb))::integer as uebersprungen,
    a.finished_at as abgeschlossen_am,
    a.downloaded_at as heruntergeladen_am,
    a.updated_at as zuletzt_gespeichert
  from public.worksheet_attempts a
  where coalesce(a.student_name, '') <> ''
  order by a.updated_at desc;
end;
$$;

grant execute on function public.list_worksheet_results(text) to anon, authenticated;
