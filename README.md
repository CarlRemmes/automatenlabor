# Automatenlabor

Eine browserbasierte Lernumgebung fuer Klasse 6 zum Thema Automaten.

Die Schuelerinnen und Schueler starten mit Vorname, Nachname und Klasse, bearbeiten gemischte Aufgaben zu sichtbaren und weniger offensichtlichen Automaten und beenden die Mission am Ende ohne sichtbare Testwertung. Die eigentliche Auswertung wird im Hintergrund gespeichert.

## Aktueller Ablauf

1. Startseite mit Eingabe von:
   - Vorname
   - Nachname
   - Klasse
2. Bearbeitung verschiedener Aufgabentypen:
   - offene Antworten
   - Auswahlfragen
   - Ja/Nein-Fragen
   - Zuordnungsaufgabe mit Verbindungslinien
   - Zeitaufgabe
3. `Mission beenden`
4. Freundliche Abschlussseite fuer die SuS
5. Hintergrundspeicherung der Ergebnisse in Supabase
6. PDF-Auswertung wird automatisch zentral im Storage abgelegt
7. Optional: automatischer Mailversand der PDF an die Lehrkraft

## Inhaltlich

Die Aufgaben beziehen sich auf:

- einen Snackautomaten als zentrales Referenzmodell
- einen Fahrkartenautomaten
- eine Poststation
- einen Scheibenreiniger

Ziel ist nicht Benotung, sondern eine verdeckte Lernstandserhebung:

- bekannte Inhalte wiedergeben
- neue Beispiele als Automaten erkennen
- Eingabe, Zustand, Folgezustand und Ausgabe anwenden
- Beobachtungen begruenden

## Technik

- eine einzelne `index.html`
- Vanilla HTML, CSS und JavaScript
- Speicherung des Arbeitsstands ueber Supabase
- anonyme Auth-Session im Hintergrund
- PDF-Erstellung ueber `jsPDF`
- verstecktes Hilfemenue mit PIN-Pruefung ueber Supabase RPC

## Wichtige Dateien

- [index.html](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/index.html)
- [supabase_central_results.sql](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/supabase_central_results.sql)
- [SUPABASE_SETUP.md](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/SUPABASE_SETUP.md)
- [SUPABASE_EMAIL_SETUP.md](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/SUPABASE_EMAIL_SETUP.md)

## Supabase

Fuer die aktuelle zentrale Speicherung muss in Supabase mindestens der SQL-Block aus

- [supabase_central_results.sql](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/supabase_central_results.sql)

ausgefuehrt werden.

Er legt an:

- `worksheet_attempts`
- Zusatzfelder fuer Namen, Begruendungen, Aufgabenreihenfolge und PDF-Pfad
- den Storage-Bucket `automatenlabor-reports`
- Policies fuer anonyme Schueler-Sessions
- die serverseitige PIN-Pruefung

## Hinweise fuer den Unterricht

- Die SuS sehen keine genaue Punktzahl.
- Die PDF-Auswertung ist fuer Lehrkraefte gedacht.
- Uebersprungene Aufgaben werden in der Auswertung markiert.
- Der Arbeitsstand wird waehrend der Bearbeitung laufend gespeichert.
- Fuer automatischen Mailversand wird eine Supabase Edge Function mit Mailanbieter benoetigt.
