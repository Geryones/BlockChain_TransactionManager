## Lösungsansätze 

In diesem Kapitel werden die erarbeiteten Lösungsansätze für die Implementation
eines Transaktionsmanagers vorgestellt. Die Stärken und Schwächen von jedem
Lösungsansatz (LA) werden analysiert und dokumentiert. Mit der vorgenommenen
Analyse wird ein Favorit bestimmt. Dieser wird weiterverfolgt und implementiert.


### Architektur 

Die erarbeiteten Architektur-Lösungsansätze (ALA) werden in diesem Abschnitt
behandelt. 

#### ALA 1: Smart Wallet \label{sec_ala_1}

Es wird selbst eine Smart Wallet entwickelt. Diese benötigt die volle
Funktionalität einer herkömmlichen Wallet. Zusätzlich ist ein Schutzmechanismus
gegen DoS Attacken implementiert. Für jeden Benutzer existiert eine Smart Wallet.\
Wie unter \ref{sec_whitelist} beschrieben, wird für die Betreibung der
Blockchain der Client Parity mit einer Withelist verwendet. 

![Architektur mit Smart Wallet \label{img_arc_smartWallet}](images/solution1_v2.png "Architektur mit Smart Wallet") 

Auf dem Diagramm \ref{img_arc_smartWallet} ist zu sehen, dass ein Benutzer über
mehrere Accounts verfügen kann. Diese sind in der Smart Wallet des Benutzers
registriert. Gratis Transaktionen die von einem dieser Accounts durch
die Smart Wallet gesendet werden, müssen vom DoS Algorithmus geprüft werden.\
In diesem Beispiel möchte Benutzer A zwei gratis und eine reguläre Transaktion (TX) tätigen.
Für die erste Transaktion wird Account XX1 verwendet. In der Smart Wallet wird
überprüft, ob sich der Account auf der Whitelist befindet. Diese Prüfung ist
erfolgreich. Die Smart Wallet erstellt die gewünschte Transaktion für den
Account XX1.\
Anschliessend wird die abgeschlossene Transaktion vom DoS Algorithmus
ausgewertet. Dafür kann nicht nur eine einzige Transaktion betrachtet werden. Es
muss das Verhalten aller Accounts von Benutzer A betrachtet werden, die sich auf
der Whitelist befinden. Sollte der DoS Algorithmus, das Verhalten als Gefahr
einstufen, müssen alle registrierten Accounts dieser Wallet von der Whitelist
gelöscht werden. Der Benutzer kann weiterhin alle seine Accounts benutzen, muss
aber für die Transaktionsgebühren aufkommen.\
Die zweite gratis Transaktion möchte der Benutzer A mit seinem Account XX2
tätigen. Der Account befindet sich jedoch nicht in der Whitelist. Folglich wird
die Transaktion nicht erstellt. Der Benutzer erhält einen Error.\
Die dritte Transaktion wird ebenfalls mit Account XX2 erstellt. Es handelt sich
jedoch nicht um eine gratis Transaktion. Diese wird erstellt und erreicht ihr
Ziel ungehindert. Eine Prüfung durch den DoS Algorithmus ist folglich nicht
nötig. 

Wie in \ref{sec_whitelist} beschrieben, prüft Parity bei einer gratis
Transaktion nur, ob sich der Account in der Whitelist befindet. Das bedeutet,
dass mit einem whitelisted Account auch gratis Transaktionen getätigt werden
können, die nicht an die Smart Wallet gerichtet sind. Somit kann der Benutzer
den DoS Schutzmechanismus umgehen. Deswegen muss ein Weg gefunden werden, der
den Benutzer zwingt, Transaktionen über die Smart Wallet abzuwickeln.\
Eine Möglichkeit ist Parity selbst zu erweitern. Anstelle einer Liste mit
Accounts, muss in der Whitelist eine Liste von Verbindungen geführt werden. So kann definiert
werden, dass nur eine Transaktion auf die Smart Wallet gratis ist. 

##### Pro

Dieser Ansatz besticht durch die Tatsache, dass alles auf der Blockchain läuft.
Somit werden grundlegende Prinzipien, wie Dezentralität und Integrität einer
Blockchain bewahrt. 

##### Contra

Die Machbarkeit des Ansatzes ist unklar. Um diesen Ansatz umzusetzen, muss der
Blockchain Client, Parity, erweitert werden. Es ist unklar, wie weitreichend die
Anpassungen an Parity sind. Zusätzlich wird eine zusätzliche Programmiersprache,
Rust[@rust], für die Umsetzung benötigt.\
Bei einer Anpassung am DoS Algorithmus, müssen alle Smart Wallets aktualisiert werden. 

##### Prozessworkflow

Der Prozessablauf für eine gratis Transaktion mit ALA 1 könnte folgendermassen aussehen.

![Flowchart für Smart Wallet \label{img_flow_solution1}](images/flow_solution1_v2.png "Flowchart für Smart Wallet"){ width=50% height=50% }

Im Diagramm \ref{img_flow_solution1} wird zu Beginn eine gratis Transaktion
erstellt. Diese erreicht einen Parity Node. Nun wird geprüft ob der Sender der
Transaktion sich auf der Whitelist befindet. Ist das nicht der Fall, wird die
Transaktion abgebrochen. Ist die Prüfung erfolgreich, wird die Transaktion
erstellt und ausgeführt.\
Anschliessend bewertet der DoS Algorithmus das Verhalten des verwendeten
Accounts. Wird eine Gefahr für die Blockchain festgestellt, wird der Account von
der Whitelist entfernt. Gratis Transaktionen sind dann für diesen Account nicht
mehr verfügbar. Wenn keine Gefahr festgestellt werden kann, kann der Account
auch weiter für gratis Transaktionen genutzt werden.

#### ALA 2: Externes Programm für die Verwaltung der Whitelist \label{sec_ala_2}

Bei diesem Ansatz wird auf die Entwicklung einer Smart Wallet verzichtet.
Stattdessen wird der Schutzmechanismus gegen DoS Attacken in einem externen
Programm, dem Transaktionsmanager, implementiert. Dieser Ansatz verwendet ebenfalls
die Whitelist von Parity, siehe \ref{sec_whitelist}.

![Externes Programm für die Verwaltung der Whitelist \label{img_solution2}](images/solution2_v2.png "Externes Programm für die Verwaltung der Whitelist") 

Auf dem Diagramm \ref{img_solution2} ist dargestellt, wie der Benutzer A zwei
gratis und eine reguläre Transaktion tätigen will. Bei der ersten gratis
Transaktion (gratis TX 1) wird der Account XX1 verwendet. Die Prüfung, ob sich
der Account auf der Whitelist befindet ist erfolgreich. Die Transaktion kann
daher erfolgreich verarbeitet werden und erreicht ihr Ziel.\
Für die zweite gratis Transaktion (gratis TX 2) wird der Account XX2 verwendet.
Dieser befindet sich nicht auf der Whitelist. Die Prüfung schlägt deshalb fehl.
Die Transaktion wird zurückgewiesen und der Benutzer erhält einen Error.\
Auch die dritte Transaktion (Tx für Account XX2) verwendet den Account XX2. Da
es sich nicht um eine gratis Transaktion handelt, kann diese problemlos
ausgeführt werden.\
Der Transaktionsmanger wird auf einem Server der FHNW ausgeführt. Er überwacht
alle Transaktionen die erstellt werden. Es werden jedoch nur gratis
Transaktionen mit dem DoS Algorithmus geprüft. Sollte diese Prüfung eine Gefahr
für die Blockchain detektieren, wird der entsprechende Account von der Whitelist
gelöscht. Dies wird mit dem Pfeil "Verwaltung von Accounts auf Whitelist"
dargestellt.\
Der Transaktionsmanager verfügt über einen eigenen Account, siehe
\ref{sec_account}. Dieser ist berechtigt, die Whitelist zu manipulieren. Dadurch
kann bei einer identifizierten Attacke, der angreifende Account automatisch von
der Whitelist gelöscht werden. 

##### Pro

Dieser Ansatz ist sicher umsetzbar in der zur Verfügung stehenden Zeit.\
Falls eine Anpassung des DoS Schutzalgorithmus nötig ist, muss nur das externe
Programm neu ausgerollt werden. Eine Aktualisierung der Whitelist ist nicht nötig.


##### Contra

Es wird das Hauptprinzip, Dezentralität, einer Blockchain verletzt. Der
Transaktionsmanager ist eine zentrale Autorität, die von der FHNW kontrolliert
wird.\
Für die Betreibung des Transaktionsmangers wird ein Server benötigt. Eine
weitere Komponente, die administriert werden muss. 

##### Prozessworkflow

Das Diagramm \ref{img_flow_solution2} zeigt, wie der Prozessworkflow beim ALA 2
aussieht. 

![Flowchart Transaktionsmanager für Verwaltung der Whitelist \label{img_flow_solution2}](images/flow_solution2_v2.png "Flowchart externes Programm für die Verwaltung der Whitelist"){ width=50% height=50% } 

Der Benutzer initialisiert eine gratis Transaktion. Beim Parity Node
wird überprüft, ob der verwendete Account sich auf der Whitelist befindet. Ist
er das nicht, wird die Transkation abgebrochen und der Benutzer erhält einen
Error. Ist ein Account verwendet worden, der sich auf der Whitelist befindet,
wird die Transaktion in die Blockchain aufgenommen.\
Der Transaktionmanager überwacht alle Transaktionen die auf die Blockchain
gelangen. Bei gefunden gratis Transaktionen wird das Verhalten des Senders mit
dem DoS Algorithmus analysiert. Wird eine Bedrohung für die Blockchain
detektiert, wird der Account von der Whitelist entfernt.\
Diese Prüfung findet nicht auf der Blockchain statt. Um einen Account von der
Whitelist zu entfernen, generiert der Transaktionsmanager eine Transaktion.

#### ALA 3: Externes Programm mit Whitelist

Wie in Abbildung \ref{img_solution3} illustriert, ist der Blockchain ein
externes Programm, der Transaktionsmanager, vorgelagert. Dieser führt eine
Whitelist für Accounts die gratis Transaktionen ausführen dürfen. Der DoS
Algorithmus befindet sich ebenfalls im Transaktionsmanager.\
Weiter wird eine Smart Wallet entwickelt. Diese ist nötig, um die
verschachtelten Transaktionen des Programms zu verarbeiten. Aus dem Data-Feld
wird die eigentliche Transaktion extrahiert und abgesetzt.\
Jeder Benutzer besitzt eine eigene Smart Wallet um die Sender Identität für
jeden Benutzer einmalig zu halten.\
Auf der im Abschnitt \ref{sec_whitelist} beschriebenen Whitelist ist nur der
Account des externen Programmes aufgelistet. So ist sichergestellt, dass nur
Transaktionen, die vom Programm weitergeleitet werden, kostenfrei durchgeführt
werden können. Der Benutzer kann immer mit kostenpflichtigen Transaktionen auf
die Smart Wallet zugreifen. Dies ist insbesondere wichtig, falls das Programm
nicht aufrufbar ist, wenn z.B. der Server ausfällt.

![Transaktionsmanager mit Whitelist \label{img_solution3}](images/solution3_v2.png "Externes Programm mit Whitelist") 

Diagramm \ref{img_solution3} zeigt die Benutzer mit ihren Accounts auf der
linken Seite. Benutzer A initiiert in diesem Beispiel zwei gratis und eine
gebührenpflichtige Transaktion.\
Die erste gratis Transaktion (TX 1) wird an den Transaktionsmanager übermittelt.
Hier wird zuerst geprüft, ob sich der verwendete Account auf der Whitelist
befindet. Bei dieser Transaktion fällte die Prüfung positiv aus. Das Verhalten
des Accounts wird daher durch den DoS Algorithmus untersucht. Sollte eine Gefahr
detektiert werden, wird der betroffene Account von der Whitelist des
Transaktionsmanagers gelöscht. Hier ist dies nicht der Fall. Die Transaktion "TX
1" wird im Data Feld, siehe \ref{sec_transaktionen}, einer neu generierten
Transaktion (TX 3) an die Blockchain gesendet. Bei "TX 3" handelt es sich
ebenfalls um eine gratis Transaktion. Ansonsten würden die Kosten einer
Transaktion nicht wegfallen, sondern nur umgelagert werden.\
Sobald "TX 3" beim Node ankommt, wird überprüft ob sich der Sender auf der
Whitelist befindet. Das ist der Account des Transaktionsmanagers. Auf der
Whitelist von Parity ist nur dieser Account vorhanden.\
Nach erfolgter Prüfung, kommt "TX 3" bei der Smart Wallet an und wird
verarbeitet. Die ursprüngliche Transaktion "TX 1" wird aus dem Data Feld
extrahiert und versendet. Dies ist mit "TX 4" dargestellt. Als Absender ist
wieder der Account XX1 gesetzt.\
Bei der zweiten gratis Transaktion (TX 2), befindet sich der verwendete Account
nicht auf der Whitelist des Transaktionsmanagers. Die Transaktion wird
zurückgewiesen und der Benutzer erhält einen Error.\
Bei der dritten Transaktion werden die Gebühren bezahlt. Es besteht daher kein
Bedarf, die Transaktion an den Transaktionsmanager zu senden. Sie kann direkt
über die Smart Wallet erstellt und verarbeitet werden. 



##### Pro

Dieser Ansatz ist in der gegebenen Zeit umsetzbar.\
Falls eine Anpassung des DoS Schutzalgorithmus nötig ist, muss nur das externe
Programm neu ausgerollt werden. Eine Aktualisierung der Whitelist ist nicht
nötig.  

##### Contra

Es wird das Hauptprinzip, Dezentralität, einer Blockchain verletzt. Der
Transaktionsmanager ist eine zentrale Autorität, die von der FHNW kontrolliert
wird. Dieser benötigt einen Server, es kommt also eine weitere Komponente dazu.
Diese muss ebenfalls administriert werden.\
Dieser Ansatz bietet keine Vorteile im Vergleich zum ALA 2, ist aber mit der
Verschachtelung von Transaktionen komplexer. 

##### Prozessworkflow

Wie auf Diagramm \ref{img_flow_solution3} gezeigt, beginnt der Prozess mit der
Initialisierung einer gratis Transaktion durch den Benutzer.

![Flowchart für Transaktionsmanager mit Whitelist \label{img_flow_solution3}](images/flow_solution3_v2.png "Flowchart externes Programm mit Whitelist")

 Diese wird an den Transaktionsmanager übermittelt. In erster Instanz wird
geprüft, ob der verwendete Account für gratis Transaktionen berechtigt ist. Nur
wenn diese Prüfung erfolgreich ist, wird die gratis Transaktion weiterbearbeitet. Anschliessend wird das Verhalten des Accounts evaluiert. Wird hier
eine Gefahr detektiert, wird der Account von der Whitelist gelöscht und die
Transaktion abgebrochen.\
Ist der Account berechtigt und wird keine Gefahr detektiert, wird die
Transaktion im Data Feld einer neuen gratis Transaktion an die Blockchain
übermittelt.\
Beim Node muss wiederum verifiziert werden, dass sich der Sender auf der
Whitelist befindet. Da nur der Account des Transaktionsmanagers auf der
Whitelist von Parity ist, ist sichergestellt, dass gratis Transaktionen nur
durch den Transaktionsmanager auf die Blockchain gelangen können.\
Anschliessend gelangt die neu generierte Transaktion zur Smart Wallet des
Benutzers. Die ursprüngliche Transaktion wird aus dem Data Feld extrahiert und
ausgeführt. 



