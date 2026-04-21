# Supabase Setup fuer Automatenlabor

## 1. SQL ausfuehren

Fuehre die Datei [supabase_schema.sql](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/supabase_schema.sql) im SQL Editor von Supabase aus.

## 2. Anonyme Anmeldung aktivieren

In Supabase:

- `Authentication`
- `Providers`
- `Anonymous Sign-Ins`
- aktivieren

Die Schuelerinnen und Schueler bekommen damit automatisch eine anonyme Auth-Session.

## 3. Lehrkraftkonto anlegen

Lege dein Lehrkraftkonto in Supabase Auth an, zum Beispiel ueber:

- `Authentication`
- `Users`
- `Add user`

Danach trage die Rolle in `profiles` ein:

```sql
insert into public.profiles (id, role, display_name)
values ('DEINE_AUTH_USER_ID', 'teacher', 'Carl');
```

Die `DEINE_AUTH_USER_ID` findest du in Supabase unter `Authentication -> Users`.

## 4. Was das Setup jetzt absichert

- Schueler koennen nur ihre eigene Session lesen und schreiben.
- Schueler koennen nur ihre eigene Abgabe speichern.
- Lehrkraefte koennen alle Sessions, Abgaben und Missionsdaten sehen.
- Nur Lehrkraefte duerfen die Mission steuern und Nachrichten an SuS senden.
- Screenshots werden in einem privaten Storage-Bucket gespeichert.
- Lehrkraefte duerfen alle Screenshots lesen.
- Schueler duerfen nur in ihren eigenen Ordner hochladen.

## 5. Login in der App

- Schueler: keine Zugangsdaten noetig, Anmeldung passiert anonym im Hintergrund
- Lehrkraft: versteckten Admin oeffnen und mit Supabase-E-Mail + Passwort anmelden

## 6. Hinweis

Die `SUPABASE_URL` und der `SUPABASE_ANON_KEY` bleiben im Frontend sichtbar. Das ist bei Supabase normal. Die eigentliche Sicherheit kommt hier ueber Auth, RLS und Storage-Policies.
