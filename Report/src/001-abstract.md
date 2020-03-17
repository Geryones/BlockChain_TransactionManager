\section*{Abstract}

Die Fachhochschule Nordwestschweiz (FHNW) möchte den Studierenden und Mitarbeitenden
eine kostenneutrale Blockchain anbieten. Diese soll für innovative Projekte,
Experimente und Schulungszwecke genutzt werden.

Eine Blockchain schützt sich vor Denial of Service (DoS) Attacken mit
Transaktionsgebühren. Dieser Schutzmechanismus ist für eine Lernumgebung nicht
praktikabel. Für die Studierenden und Mitarbeitenden sollen keine Kosten
anfallen. Das Ziel dieser Arbeit ist, einer definierten Benutzergruppe gratis
Transaktionen zu gewähren, ohne dabei die Sicherheit der Blockchain zu
komprimittieren.

Mit einer Literaturrechere ist das nötige Wissen zu Blockchains, Transaktionen
und DoS Attacken erarbeitet worden. Für die Ethereumblockchain ist mit Parity ein
Client identifiziert worden, der bereits über die Möglichkeit verfügt,  einer
Benutzergruppe gratis Transaktionen zu erlauben. Auf dieser Basis, ist ein
Kontrollsystem konzipiert worden. Mit diesem Transaktionsmanager kann das
Verhalten der Benutzergruppe überwacht werden. Stellt ein Benutzer eine
Bedrohung dar, wird ihm das Privileg für gratis Transaktionen temporär entzogen.

Der Transaktionsmanager ist als Java-Applikation implementiert worden. Mit der
Bibliothek web3j wird der jeweils neuste Block auf Transaktionen untersucht.
Gefundene gratis Transaktionen werden analysiert.\newline 
Der Transaktionsmanager verwaltet die
Benutzergruppe. Pro Benutzer wird die Anzahl getätigter gratis Transaktionen und
die damit verursachten Rechenkosten der Blockchain überwacht. Die FHNW kann für jeden Benutzer
individuelle Limiten definieren. Die Dauer der Suspendierung kann ebenfalls
individuell festgelegt werden. Um die Datenpersistenz auch bei einem Stopp der
Applikation zu gewährleisten, wird der Zustand regelmässig als Datei
gespeichert. Bei einem Neustart wird dieser gelesen und wiederhergestellt.  
Für die individuelle Suspendierung wird eine Priority-Queue in Kombination mit
einem Command Pattern verwendet. So kann auch eine grosse Anzahl Benutzer, mit
hoher Ressourceneffizienz, bearbeitet werden.
Für die Entwicklung und Testung ist eine private single Node Blockchain
verwendet worden. 

\newpage
