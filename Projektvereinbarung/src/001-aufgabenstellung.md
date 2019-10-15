# Aufgabenstellung

Blockchains verfügen über verschiedene Mechanismen, um sich gegen Attacken abzusichern. Eine davon ist eine Gebühr auf jeder Transaktion, der sogenannte Gas Price[@gasprice]. Dadurch können Denial of Service (DoS)[@dos] Attacken, bei denen das Netzwerk mit unzähligen Transaktionen geflutet wird, effizient bekämpft werden. Der Angreifer kann die Attacke nicht aufrechterhalten, da ihm die finanziellen Mittel zwangsläufig ausgehen. 

Obwohl dieser Schutzmechanismus auf einer öffentlichen Blockchain sehr effizient und elegant ist, eignet er sich nicht für eine Lernumgebung. Hier sollen Anwender die Möglichkeit haben, Transaktionen ohne anfallende Gebühren ausführen zu können. Dadurch wird jedoch die Blockchain anfällig für DoS Attacken. 

Die Projektaufgabe besteht darin, eine Lösung zu finden, bei der die Sicherheit der Blockchain auch ohne eine Transaktionsgebühr gewährleistet werden kann. 

Das Ziel der Arbeit ist es zuerst eine konzeptionelle Erarbeitung eines Testnetzwerkes welches:

- nicht permanent ist (Reboot möglich)
- kostenlose Transaktionen ermöglicht 
- Sicherheit gewährleistet

In einem zweiten Schritt die Umsetzung/Realisierung dieses Netzwerkes. 

Um diese Ziele zu erriechen sind folgende Fragestellungen von Bedeutung:

- wie kann die Gebühr für Transaktionen auf null gesetzt und die Sicherheit der Blockchain trotzdem gewährleistet werden.
- Gibt es eine Wallet die unsere gewünschten Anfroderungen unterstützt und nur erweitert werden muss, oder müssen wir selber eine SmartWallet programmieren.
- Wie kann man algorithmisch Attacken vermeiden
-- Anomaly detection
-- Beschränkung von Transaktionen pro Benutzer und Zeitintervall
-- etc


 
