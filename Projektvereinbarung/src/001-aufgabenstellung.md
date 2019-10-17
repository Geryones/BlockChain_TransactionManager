# Aufgabenstellung

Blockchains verfügen über verschiedene Mechanismen, um sich gegen Attacken abzusichern. Eine davon ist eine Gebühr auf jeder Transaktion, der sogenannte Gas Price[@gasprice]. Dadurch können Denial of Service (DoS)[@dos] Attacken, bei denen das Netzwerk mit unzähligen Transaktionen geflutet wird, effizient bekämpft werden. Der Angreifer kann die Attacke nicht aufrechterhalten, da ihm die finanziellen Mittel zwangsläufig ausgehen. 

Obwohl dieser Schutzmechanismus auf einer öffentlichen Blockchain sehr effizient und elegant ist, eignet er sich nicht für eine Lernumgebung. Hier sollen Anwender die Möglichkeit haben, Transaktionen ohne anfallende Gebühren ausführen zu können. Dadurch wird jedoch die Blockchain anfällig für DoS Attacken. 

Die Projektaufgabe besteht darin, den Benutzern gratis Transaktionen zur Verfügung zu stellen. Um die Blockchain zu schützen, können bei Anzeichen von einer DOS Attacke, Schutzmechanismen eingeleitet werden. Damit im Falle einer Attacke nicht alle Benutzer der Blockchain betroffen sind, wird mit Benutzergruppen gearbeitet. Sobald der oder die Angreifer identifiziert ist, wird er einer Gruppe mit weniger Privilegien zugeteilt. 

Das Ziel der Arbeit ist die Realisierung einer Blockchain welche: 

- Kostenlose Transaktionen ermöglicht 
- Schutz vor DOS Attacken gewährleistet

Um diese Ziele zu erreichen sind folgende Fragestellungen von Bedeutung:

- Wie können DOS Attacken erkennt werden
  - Anomaly Detection
  - Anzahl Transaktionen pro Benutzer auswerten
- Wie identifizieren wir verantwortliche Benutzer bei einer DOS Attacke
- Welche Schutzmechanismen stehen uns zur Verfügung
  - Transaktionskosten für verdächtige Benutzer
  - Beschränkung der Transaktionen pro Zeitintervall
  - Beschränkung von Transaktionen pro Benutzer und Zeitintervall


 
