* Willkommen
  * Was zu uns sagen
  * Was ist Spark sehr highlevel
    * Spark ist eine der meistgenutzen Engine für das verteilte Verteilte verarbeiten von Daten. Damit stark gewaschen unter Daten Scienentisten und ähnlichem. Wir schauen uns Spark hier allerdings auch aus dem Blickwickel des Anwendungsentwicklers an.
  * Was werden wir hier anschauen
    * Wie funktioniert Spark grundsätzlich
    * Welche Arten gibt es Spark zu nutzen
        * Nutzen von Resillient Data Sets (RDDs)
        * Nutzen von Dataframes
        * Nutzen von Spark SQL
    * Ein Ausblick für
      * Delta Lake: ACID Garantien und Zeitreisen im Data Lake
      * Spark Streaming: wie kann ich als Anwendungsentwickler Spark in meiner Anwendung nutzen um Datastreams zu verarbeiten

* Highlevel Sicht auf Spark
  * Wieso überhaupt Spark?
    * Es gibt nur mehr Datenquellen. Vorher waren es weniger und überwiegend unstrukturierte (wieso ist das hier überhaupt wesentlich)
    * Nun sind es nicht nur mehr Datenquellen sondern die Daten insgesamt auch noch sehr viel mehr (vom Volumen her gesehen).
    * Die Hinzugekommenen Daten können heute mit 80% der gesamten Daten die ein modernes Unternehmen verarbeitet abgeschätzt werden.
    * Das führt zu neuen Anforderungen an die Skalierbarkeit
    * Früher waren überwiegende Use Cases für das Verarbeiten von großen Datenmengen (Bi und allgemeines Reporting)
    * Nun kommt noch MachineLearning/Data Science