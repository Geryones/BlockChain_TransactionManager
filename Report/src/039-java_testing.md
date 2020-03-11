
### Tests

//TODO Jurij ausformulieren

Um die Lauffähigkeit des Transaktionsmanagers zu verifizieren, sind diverse
Tests ausgeführt worden.\
Mit Unit Tests ist die Funktionalität von einzelnen
Aspekten geprüft worden. Dazu gehören unter anderem, isolierte Transaktionen
ausführen, lesen und schreiben von Dateien.\
Mit einem Leistungstest ist untersucht worden, wie sich der Transaktionsmanager
unter Belastung verhält.\
Mit den Abnahmetests ist sichergestellt, dass die Applikation als Ganzes,
wie gewünscht funktioniert.

#### Unit Tests

Die Funktionalität von zentralen Methoden sind mit Unittests geprüft worden.
Im Anhang sind alle durchgeführten Tests unter \ref{app_tests} verlinkt. 

Alle Unit Tests sind erfolgreich. 

#### Leistungstest

Um die Leistung des Transaktionsmanagers zu testen, werden verschieden hohe
Transaktionslimiten auf einem Account geprüft.\
Im Test werden mit einer Schleife, in sehr rascher Folge, gratis Transaktionen
getätigt. Am Ende wird geprüft, ob der Account von der Whitelist entfernt worden
ist. Folgende Kombination von gratis Transaktionen und Transaktionslimite ist
getestet worden:

| # Transaktionen | Limite |
|-------:|---------:|
|4|5|
|5|5|
|6|5|
|10|5|
|100|5|
|500|450|

Table: Leistungstest mit gratis Transaktionen \label{tab_tests}

Die Tabelle \ref{tab_tests} zeigt die Testparameter. Die ersten drei Test prüfen
um den Grenzwert. Diese verhalten sich wie erwartet. Fünf gratis Transaktionen
dürfen ohne Konsequenzen durchgeführt werden. Nach der sechsten wird der Account
von der Whitelist entfernt.\
Die Tests mit 10 ist zwar erfolgreich, jedoch wird der Account nicht schnell
genug von der Whitelist entfernt. Es sind alle 10 gratis Transaktionen
ausgeführt worden. Um zu prüfen, wie viele Transaktionen verarbeitet werden
können, bevor der Account von der Whitelist entfernt wird, haben wir die gratis
Transaktionen auf 100 erhöht. Im Durchschnitt werden 30 gratis Transaktionen
verarbeitet, bevor der Transaktionsmanager den Account von der Whitelist
entfernen kann.\

//TODO Verhalten bei 500... können alle 500 durchgeführt werden? ist nach 450 schluss?


#### Abnahme Test

Hier wird das Zusammenspiel aller Komponenten geprüft.\
Um die funktionalen Aspekte zu prüfen führt ein Account auf der Whitelist gratis
Transaktionen aus. Anschliessend werden die Zähler des Accounts überprüft. Am
Ende des Reset-Intervalls wird geprüft, ob die Zähler zurückgesetzt werden. So
wird geprüft ob die Subscription, der DoS Algorithmus, das Reset-Intervall und
die Priority Queue zusammen funktionieren.\
Es ist auch geprüft worden, ob der registrierte Certifier mit einer eigenen Version ersetzt werden kann. Damit könnte ein Benutzer den Transaktionsmanager umgehen. Der Schutz vor einer DoS Attacke wäre nicht mehr gewährleistet.

Beide Tests sind erfolgreich, der Transaktionsmanager verhält sich wie gewünscht.   

#### Schlussfolgerung

Automatisierte Tests bestätigen was manuelle Tests bewiesen hatten
Es können viele Transaktionen gemacht werden
Tests brauchen lange um abgespielt zu werden, da man zwischen den Tests warten muss, dass der nächste ausgeführt werden kann
Eine hoche Limite bei den Transaktionen und Gas ist erforderlich
