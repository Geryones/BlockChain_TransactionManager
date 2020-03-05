
## Transaktionsmanager  \label{sec_prac_ext_prog}

In diesem Kapitl ist die Implementierung des Transaktionsmanagers zur Überwachung
der Whitelist in Parity beschrieben. Anhand von Codeausschnitten ist die
Funktionsweise von einzelnen Komponenten näher erklärt. 

### Wrapperklassen

Für die Interaktion mit Smart Contracts werden generierte Wrapperklassen
verwendet. Es ist je eine Wrapperklasse für die Name Registry und den Certifier
vorhanden. Für dessen Generierung und Verwendung siehe
\ref{sec_prac_deployment}.

### Initialisierung

Wenn die Blockchain frisch aufgesetzt wird, sind inital keine gratis
Transaktionen möglich. Der dafür nötige Certifier ist noch nicht deployed oder
bei der Name Registry registriert.\
Mit der Methode ```init``` in der Klasse ```Main``` wird die Blockchain für den
Betrieb vorbereitet. Folgende Schritte werden dabei ausgeführt:

1. Instanzierung der Name Registry\
   Mit der Wrapperklasse für die Name Registry und deren Adresse auf der
   Blockchain wird ein Objekt für die Interaktion mit dem eigentlichen Smart
   Contract erzeugt. 
1. Deployment des Certifiers\
   Die Wrapperklasse für den Certifier wird instanziert und auf die Blockchain
   deployed. 
1. Registrierung des Certifiers bei der Name Registry\
   Die Adresse des Certifiers wird bei der Name Registry registriert.
1. Zertifizierung von Account für Transaktionsmanager\
   Der Account des Transaktionsmanagers wird für gratis Transaktionen
   berechtigt. 

Siehe \ref{sec_prac_deployment} für mehr Informationen zu Wrapperklassen,
Deployment und Registrierung von Accounts.

Die Adresse der Name Registry wird aus der Konfigurationsdatei gelesen, siehe
\ref{sec_prac_conf}. Hier muss beachtet werden, dass diese mit der Adresse in
der Blockchainspezifkation, siehe \ref{sec_prac_spec}, übereinstimmen muss.\
Sobald der Certifier deployed ist, wird dessen Adresse in die
Konfigurationsdatei geschrieben. Sobald die Überwachung der Blockchain gestartet
wird, wird die Adresse ausgelesen und der Certifier instanziert.\
Der Account für den Transaktionsmanger wird in der Blockchainspezifikation
definiert, siehe \ref{sec_prac_spec}. Dieser Account wird verwendet um
Änderungen an der Whitelist vorzunehmen. Aus Sicherheitsgründen wird der private
Schlüssel von diesem Account nicht in den Quellcode des Transaktionsmanagers
geschrieben. Er wird beim Start der Applikation aus einer eigenen Datei gelesen.
Hier muss beachtet werden, dass diese Datei bei der Verwendung von einer
Versionierungssoftware nicht inkludiert wird.



### DoS Algorithmus

//TODO

### Überwachung von Transaktionen

Um die Transaktionen auf der Blockchain zu Observieren wird ein
Filter[@web3j_filter] von Web3j verwendet. Dieser erlaubt es, eine
```Subscription``` zu erstellen. Diese läuft asynchron in einem eigenen Thread.\
Jede getätigte Transaktion wird von der ```Subscription``` erfasst. In einem
ersten Schritt wird der verwendete Gas Preis der Transaktion betrachtet. Nur
wenn dieser null ist, wird die Transaktion und der dazugehörende Account durch
den DoS Algorithmus evaluiert. 


![Prozess bei der Überwachung von Transaktionen \label{img_prac_interactions}](images/process_whitelist.png "Überwachung von gratis Transaktionen durch Java Programm")

Auf der Abbildung \ref{img_prac_interactions} sind die Interaktionen zwischen
dem Transaktionsmanager, der Blockchain und den Benutzern gezeigt. Transaktionen
sind mit "TX" abgekürzt.\
Links auf dem Diagramm sind die Benutzer "A" und "C" mit ihrem jeweiligen
Account abgebildet. In der Liste ```Accounts``` im Java-Programm sind alle
Accounts erfasst, die für gratis Transaktionen berechtigt sind. Hier ist für
jeden Account vermerkt, wie viele gratis Transaktionen und wie viel gratis Gas
im aktuellen Reset-Intervall bereits verbraucht wurde.\
Die beiden Benutzer erstellen je eine Transaktion mit einem Gas Preis von
null. Diese werden an den Parity Node übermittelt.\
Beim Node wird geprüft, ob der Sender in der Whitelist erfasst ist. Dieser
Vorgang ist unter \ref{prac_nameRegistry_Certifier} genauer erklärt. Der Account
von Benutzer C ist nicht erfasst. Daher wird seine Transaktion vom Node
abgelehnt. Der Benutzer C erhält einen Error, da er einen ungültigen Gas Preis
verwendet hat.\
Die Transaktion von Benutzer A wird vom Node akzeptiert, da sein Account in der
Whitelist erfasst ist. Die Transaktion wird anschliessend verarbeitet und in den
nächsten Block aufgenommen.\
Die Subscription im Java-Programm registriert, dass eine neue Transaktion in die
Blockchain aufgenommen worden ist. Die Daten der Transaktion werden heruntergeladen.
Der verwendete Gas Preis wird überprüft. Bei einem Gas Preis ungleich null, wird
die Transaktion nicht weiter betrachtet.\
Falls bei der Transaktion ein Gas Preis von null festgestellt worden ist, wird
der Sender ermittelt, in diesem Fall der Account XX. Die Zähler des Accounts
werden in der Liste ```Accounts``` aktualisiert. Der Account wird anschliessend
an den DoS Algorithmus übergeben.\
Im DoS Algorithmus wird die Anzahl getätigter gratis Transaktionen und das
verbrauchte Gas ausgewertet. Es wird geprüft, ob mit der neu erfassten
Transaktion ein Grenzwert im aktuellen Reset-Intevall überschritten worden ist.
Wenn das nicht der Fall ist, sind keine weiteren Aktionen nötig. Ist ein
Grenzwert überschritten worden, wird dies für den entsprechenden Account in
```Accounts``` festgehalten. Zusätzlich wird eine Transaktion erstellt, die den
Account von der Whitelist in Parity entfernt.


### Persistenz \label{prac_persistenz}

Um die Datenpersistenz zu gewährleisten, wird die Whitelist des
Transaktionsmanagers in einer Textdatei gespeichert. Wird das Programm gestoppt,

Dafür wird die Datei ```AccountList.txt``` verwendet. Relativ zur JAR-Datei des
Transatkionsmanagers muss sie in folgendem Verzeichnis liegen: 

//TODO Filepath

In dieser Datei sind alle Accounts, die auf der Whitelist sind erfasst. Bei
jedem Account können die inidviduell konfigurierbaren Parameter gesetzt werden.\
Nach einem Programmstop, wird die Datei ausgelesen. Alle Accounts werden
geladen. Wo nötig, die individuellen Parameter gesetzt.

Pro Zeile wird ein Account mit einer Adresse definiert. Zusätzlich kann
die Anzahl gratis Transaktionen und die Menge gratis Gas pro Account definiert
werden. Hier muss beachtet werden, dass es nicht möglich ist, nur einen der
fakultativen Parameter anzugeben. Es müssen beide oder keine angegeben werden.\
Die Accountliste wird zeilenweise interpretiert. Das Einlesen der Datei
hat keine Fehlertoleranz. Daher muss die hier beschriebene Struktur für jede Zeile eingehalten werden:

1. Accountadresse
2. Anzahl verbleibende Revoke-Intervalls 
3. [Anzahl gratis Transaktionen]
4. [Menge an gratis Gas]

Sind die Parameter für Anzahl Transaktionen und Gas nicht gesetzt, wird der Standardwert verwendet, siehe \ref{sec_prac_conf}


Falls ein Account zum Zeitpunkt des Programmstops von gratis Transaktionen
suspendiert war, ist dies mit "Anzahl verbleibende Revoke-Intervalls" vermerkt. In diesem Fall wird die
verbleidende Dauer evaluiert. Ist die Dauer der Suspendierung bei Programmstart
bereits verstrichen, wird der Account wieder zertifiziert. Andernfalls, wird die
verbleibende Dauer der Suspendierung, unter Berücksichtigung der Ausfallzeit neu
berechnet und gesetzt.

Automatische Suspendierungen von Transaktionsmanager sind immer temporär. Soll
ein Account permanent von der Whitelist gelöscht werden, muss dies manuell in
der Datei oder via  gemacht werden. Beim entsprechenden Account muss vor der Adresse ein
neuer Paramater eingefügt werden. Beim nächsten Intervall oder Start des
Transaktionsmanagers, wird der Account von der Whitelist in Parity und dem
Transaktionsmanager gelöscht. Anschliessend wird auch der Eintrag in der Datei
entfernt.\
Mehr zur Konfigurationsdatei und Beispiele sind im nachfolgenden Abschnitt,
\ref{sec_prac_conf}, zu finden.\




#### Beispiel

Ein mögliche Konfigurationsdatei könnte folgendermassen ausehen: 

```{.numberLines}
2;3;10;50000000;
0xaf02DcCdEf3418F8a12f41CB4ed49FaAa8FD366b;0;0;5;100000
0xf13264C4bD595AEbb966E089E99435641082ff24;0;0
0x00a329c0648769A73afAc7F9381E08FB43dBEA72;0;5;3;500000
```

Zeile 1
:     Reset-Intervall mit 2 Minuten, Revoke-Intervall mit einem Multiplikator 
von 3, den Standardwert für gratis Transaktionen mit 10 und der Standardwert 
für gratis Gas mit 50'000'000 Einheiten. 

Zeile 2
:     Accountadresse mit individuell konfigurierten Parametern. Der Account 
ist noch nie von der Whitelist suspendiert worden und hat auch keine verbleibenden 
Revoke-Intervalls. Das heisst, der Account ist auf der Whitelist. Der Account kann 
also 5 gratis Transaktionen oder 100'000 Gaseinheiten pro Reset-Intervall verbrauchen. 

Zeile 3
:     Eine Accountadresse ohne individuelle Parameter. Auch dieser Account wurde 
noch nie suspendiert und hat keine verbleibenden Revoke-Intervalls. Dieser Account 
wird mit Standardwerten versehen. Er kann also 10 gratis Transaktionen oder 50'000'000 
Einheiten Gas pro Reset-Intervall verbrauchen. 

Zeile 4
:     Accountadresse mit individuell konfigurierten Parametern. Dieser Account wurde 
bereits 1 Mal suspendiert. Er befindet sich zur Zeit nicht auf der Whitelist, da er noch 
für 5 weitere Revoke-Intervalle suspendiert ist. Der Account kann, sobald der Zähler 
für Revoke-Intervalle wieder auf 0 ist, 3 gratis Transaktionen oder 50'000 Gaseinheiten 
pro Reset-Intervall verbrauchen. 




#### Konfiguration \label{sec_prac_conf}

//TODO

ConnectionString,IntervallZeit,DefaultrevokeCounter,DefaultMaxTx,DefaultMaxGas,RegisterAdd; Certifier


Die Konfiguration des Programmes findet mit zwei weiteren Textdateien statt. Die Dateien müssen sich im selben Verzeichnis wie ```AccountList.txt``` befinden. Siehe \ref{prac_persistenz}. 

```TransaktionManagerAccount.txt```
:     Der Transaktionsmanager benötigt für alle Interaktionen mit der Blockchain einen Account. In dieser Datei ist der private SChlüssel gespeichert. Hier muss darauf geachtet werden, dass der Schlüssel nicht versehentlich bei einer Versionierungssoftware hinzugefügt wird. 

```DefaultSettings.txt```
:      Mit dieser Datei wird der Transaktionsmanager konfiguriert. 


Die Konfigurationsdatei wird zeilenweise interpretiert. Das Einlesen der Datei
hat keine Fehlertoleranz. Daher muss die hier beschriebene Struktur stets
eingehalten werden. In der ersten Zeile werden folgende Parameter angegeben:

1. Verbindungsstring zur Blockchain 
1. Reset-Intervall in Minuten
2. Revoke-Intervall
3. Standardwert für gratis Transaktionen
4. Standardwert für gratis Gas
5. Adresse der Name Registry
6. [Adresse des Certifiers]

Die ersten 6 Parameter müssen angegeben und mit einem ```;``` separiert werden. Der letzte Parameter, die Adresse des Certifiers, wird nach erfolgreichem Depyloment des Certifiers selbst gesetzt.\





