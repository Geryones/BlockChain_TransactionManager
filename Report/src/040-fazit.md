
# Fazit 

Für die FHNW ist eine Ethereumblockchain aufgesetzt
worden. Als Client wird Parity verwendet. Zur Zeit der einzige Client, welche
einer definierten Benutzergruppe kostenneutrale Transaktionen erlaubt. Diese
Benutzergruppe ist eine Gefahr für die Blockchain. Gratis Transaktionen können
für eine Denial of Service Attacke verwendet werden.\
Um diese Gefahr einzudämmen ist ein Blockchain Transaktionsmanager entwickelt
worden. Dieser ermöglicht eine Überwachung von getätigten gratis Transaktionen.
Wenn nötig können diese auch eingeschränkt werden.\
Für jeden Account der priviligierten Benutzergruppe, können individuelle
Parameter für die Nutzung der gratis Transaktionen gesetzt werden. So kann pro
Account festgelegt werden, wie viele gratis Transaktionen oder gratis Gas pro
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
Priority-Queue und das Command-Pattern verwendet. Jedes Command verfügt über einen
Zeitstempel für den Ausführungszeitpunkt.\
Die für gratis Transaktionen berechtigten Accounts und Einstellungen des
Transaktionsmanagers werden über zwei JSON-Dateien eingelesen. Diese Dateien
werden weiter für die Sicherstellung der Datenpersistenz verwendet. Jedes Mal
wenn ein Command mit einem Zeitstempel erstellt wird, wird diese Information in
einer Datei gespeichert.\
Mit der Verwendung von Zeitstempel kann nach einem Unterbruch, der letzte
Zustand wiederhergestellt werden. Sollte die Suspendierung von einem Account
während der Ausfallszeit abgelaufen sein, kann das beim Neustart einfach
ermittelt werden.

Mit dem entwickelten Transaktionsmanager sind gratis Transaktionen
möglich, ohne dass die Sicherheit der Blockchain komprimitiert wird. Das
ermöglicht der FHNW, ihren Studierenden und Mitarbeitenden, eine sichere und
kostenneutrale Lernumgebung anzubieten. Damit konnten alle Ziele der
Projektvereinbarung erreicht werden.

Zu Beginn ist eine Implementation des Transaktionsmanagers auf der Blockchain
mittels Smart Contracts angestrebt worden. Dieser Ansatz bedingt jedoch eine
Anpassung von Parity. Aktuell hält Parity eine Liste von Accounts, die für
gratis Transaktionen berechtigt sind. Um den Transaktionsmanager völlig
dezentral zu realisieren, müsste die Whitelist von Parity so angepasst werden,
dass nicht nur Accounts, sondern Verbindungen geprüft werden. Nur so kann
sichergestellt werden, dass gratis Transaktionen über den Transaktionsmanager
abgewickelt werden.\
Der Umfang und Komplexität dieser Anpasungen sind im gegebenen Zeitrahmen, als
nicht realisierbar eingeschätzt worden. Daher haben wir beschlossen, den
Transaktionsmanager als Java-Applikation zu realisieren. Diese Version des
Transaktionsmanagers ist eine zentrale Authorität. Das entspricht nicht dem
dezentralitäts Prinzip einer Blockchain.

Das Aufsetzen einer Blockchain mit Parity ist unterschätzt worden. Bei der
Konfiguration der Blockchain mussten wir feststellen, dass die Dokumentation
sehr oft unvollständig oder veraltet ist. Dadurch hat sich die Bereitstellung
der Blockchain stark verzögert. Aufgrund der Verzögerung musste der Fokus
stärker als geplant auf die Kernfunktionalität gerichtet werden. Dadurch konnte
zum Beispiel ein automatisierter Deploy des Certifiers nicht implementiert
werden.\


