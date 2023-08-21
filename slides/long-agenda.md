* Willkommen
  * Was zu uns sagen
  * Was ist Spark sehr highlevel
    * Spark ist eine der meistgenutzen Engine für das verteilte Verteilte verarbeiten von Daten. Damit stark gewachsen unter Daten Scientisten und Ahnlichen. Wir schauen uns Spark hier allerdings auch aus dem Blickwickel des Anwendungsentwicklers an.
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
    https://burcuku.github.io/cse2520-bigdata/big-data.html
    * Nun sind es nicht nur mehr Datenquellen sondern die Daten insgesamt auch noch sehr viel mehr (vom Volumen her gesehen).
    * Die Hinzugekommenen Daten können heute mit 80% der gesamten Daten die ein modernes Unternehmen verarbeitet abgeschätzt werden. Das sind unstrukturierte und semistrukturierte Daten.
    * Das führt zu neuen Anforderungen an die Skalierbarkeit
    * Früher waren überwiegende Use Cases für das Verarbeiten von großen Datenmengen (Bi und allgemeines Reporting)
    * Nun kommt noch MachineLearning/Data Science
    * Das Problem von Hadoop habe ich nur bedingt bis gar nicht verstanden. (das mit der disc heavy architecture)
    * Vorteil von Sparc gegenüber Hadoop und anderen:
      * Geschwindigkeit
      * Einfacher zu benutzen zu verstehen und in der Sprache der Wahl zu nutzen 
      * Verschiedene Nutzungsmöglichenkeiten werden direkt addressiert:
        * Batch
        * Streaming
        * Machine Learning
        * Advanced Analytics
    * Sparc architecture:
      * extremly powerfull in-memory engine analytics engine (unterschied von In memory zu disc zu network...) build on cluster cloud computing technology
      * Terms
        * Job
          is created when you need to execute code and want a result
        * Partitions
          is a chunk of data
          driver decides how many partitions will be created
          will determine the number of tasks
        * Driver
          
        * Tasks
          each task will process only one partition
        * Core
    * Wie kann ich Spark nutzen
      * Command Line/Spark Shell
      * Notebooks wie Jupyter und Zeppelin
      * Local oder in der Cloud
      * In Ide's wie PyCharm,...
    * Was zu Clustermanagern und deren Optionen sagen
    * Working with RDDs
    