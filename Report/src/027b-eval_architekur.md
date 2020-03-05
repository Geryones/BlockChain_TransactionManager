### Evaluation der Architektur

Die erarbeiteten Lösungsansätze werden gegeneinander verglichen. Um zu bestimmen, welcher Ansatz weiter verfolgt wird, wurden folgende Kriterien definiert:

Machbarkeit (MK)
:     Bewertet die Machbarkeit des Ansatzes. Das berücksichtigt den gegeben Zeitrahmen und die Komplexität des Ansatzes. 
:     Da dieses Projekt im gegebenen Zeitrahmen abgeschlossen werden muss, ist es das wichtigste Kriterium. Daher wird es auch mit der höchsten Gewichtung versehen.  
:     Gewichtung 3

Blockchainprinzipien (BCP)
:     Gibt an ob die Prinzipien einer Blockchain berücksichtigt werden. Wie Dezentralität, Trust und Security  
:     Die Einhaltung der Prinzipien ist wichtig, aber für die FHNW nicht zwingend. Daher eine mittelere Gewichtung.     
:     Gewichtung 2

Betrieb (BT)
:     Bewertet den administrativen Aufwand im Betrieb und die Möglichkeit zur Automatisierung. Das umfasst Deployment Smart Contracts, Anpassungen der Whitelist und Betreibung von zusätzlichen Servern. 
:     Wird mit einer mittleren Gewichtung versehen. Ein zu hoher administrativer Aufwand ist nicht praktikabel.
:     Gewichtung 2

Jeder ALA wird auf diese drei Kriterien untersucht. Pro Kriterium können
zwischen 3 und 1 Punkt erreicht werden, wobei 3 das Maximum ist. Die erreichten
Punkte werden mit der entsprechenden Gewichtung multipliziert. Für die
Evaluation, werden alle Punkte zusammengezählt. Der Ansatz mit den meisten
Punkten wird weiterverfolgt.  

| |MK | BCP | BT | Total |
|:------------|:------:|:------:|:------:|-----:|
| Gewichtung      | 3 | 2 | 2 |    |
| ALA 1 | 1 | 3 | 2 | 13 |
| ALA 2 | 3 | 2 | 2 | 17 |
| ALA 3 | 2 | 1 | 3 | 12 |


Table: Evaluation Lösungsansätze \label{tab_evaluationloesungsansaetze}

#### ALA 1: Smart Wallet 

Wir haben diesen Ansatz als sehr komplex eingestuft. Für die Anpassung von
Parity muss eine zusätzliche Programmiersprache verwendet werden. Es ist nicht
klar, wie weitreichend die nötigen Anpassungen sind. Zusätzlich muss eine Smart
Wallet entwickelt werden. 

Dieser Ansatz ist komplett dezentral und in die Blockchain integriert. Daher
maximale Punktzahl bei Blockchain Prinzipien. 

Falls ein Anpassung am DoS Algorithmus nötig ist, muss jede Smart Wallet neu
deployed werden. Das bedingt, dass die Whitelist ebenfalls aktualisiert wird.
Die Adressen aller bestehenden Smart Wallets müssen ersetzt werden. Alle
Studierenden müssen informiert werden, dass sie für ihre Smart Wallet eine neue
Adresse verwenden müssen. Die Automatisierung dieser Prozesse wird als komplex
aber machbar eingeschätzt. Daher sind bei Betrieb 2 Punkte gesetzt. 

#### ALA 2: Externes Programm für die Verwaltung der Whitelist

Die Entwicklung eines externen Programmes, welches getätigte Transaktionen der
Blockchain prüft, ist in der gegebenen Zeit sicher realisierbar. Daher erhält
der ALA für Machbarkeit die volle Punktzahl. 

Mit der Verwendung von einem externen Programm, wird eine zentrale Authorität
verwendet. Diese ist nicht dezentral und wird von der FHNW administriert. Da das
Programm die Transaktionshistorie der Blockchain überwacht und nur bei einer DoS
Attacke aktiv ist, wird 2 Punkte für Blockchainprinzipien gegeben. 

Falls eine Anpassung am DoS Algorithus nötig ist, muss das externe Programm neu
deployed werden. Es benötigt keine Anpassungen an der Blockchain selbst. Für die
Verwaltung der Whitelist, braucht das Programm eine Funktion, um Accounts zur
Whitelist hinzuzufügen. Diese Funktion kann einfach erweitert werden, um eine
Liste von Accounts zur Whitelist hinzuzufügen. Dadurch ist das hinzufügen von
neuen Accounts für eine Klasse einfach automatisierbar.\
Für die Betreibung des externen Programms wird ein zusätzlicher Server benötigt.
Das bedeuted einen Mehraufwand für die FHNW.\
Da der ALA einfach zu Automatisieren ist, sind für Betrieb 2 Punkte gesetzt
worden. 

#### ALA 3: Externes Programm mit Whitelist

Bei diesem ALA muss eine Smart Wallet und ein externes Programm entwickelt
werden. Transaktionen werden im externen Programm verpackt und müssen von der
Smart Wallet wieder entpackt werden. Somit ist liegt die Machbarkeit zwischen
dem von ALA 1 und ALA 2. Daher werden 2 Punkte für Machbarkeit vergeben. 

Mit der Verwendung von einem externen Programm, wird eine zentrale Authorität
verwendet. Diese ist nicht dezentral und wird von der FHNW administriert. Im
Gegensatz zu ALA 2, hat dieses Programm eine sehr viel zentralere Rolle. Das
Programm interagiert nicht nur bei einer DoS Attacke mit der Blockchain, sondern
ständig. Jede Transaktion wird an das Programm übermittelt und dort verarbeitet.
Da die zentrale Authorität im Vergleich zu ALA 2 viel aktiver ist, ist für
Blockchainprinzipien 1 Punkt vergeben worden.

Für die Betreibung des externen Programms ist ein zusätzlicher Server nötig.\
Änderungen an der Smart Wallet bedingen ein erneutes Deployment.\
In der Whitelist der Blockchain ist nur der Account des externen Programmes
hinterlegt. Das Programm führt eine eigenen List von Accounts, die für gratis
Transaktionen berechtigt sind.\
Das externe Programm hat eine sehr zentrale Rolle, da es die Whitelist und den
DoS Schutzalgorithmus enthält. Die Automatisierung wird daher als einfach
eingestuft, da das externe Programm mit Java geschrieben wird und somit sehr
viel zugänglicher ist. Daher sind bei Betrieb 3 Punkte vergeben worden. 


#### Resultat Evaluation

Durch die hohe Gewichtung von Machbarkeit, erzielt ALA 2 die meisten Punkte. Im
weiteren Verlauf des Projektes wird daher ALA 2 umgesetzt.

Für die Realisierung des externen Programmes ist die Programmiersprache der Wahl
Java. Java ist den Teammitgliedern bereits bekannt. Mit der Bibliothek Web3j[@web3j]
sind Interaktionen mit der Blockchain effizient und intuitiv. 

Im Anhang ist unter \ref{app_weitereLoesungen} ein weiterer Lösungsanatz
aufgelistet. Dieser ist sehr früh in der Evaluierung als nicht realisierbar
eingestuft worden und ist hier deshalb nicht aufgeführt.

