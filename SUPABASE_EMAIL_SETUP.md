## Automatischer Mailversand der Auswertungen

Nach `Mission beenden` wird das PDF bereits in Supabase Storage hochgeladen.  
Mit der Edge Function `send-report-email` kann dieses PDF danach automatisch per Mail an dich geschickt werden.

### 1. SQL aktualisieren

Fuehre [supabase_central_results.sql](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/supabase_central_results.sql) erneut im Supabase SQL Editor aus.

Neu dabei:
- `email_sent_at`
- `email_error`

### 2. Edge Function deployen

Im Projektordner:

```bash
supabase functions deploy send-report-email
```

### 3. Secrets setzen

Du brauchst einen Maildienst. Empfohlen ist `Resend`.

Setze diese Secrets in Supabase:

```bash
supabase secrets set RESEND_API_KEY=dein_resend_api_key
supabase secrets set REPORT_TO_EMAIL=deine_lehrkraft_mail@example.com
supabase secrets set REPORT_FROM_EMAIL=noreply@deinedomain.de
```

### 4. Absender verifizieren

Bei deinem Mailanbieter muss die Absenderadresse verifiziert sein.

Beispiel:
- `noreply@automatenlabor.carlremmes.com`

### 5. Ergebnis

Danach passiert bei `Mission beenden` automatisch:
- PDF erzeugen
- PDF in Supabase hochladen
- Mail an deine Adresse schicken

Wenn etwas schiefgeht, steht der Fehler in:
- `worksheet_attempts.email_error`
