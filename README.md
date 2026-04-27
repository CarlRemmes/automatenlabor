# Automatenlabor

`Automatenlabor` ist eine browserbasierte Lernumgebung für den Informatikunterricht in Klasse 6.  
Die Schülerinnen und Schüler bearbeiten eine kleine, spielerisch gestaltete Mission rund um Automaten, Zustände, Eingaben, Ausgaben und Zustandsübergänge. Die Anwendung ist so aufgebaut, dass sie sich für eine verdeckte Lernstandserhebung eignet: Für die Lernenden wirkt sie wie eine Labor-Mission, während am Ende lokal eine strukturierte PDF-Auswertung gespeichert wird.

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
- eine einfache, verlässliche Sicherung der Ergebnisse über eine lokale PDF-Datei.

## Aktueller Ablauf für Schülerinnen und Schüler

1. Auf der Startseite werden Vorname, Nachname und Klasse eingetragen.
2. Danach startet die Labor-Mission.
3. Während der Bearbeitung werden verschiedene Aufgabentypen gemischt angezeigt.
4. Die Navigation erfolgt über `Zurück` und `Weiter`.
5. Einzelne Aufgaben können nur über das versteckte Lehrkraft-Menü übersprungen werden.
6. Am Ende klicken die Schülerinnen und Schüler auf `Mission beenden`.
7. Beim Abschluss wird lokal eine passwortgeschützte PDF-Datei erzeugt.
8. Wenn der Browser es unterstützt, können die Schülerinnen und Schüler direkt einen Ordner auswählen und die PDF dort speichern.
9. Falls diese Funktion im Browser nicht verfügbar ist, wird die PDF regulär heruntergeladen und kann anschließend in den Gruppenordner verschoben werden.
10. Nach erfolgreichem Abschluss erscheint eine kurze, allgemeine Rückmeldung.

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

## Auswertung

Die Schülerinnen und Schüler sehen keine genaue Punktzahl und keine direkte Testauswertung.  
Die eigentliche Auswertung steckt in der PDF-Datei.

In der PDF werden unter anderem festgehalten:

- Vorname,
- Nachname,
- Klasse,
- Antworten,
- Begründungen,
- übersprungene Aufgaben,
- Aufgabenreihenfolge,
- Bearbeitungszeitpunkte,
- PDF-Auswertung.

Die PDF-Datei ist passwortgeschützt und für die Ablage im schulischen Gruppenordner gedacht.

## Verstecktes Lehrkraft-Menü

Ein Lehrkraft-Menü ist integriert und über eine versteckte Geste erreichbar:

- fünfmal auf `Automatenlabor` tippen oder klicken,
- PIN eingeben,
- gewünschte Funktion wählen.

Derzeit sind dort unter anderem vorgesehen:

- einzelne Aufgabe überspringen,
- Lösungen anzeigen,
- optional gespeicherte Abgaben abrufen.

## Technik

Das Projekt ist bewusst schlank gehalten:

- eine zentrale `index.html`,
- Vanilla HTML, CSS und JavaScript,
- Supabase für Arbeitsstände und optionale Zusatzspeicherung,
- `jsPDF` für die PDF-Erstellung,
- Passwortschutz direkt in der erzeugten PDF-Datei.

## Wichtige Dateien

- [index.html](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/index.html)
- [supabase_central_results.sql](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/supabase_central_results.sql)
- [SUPABASE_SETUP.md](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/SUPABASE_SETUP.md)
- [SUPABASE_EMAIL_SETUP.md](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/SUPABASE_EMAIL_SETUP.md)
- [supabase/functions/list-reports/index.ts](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/supabase/functions/list-reports/index.ts)

## Supabase-Einrichtung

Für Arbeitsstände und optionale Zusatzfunktionen kann weiterhin Supabase genutzt werden. Dafür muss mindestens der SQL-Block aus

- [supabase_central_results.sql](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/supabase_central_results.sql)

in Supabase ausgeführt werden.

Dieser Block legt unter anderem an:

- die Tabelle `worksheet_attempts`,
- zusätzliche Spalten für Namen, Klasse, Begründungen und Reihenfolge,
- die benötigten Policies,
- die serverseitige PIN-Prüfung.

## Hinweise für den Unterricht

- Die Anwendung ist bewusst nicht als offener Test bezeichnet.
- Die Rückmeldungen am Ende bleiben allgemein und motivierend.
- Die genaue Auswertung erfolgt über das PDF.
- Übersprungene Aufgaben werden in der Auswertung markiert.
- Die Oberfläche soll ruhig, klar und möglichst wenig überladen wirken.

## Impressum

Ein Impressum ist in die Anwendung integriert und über einen Link innerhalb der Seite erreichbar.
