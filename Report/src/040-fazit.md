
# Fazit 

Für die FHNW ist eine Ethereumblockchain aufgesetzt
worden. Als Client wird Parity verwendet. Zurzeit der einzige Client, welcher
einer definierten Benutzergruppe kostenneutrale Transaktionen erlaubt. Diese
Benutzergruppe ist eine Gefahr für die Blockchain. Gratis Transaktionen können
für eine Denial of Service Attacke verwendet werden.\
Um diese Gefahr einzudämmen ist ein Blockchain Transaktionsmanager konzipiert und entwickelt
worden. Dieser ermöglicht eine Überwachung von getätigten gratis Transaktionen.
Wenn nötig können diese auch eingeschränkt werden.\
Für jeden Account der privilegierten Benutzergruppe, können individuelle
Parameter für die Nutzung der gratis Transaktionen gesetzt werden. So kann pro
Account festgelegt werden, wie viele gratis Transaktionen und gratis Gas pro
Reset-Intervall verfügbar sind. Sobald eine dieser Limiten überschritten wird,
wird das Privileg auf gratis Transaktionen für diesen Account aufgehoben. Wie
lange eine solche Suspendierung dauert, kann ebenfalls pro Account festgelegt
werden. Um die Benutzerfreundlichkeit auch bei vielen Accounts zu gewährleisten,
können für diese Parameter auch Standardwerte gesetzt werden.\
Am Ende eines Reset-Intervalls, werden die Zähler von allen Accounts
zurückgesetzt. Das Reset-Intervall kann konfiguriert werden. Es ist der einzige
Parameter, der nicht für jeden Account einzeln gesetzt werden kann, sondern für
alle gleich ist.\
Für das Reset-Intervall und die Suspendierung von einem Account, wird eine
Priority-Queue in Kombination mit einem Command-Pattern verwendet. Jedes Command
verfügt über einen Zeitstempel für den Ausführungszeitpunkt. Das Command für das
Reset-Intervall, fügt sich rekursiv in die Priority-Queue ein.\
Die für gratis Transaktionen berechtigten Accounts und Einstellungen des
Transaktionsmanagers werden über zwei JSON-Dateien eingelesen. Diese Dateien
werden weiter für die Sicherstellung der Datenpersistenz verwendet. Jedes Mal,
wenn ein Command mit einem Zeitstempel erstellt wird, wird diese Information in
einer Datei gespeichert.\
Mit der Verwendung von Zeitstempel kann nach einem Unterbruch der letzte Zustand
wiederhergestellt werden. Sollte die Suspendierung von einem Account während der
Ausfallszeit abgelaufen sein, wird das beim Neustart ermittelt.\
Mit dem entwickelten Transaktionsmanager sind gratis Transaktionen
möglich, ohne dass die Sicherheit der Blockchain kompromittiert wird. Das
ermöglicht der FHNW, ihren Studierenden und Mitarbeitenden, eine sichere und
kostenneutrale Lernumgebung anzubieten. Damit können alle Ziele der
Projektvereinbarung erreicht werden.

Die Leistungstests haben gezeigt, dass der Transaktionsmanager nicht sofort
reagieren kann. Er ist an die publizierten Blöcke gebunden. Die Wahl der Limiten
sollte daher immer in Abhängigkeit der Blockgrösse und deren Frequenz gewählt
werden.\
Mit der Verwendung von einem Gas Preis grösser null beim Transaktionsmanager ist
sichergestellt, dass diese Transaktionen prioritär behandelt werden. Die Tests
haben gezeigt, dass die Priorisierung des Nodes auch während einer DoS Attacke
funktionieren.\

Zu Beginn ist eine Implementation des Transaktionsmanagers auf der Blockchain
mittels Smart Contracts angestrebt worden. Dieser Ansatz bedingt jedoch eine
Anpassung von Parity. Aktuell hält Parity eine Liste von Accounts, die für
gratis Transaktionen berechtigt sind. Um den Transaktionsmanager völlig
dezentral zu realisieren, müsste die Whitelist von Parity so angepasst werden,
dass nicht nur Accounts, sondern Verbindungen geprüft werden. So kann
sichergestellt werden, dass gratis Transaktionen über den Transaktionsmanager
abgewickelt werden müssen.\
Der Umfang und Komplexität dieser Anpassungen sind im gegebenen Zeitrahmen als
nicht realisierbar eingeschätzt worden. Daher haben wir beschlossen, den
Transaktionsmanager als Java-Applikation zu realisieren. Diese Version des
Transaktionsmanagers ist eine zentrale Autorität. Das entspricht nicht dem
dezentralitäts Prinzip einer Blockchain. Der Transaktionsmanager kann nur gratis
Transaktionen einschränken. Alle anderen Aspekte der Blockchain bleiben
dezentral. Die Verletzung der Prinzipien ist daher geringfügig.

Das Aufsetzen einer Blockchain mit Parity ist unterschätzt worden. Bei der
Konfiguration der Blockchain mussten wir feststellen, dass die Dokumentation
sehr oft unvollständig oder veraltet ist. Dadurch hat sich die Bereitstellung
der Blockchain stark verzögert. Aufgrund der Verzögerung musste der Fokus,
stärker als geplant, auf die Kernfunktionalität gerichtet werden. Dadurch fehlte
Zeit bei der Implementaion von Zusatzfunktionen.

Der Transaktionsmanager hat ein grosses Potential für Erweiterungen. Wenn die
Blockchain frisch aufgesetzt wird, könnte das Deployment und die Registrierung
des Certifiers automatisiert werden. Analog zur Name Registry kann der Certifier
direkt in der Blockchainspezifikation deployed werden. Zusätzlich ist es möglich,
den Constructor vom Certifier so anzupassen, dass er sich automatisch bei der
Name Registry registriert. Dafür muss der ```SimpleCertifier``` und die
Blockchainspezifikation angepasst werden.\
Mit den Erkenntnissen aus den Leistungstests könnten die Parameter überarbeitet
werden. Unter Berücksichtigung der Blockchainspezifikation könnten optimale
Vorschläge für die Limiten berechnet werden. Das würde die Effizienz und die
Benutzerfreundlichkeit des Transaktionsmanagers erhöhen.\
Um die Benutzerfreundlichkeit zu erhöhen, könnte eine leserliche
Zusammenstellung aller Ereignisse erstellt werden. Diese könnte manuell
abgerufen oder automatisch via Email an die Betreiber des Transaktionsmanagers
gesendet werden. Für eine Zustellung via Mail muss ein Mailserver zur Verfügung
stehen.\
Mit einer Validierung der Input-Dateien und einer entsprechenden Meldung, könnte
mehr Benutzerfreundlichkeit erreicht werden.


