
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

| # TX gemacht | Limite |  # TX verarbeitet|Revoked|
|-------:|---------:|------:|:---:|
|4|5| 4|Nein|
|5|5|5|Nein|
|6|5|6|Ja|
|10|5|10|Ja|
|100|5|ca 30|Ja|
|500|450|500|Ja|
1000|450|ca 630|Ja|

Table: Leistungstest mit gratis Transaktionen \label{tab_tests}

Die Tabelle \ref{tab_tests} zeigt die Testparameter und das Resultat. Mit "# TX
gemacht" wird angegeben, wie viele Transaktionen in der Schleife erstellt
werden. "Limite" definiert die Transaktionslimite des Accounts pro
Reset-Intervall. In der Spalte "# TX verarbeitet" ist aufgeführt, wie viele
Transaktionen gratis verarbeitet worden sind. Die Spalte "Revoked" zeigt, ob der
Account am Ende des Tests von der Whitelist entfernt wurde.\
Die ersten drei Test prüfen um den Grenzwert. Diese verhalten sich wie erwartet.
Fünf gratis Transaktionen dürfen ohne Konsequenzen durchgeführt werden. Nach der
sechsten wird der Account von der Whitelist entfernt.\
Die folgenden Tests sind erfolgreich. Allerdings ist festgestellt worden, dass
der Transaktionsmanager nicht sofort reagiert. 

//TODO Delay untersuchen




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
