# Automatenlabor

`Automatenlabor` ist eine browserbasierte Lernumgebung für den Informatikunterricht in den Klassen `05A` bis `10C`.  
Die Schülerinnen und Schüler bearbeiten eine kleine Mission rund um Automaten, Zustände, Eingaben, Ausgaben und Zustandsübergänge. Für die Lernenden wirkt die Anwendung wie eine Labor-Aufgabe. Gleichzeitig entsteht am Ende eine PDF-Auswertung, die in iServ hochgeladen werden kann.

## Ziel des Projekts

Das Projekt soll Schülerinnen und Schülern helfen,

- bekannte Inhalte zum Thema Automaten wiederzuerkennen,
- neue Beispiele als Automaten oder Nicht-Automaten einzuordnen,
- Zustände, Eingaben, Ausgaben und Folgezustände an Bildern zu erklären,
- Beobachtungen zu begründen,
- Fachbegriffe in einfachen, altersgerechten Aufgaben anzuwenden.

Wichtig ist dabei:

- keine offene Testsituation für die Schülerinnen und Schüler,
- ein motivierender, reduzierter Ablauf,
- eine ruhige, möglichst wenig überladene Oberfläche,
- eine verlässliche lokale Sicherung der Ergebnisse als PDF,
- eine Möglichkeit, einen Zwischenstand als Excel-Datei zu speichern und später wieder zu laden.

## Ablauf für Schülerinnen und Schüler

1. Auf der Startseite werden Vorname, Nachname und Klasse eingetragen.
2. Danach startet die Mission.
3. Während der Bearbeitung erscheinen verschiedene Aufgabentypen in gemischter Reihenfolge.
4. Die Navigation erfolgt über `Zurück` und `Weiter`.
5. Offene Antworten sollen bewusst kurz und einfach formuliert werden.
6. Auf Wunsch kann während der Bearbeitung ein Zwischenstand als Excel-Datei gespeichert werden.
7. Diese Excel-Datei kann später wieder geladen werden, damit die Mission genau an derselben Stelle fortgesetzt wird.
8. Am Ende klicken die Schülerinnen und Schüler auf `Mission beenden`.
9. Die Anwendung erzeugt lokal eine PDF-Datei.
10. Wenn der Browser es unterstützt, kann direkt ein Ordner zum Speichern ausgewählt werden.
11. Danach laden die Schülerinnen und Schüler die PDF in iServ bei der vorgesehenen Aufgabe hoch.
12. Anschließend erscheint eine kurze Rückmeldung mit einer kleinen Kurzauswertung der automatisch prüfbaren Aufgaben und der Bearbeitungszeit.

## Zwischenstand als Excel-Datei

Während der Bearbeitung kann ein Zwischenstand gespeichert werden.

Der Ablauf:

1. Während der Mission auf `Zwischenstand speichern` klicken.
2. Die Anwendung erzeugt eine Excel-Datei (`.xlsx`).
3. Diese Datei enthält:
   - eine Übersicht mit Name, Klasse und Bearbeitungszeit,
   - die bisherigen Antworten,
   - Begründungen,
   - einen technischen Datenteil zum Wiederherstellen des Zustands.
4. Später kann auf der Startseite `Zwischenstand laden` gewählt werden.
5. Danach setzt die Anwendung die Mission an genau der gespeicherten Stelle fort.

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

Die Schülerinnen und Schüler sehen keine harte Testauswertung.  
Am Ende erscheint nur eine kurze, motivierende Rückmeldung.

Die eigentliche Auswertung steckt in der PDF-Datei. Dort werden unter anderem festgehalten:

- Vorname,
- Nachname,
- Klasse,
- Bearbeitungsdatum,
- Bearbeitungszeit,
- Antworten,
- Begründungen,
- richtige Lösungen bei automatisch prüfbaren Aufgaben,
- übersprungene Aufgaben,
- Aufgabenreihenfolge,
- ein maschinenlesbarer Datenteil.

## Verstecktes Lehrkraft-Menü

Ein Lehrkraft-Menü ist integriert und über eine versteckte Geste erreichbar:

- fünfmal auf `Automatenlabor` tippen oder klicken,
- PIN eingeben,
- gewünschte Funktion wählen.

Derzeit sind dort unter anderem vorgesehen:

- einzelne Aufgabe überspringen,
- Lösungen anzeigen,
- Abgaben abrufen, sofern Supabase genutzt wird.

## Technik

Das Projekt ist bewusst schlank gehalten:

- eine zentrale `index.html`,
- Vanilla HTML, CSS und JavaScript,
- `jsPDF` für die PDF-Erstellung,
- `SheetJS` für Excel-Import und Excel-Export,
- optional Supabase für zusätzliche Arbeitsstände und Lehrkraft-Funktionen.

## Wichtige Dateien

- [index.html](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/index.html)
- [supabase_central_results.sql](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/supabase_central_results.sql)
- [SUPABASE_SETUP.md](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/SUPABASE_SETUP.md)
- [SUPABASE_EMAIL_SETUP.md](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/SUPABASE_EMAIL_SETUP.md)
- [supabase/functions/list-reports/index.ts](/Users/carlremmes/Documents/Codex/2026-04-21-github-plugin-github-openai-curated-inspect/automatenlabor/supabase/functions/list-reports/index.ts)

## Supabase

Der aktuelle Hauptablauf funktioniert lokal über PDF und Excel-Datei.  
Supabase kann weiterhin für optionale Zusatzfunktionen genutzt werden, zum Beispiel für Lehrkraft-Ansichten oder zusätzliche Arbeitsstandsspeicherung.

## Hinweise für den Unterricht

- Die Anwendung ist bewusst nicht als offener Test bezeichnet.
- Die Rückmeldungen am Ende bleiben allgemein und motivierend.
- Die genaue Auswertung erfolgt über die PDF.
- Offene Antworten sollen kurz und einfach gehalten werden.
- Übersprungene Aufgaben werden in der Auswertung markiert.
- Die Oberfläche soll ruhig, klar und möglichst wenig überladen wirken.

## Impressum

Ein Impressum ist in die Anwendung integriert und über einen unauffälligen Link innerhalb der Seite erreichbar.
