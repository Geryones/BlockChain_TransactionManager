
### Tests

Um die Lauffähigkeit des Transaktionsmanagers zu verifizieren, sind diverse
Tests ausgeführt worden.\
Mit Unit Tests ist die Funktionalität von einzelnen
Aspekten geprüft worden. Dazu gehören unter anderem, isolierte Transaktionen
ausführen, Lesen und Schreiben von Dateien.\
Mit einem Leistungstest ist untersucht worden, wie sich der Transaktionsmanager
unter Belastung verhält.\
Mit den Abnahmetests ist sichergestellt, dass die Applikation als Ganzes,
wie gewünscht funktioniert.

#### Unit Tests

Die Funktionalität von zentralen Methoden sind mit Unittests geprüft worden.

Alle Unit Tests sind erfolgreich. Sie sind im Anhang unter \ref{app_tests} verlinkt.

#### Leistungstest

Um die Leistung des Transaktionsmanagers zu testen, werden verschieden hohe
Transaktionslimiten auf einem Account geprüft.\
Im Test wird mit einer Schleife, in sehr rascher Folge, gratis Transaktionen
getätigt. Am Ende wird geprüft, ob der Account von der Whitelist entfernt worden
ist. Folgende Kombination von gratis Transaktionen und Transaktionslimite ist
getestet worden:

| # TX gemacht | Limite |  # TX verarbeitet|Revoked|
|-------:|---------:|------:|:---:|
|4|5| 4|Nein|
|5|5|5|Nein|
|6|5|6|Ja|
|10|5|10|Ja|
|100|5|100|Ja|
|500|450|500|Ja|
|1000|450|ca 980|Ja|
|2000|450|ca 980|Ja|

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
Die folgenden Tests sind erfolgreich, da der Account am Ende von der Whitelist
entfernt ist. Allerdings ist festgestellt worden, dass der Transaktionsmanager
nicht sofort reagiert. Bis der Transaktionsmanager reagiert, können ungehindert
gratis Transaktionen gemacht werden.\
Die Verzögerung ist weiter untersucht worden. Dabei wurde festgestellt, dass vom
Zeitpunkt der ersten Transaktion, es immer zwischen 14 und 15 Sekunden dauert,
bis diese in der Subscription registriert wird. In dieser Zeit konnten mir einer
```for```-Schleife, ca 760 Transaktionen abgesetzt werden.\
Sobald die Subscription die getätigten Transaktionen erhält, ist die Limite
bereits überschritten worden. Während die Subscription die anfallenden
Transaktionen abarbeitet, werden in der ```for```-Schleife laufend neue
abgesetzt.\
Ab dem Moment, wo die erste Transaktion von der Subscription registriert wird,
dauert es nochmals zwischen 14 und 15 Sekunden, bis der Account revoked ist.\
Dieses Verhalt ist mit der Zeit zwischen Blöcken zu erklären. Sobald der Node
die erste Transaktion erhält, wird ein neuer Block erstellt und befüllt. Nach
14-15 Sekunden wird dieser an die Blockchain übermittelt. Es wird ein neuer
Block befüllt. Während dieser Zeit hat der Transaktionsmanager registriert, dass
die Limit erreicht worden ist. Er sendet ebenfalls eine Transaktion an den
Node.\
Der Node hat bereits sehr viele gratis Transaktionen, deren Verarbeitung noch
ausstehend sind. Die Transaktion vom Transaktionsmanger wird prioritär
behandelt, da es keine gratis Transaktion ist. Nach weiteren 14 bis 15 weiteren
Sekunden, erreicht der zweite Block die Blockchain. Erst jetzt, kann das Revoke
verarbeitet werden. Ab diesem Zeitpunkt, akzeptiert der Node keine weiteren
gratis Transaktionen von diesem Account.



#### Abnahmetest

Hier wird die Applikation als Ganzes geprüft.\
Um die funktionalen Aspekte zu prüfen führt ein Account auf der Whitelist gratis
Transaktionen aus. Anschliessend werden die Zähler des Accounts überprüft. Am
Ende des Reset-Intervalls wird geprüft, ob die Zähler zurückgesetzt werden. So
wird geprüft ob die Subscription, der DoS Algorithmus, das Reset-Intervall und
die Priority Queue zusammen funktionieren.\
Es ist auch geprüft worden, ob der registrierte Certifier mit einer eigenen
Version ersetzt werden kann. Damit könnte ein Benutzer den Transaktionsmanager
umgehen. Der Schutz vor einer DoS Attacke wäre nicht mehr gewährleistet.

Beide Tests sind erfolgreich, der Transaktionsmanager verhält sich wie gewünscht.   

Weiter wurden manuell alle Abnahmekriterien, siehe
\ref{sec_prac_abnahmekriterien}, geprüft. Das Abnahmetestprotokoll ist unter
Kapitel \ref{sec_prac_abnahmeprotokoll} aufgeführt.

#### Schlussfolgerung

Die Leistungstests haben gezeigt, dass der Transaktionsmanger direkt von den
Blöcken abhängig ist. Je nach Grösse und Frequenz von neuen Blöcken müssen die
Parameter von Accounts und DoS Algorithmus entsprechend angepasst werden.\
Mit den verwendeten Einstellungen und einer Transaktionslimite von 450, wird ein
Angriff nach ungefähr 30 Sekunden unterbunden.\
Tiefere Limiten ändern an diesem Verhalten nichts. Der Angreifer hat dennoch die
Möglichkeit einen Block komplett zu füllen. Eine mögliche Strategie wäre, die
Limite an der Kapazität von einem Block anzugleichen. Diese ist abhängig vom
maximalen Gas pro Block und der Frequenz, in der Blöcke erstellt werden.\
Ein Node priorisiert Transaktionen anhand des verwendeten Gas Preises. Um
sicherzustellen, dass die Transaktionen des Transaktionsmanagers beim Node
prioritär behandelt werden, muss ein gültiger Gas Preis verwendet werden. Es ist
daher nötig, den Account des Transaktionsmanagers mit einem hohen Guthaben zu
initialisieren. 
