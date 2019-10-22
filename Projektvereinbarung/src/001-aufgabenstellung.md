# Aufgabenstellung

Blockchains verfügen über verschiedene Mechanismen, um sich gegen Attacken abzusichern. Eine davon ist eine Gebühr auf jeder Transaktion, der sogenannte Gas Price[@gasprice]. Dadurch können Denial of Service (DoS)[@dos] Attacken, bei denen das Netzwerk mit unzähligen Transaktionen geflutet wird, effizient bekämpft werden. Der Angreifer kann die Attacke nicht aufrecht erhalten, da ihm die finanziellen Mittel zwangsläufig ausgehen. 

Obwohl dieser Schutzmechanismus auf einer öffentlichen Blockchain sehr effizient und elegant ist, eignet er sich nicht für eine Lernumgebung. Hier sollen Anwender die Möglichkeit haben, Transaktionen ohne anfallende Gebühren ausführen zu können. Dadurch wird jedoch die Blockchain anfällig für DoS Attacken. 

Die Projektaufgabe besteht darin, einer definiereten Gruppe von Benutzern gratis Transaktionen zur Verfügung zu stellen. Um die Blockchain zu schützen, können bei Anzeichen von einer DOS Attacke, Schutzmechanismen eingeleitet werden.  

Das Ziel der Arbeit ist die Realisierung einer Blockchain welche für eine definierete Gruppe von Benutzern: 

- Kostenlose Transaktionen ermöglicht 
- Schutz vor DOS Attacken gewährleistet

Um diese Ziele zu erreichen sind folgende Fragestellungen von Bedeutung:

- Wie identifizieren wir verantwortliche Benutzer bei einer DOS Attacke?
- Wie können DOS Attacken erkannt werden?
- Welche Schutzmechanismen stehen uns zur Verfügung?

 
