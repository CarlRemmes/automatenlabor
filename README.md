# Automatenlabor

`Automatenlabor` ist eine browserbasierte Lernumgebung für den Informatikunterricht in Klasse 6.  
Die Schülerinnen und Schüler bearbeiten eine kleine, spielerisch gestaltete Mission rund um Automaten, Zustände, Eingaben, Ausgaben und Zustandsübergänge. Die Anwendung ist so aufgebaut, dass sie sich für eine verdeckte Lernstandserhebung eignet: Für die Lernenden wirkt sie wie eine Labor-Mission, während im Hintergrund strukturierte Auswertungen für die Lehrkraft entstehen.

## Ziel des Projekts

Das Projekt soll Schülerinnen und Schülern helfen,

- bekannte Inhalte zum Thema Automaten wiederzuerkennen,
- neue Beispiele als Automaten oder Nicht-Automaten einzuordnen,
- Zustände, Eingaben, Ausgaben und Folgezustände an Bildern zu erklären,
- Beobachtungen zu begründen,
- Fachbegriffe in einfachen, altersgerechten Aufgaben anzuwenden.

Wichtig ist dabei:

- keine sichtbare Benotung für die Schülerinnen und Schüler,
- ein motivierender, reduzierter Ablauf,
- eine möglichst ruhige und ansprechende Oberfläche,
- eine zentrale Sicherung der Ergebnisse für die Lehrkraft.

## Aktueller Ablauf für Schülerinnen und Schüler

1. Auf der Startseite werden Vorname, Nachname und Klasse eingetragen.
2. Danach startet die Labor-Mission.
3. Während der Bearbeitung werden verschiedene Aufgabentypen gemischt angezeigt.
4. Die Navigation erfolgt über `Zurück` und `Weiter`.
5. Einzelne Aufgaben können nur über das versteckte Lehrkraft-Menü übersprungen werden.
6. Am Ende klicken die Schülerinnen und Schüler auf `Mission beenden`.
7. Die Ergebnisse werden im Hintergrund in Supabase gespeichert.
8. Nach erfolgreichem Abschluss erscheint eine kurze, allgemeine Rückmeldung.

## Aufgabentypen

Die Anwendung verwendet bewusst unterschiedliche Formate, damit die Bearbeitung abwechslungsreich bleibt:

- offene Textantworten,
- Auswahlfragen,
- Ja/Nein-Fragen,
- bildgestützte Beobachtungsaufgaben,
- Zuordnungsaufgaben mit Verbindungslinien,
- zeitgesteuerte Aufgaben,
- Aufgaben zu Nicht-Automaten,
- Aufgaben zu Zustandsgraphen.

## Inhaltlicher Fokus

Die Aufgaben orientieren sich an mehreren Bildquellen und Beispielen, unter anderem:

- Snackautomat,
- Fahrkartenautomat,
- Poststation,
- Scheibenreiniger,
- Zustandsgraph,
- Gegenbeispiele wie Fahrrad oder Stein.

Damit wird nicht nur ein einzelner Automat behandelt. Stattdessen lernen die Schülerinnen und Schüler, typische Merkmale von Automaten auf verschiedene Situationen zu übertragen.

## Verdeckte Auswertung für Lehrkräfte

Die Schülerinnen und Schüler sehen keine genaue Punktzahl und keine direkte Testauswertung.  
Die eigentliche Auswertung ist für Lehrkräfte gedacht.

Im Hintergrund werden unter anderem gespeichert:

- Vorname,
- Nachname,
- Klasse,
- Antworten,
- Begründungen,
- übersprungene Aufgaben,
- Aufgabenreihenfolge,
- Bearbeitungszeitpunkte,
- PDF-Auswertung.

Die PDFs werden zentral in Supabase Storage abgelegt und können über die versteckte Lehrkraft-Ansicht abgerufen werden.

## Verstecktes Lehrkraft-Menü

Ein Lehrkraft-Menü ist integriert und über eine versteckte Geste erreichbar:

- fünfmal auf `Automatenlabor` tippen oder klicken,
- PIN eingeben,
- gewünschte Funktion wählen.

Derzeit sind dort unter anderem vorgesehen:

- einzelne Aufgabe überspringen,
- Lösungen anzeigen,
- gespeicherte Abgaben abrufen.

## Technik

Das Projekt ist bewusst schlank gehalten:

- eine zentrale `index.html`,
- Vanilla HTML, CSS und JavaScript,
- Supabase für Authentifizierung, Tabellen und Storage,
- `jsPDF` für die PDF-Erstellung,
- Edge Functions für Lehrkraft-Abrufe aus der Cloud.

## Wichtige Dateien

- [index.html](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/index.html)
- [supabase_central_results.sql](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/supabase_central_results.sql)
- [SUPABASE_SETUP.md](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/SUPABASE_SETUP.md)
- [SUPABASE_EMAIL_SETUP.md](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/SUPABASE_EMAIL_SETUP.md)
- [supabase/functions/list-reports/index.ts](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/supabase/functions/list-reports/index.ts)

## Supabase-Einrichtung

Für die zentrale Speicherung muss mindestens der SQL-Block aus

- [supabase_central_results.sql](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/supabase_central_results.sql)

in Supabase ausgeführt werden.

Dieser Block legt unter anderem an:

- die Tabelle `worksheet_attempts`,
- zusätzliche Spalten für Namen, Klasse, Begründungen, Reihenfolge und PDF-Pfade,
- den Storage-Bucket `automatenlabor-reports`,
- die benötigten Policies,
- die serverseitige PIN-Prüfung.

## Typische Fehlerquelle

Wenn beim Klick auf `Mission beenden` eine Meldung wie

- `new row violates row-level security policy`

erscheint, liegt das fast immer an veralteten Storage-Policies in Supabase.

Dann sollte [supabase_central_results.sql](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/supabase_central_results.sql) erneut vollständig ausgeführt werden.

## Hinweise für den Unterricht

- Die Anwendung ist bewusst nicht als offener Test bezeichnet.
- Die Rückmeldungen am Ende bleiben allgemein und motivierend.
- Die genaue Auswertung erfolgt über das PDF und die Lehrkraftansicht.
- Übersprungene Aufgaben werden in der Auswertung markiert.
- Die Oberfläche soll ruhig, klar und möglichst wenig überladen wirken.

## Impressum

Ein Impressum ist in die Anwendung integriert und über einen Link innerhalb der Seite erreichbar.
