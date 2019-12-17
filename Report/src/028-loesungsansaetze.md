## Lösungsansätze 

//TODO Spellcheck über ganze Seite

//TODO Erläuterungen zu Flow Charts

In diesem Kapitel werden die erarbeiteten Lösungsansätze vorgestellt. Die Stärken und Schwächen von jedem Lösungsansatz werden analysiert und dokumentiert. Mit der vorgenommenen Analyse wird ein Favorit bestimmt. Dieser wird weiterverfolgt und implementiert.   

### Lösungsansatz 1: Smart Wallet \label{sec_solution1}

Es wird selbst eine Smart Wallet entwickelt. Diese benötigt die volle Funktionalität einer herkömlichen Wallet. Zusätzlich ist ein Schutzmechanismus gegen DoS Attacken implementiert. Wie in Abbildung \ref{img_loesungsansatz1} ersichtlich, wird für jeden Benutzer eine Smart Wallet deployed. Dies wird von der FHNW übernommen. So fallen für die Benutzer keine Transaktionsgebühren an.
Wie unter \ref{sec_whitelist} beschrieben, wird für die Betreibung der Blockchain der Client Parity mit einer Withelist verwendet. 

![Lösungsansatz1 \label{img_solution1}](images/Lösungsansatz1.png "Lösungsansatz1") 


Es muss sichergestellt werden, dass ein Benutzer auf seine Smart Wallet zugreifen kann, unabhängig davon ob er gratis Transaktionen tätigen darf oder nicht. Dies ist in der Abbildung \ref{img_solution1} dargestellt. 

Wie in \ref{sec_whitelist} beschrieben, prüft Parity bei einer gratis Transaktion nur, ob sich der Account in der Whitelist befindet. Das bedeuted, dass mit einem whitelisted Account auch gratis Transaktionen getätigt werden können, die nicht an die Smart Wallet gerichtet sind. Somit kann der Benutzer den DoS Schutzmechanismus umgehen. Deswegen muss ein Weg gefunden werden, der den Benutzer zwingt Transaktionen über die Smart Wallet abzuwickeln. 
Eine Möglichkeit ist Parity selbst zu erweitern. Anstelle einer Liste mit Accounts, muss eine Liste von Verbindungen geführt werden. So kann definiert werden, dass nur eine Transaktion auf die Smart Wallet gratis ist. 

#### Pro

//TODO mehr Text

Der Vorteil des Lösungsansatzes 1 ist, dass die ganze Lösung auf der Blockchain läuft und somit dezentral ist. Diese Lösung ist die eleganteste Lösung, da sie die Prinzipien einer Blockchain einhält.

#### Contra

Ein grosses Nachteil des Lösungsansatzes 1 ist, dass es unklar ist, ob er machbar ist. Um diesen Lösungsansatz umzusetzten, muss der Blockchain Client, Parity, erweitert werden, um die Accounts zu zwingen über die Smart Wallet Transaktionen zu verschicken. Diese Erweiterungen müssen in einer weiteren Sprache entwickelt werden. Diese Änderungen macht den Lösungsansatz sehr komplex. Ein weiterer Nachteil ist, dass bei einer Änderung am DoS Schutzalgorithmus eine neue Smart Wallet für jeden Account deployed werden muss. Des weiteren bleibt die alte Smart Wallet bestehen, ausser die Blockchain wird resetted.

//Punkt: Sender IDs auf Whiteliszt muss für jeden Account in Whitelist angepasst werden nach neuem Smart Contract Deployement

#### Prozessworkflow

![Flowchart Lösungsansatz 1 \label{img_flow_solution1}](images/FlowchartLösungsansatz1.png "Flowchart Lösungsansatz 1") 

In der Abbildung \ref{img_flow_solution1} ist der Prozessablauf für eine gratis Transaktion dargestellt. 

//TODO weitere Erläuterung?

### Lösungsansatz 2: Smart Wallet mit externen JavaProgramm nach Whitelist-Check

Bei diesem Lösungsansatz wird auf die Entwicklung einer Smart Wallet verzichtet. Stattdessen wird der Schutzmechnismus gegen DoS Attacken mit einem Javaprogramm implementiert. 

![Lösungsansatz 2 \label{img_solution2}](images/Lösungsansatz2.png "Lösungsansatz2") 

Wie in Abbildung \ref{img_solution2} ersichtlich ist, wird für diesen Lösungsansatz der DoS Schutzalgorithmus in einem externen Java Programm implementiert. Es wird auch für diesen Lösungsansatz die Whitelist von Parity verwendet, siehe \ref{sec_whitelist}. 
Der externe Sicherheitsalgorithmus überwacht getätigte gratis Transaktionen. Falls ein Account die Sicherheitsrichtlinien verletzt, wird dieser vom Algorithmus aus der Whitelist gelöscht. 

#### Pro

Ein klarer Vorteil des Lösungsansatzes 2 ist, dass er sicher umsetzbar ist. Die Eleganz dieser Lösung besteht darin, dass bei einer Änderung des DoS Schutzalgorithmus nur das Java Programm neu deployed werden muss. Dies ist ein einmaliges Deployement und die Blockchain muss nicht resetted werden, um den alten Code zu entfernen.

#### Contra

Ein grosser Nachteil dieses Lösungsansatzes ist, dass durch die zentrale Autorität die Prinzipen der Blockchain verletzt werden. Somit wäre die Lösung nicht sehr elegant. Ein weiterer Nachteil ist, dass durch das Java Programm ein Server als Komponente hinzukommen würde und somit nicht alles auf einer Komponente läuft. Dies bringt weiteren administrativen Aufwand.

#### Prozessworkflow

//TODO Flowchart falsch.. gibt keine Smart wallet, Transaktion kommt immer durch Java wenn auf white list, da java nur passiv mithört


![Flowchart Lösungsansatz 2 \label{img_flow_solution2}](images/FlowchartLösungsansatz2.png "Flowchart Lösungsansatz 2") 

Auf dem Flowchart \ref{img_flow_solution2} dargestellt ist, kann ein Benutzer mit einem whitelisted Account direkt gratis Transaktionen ausführen. 

### Lösungsansatz 3: Smart Wallet mit externen JavaProgramm vor Whitelist-Check

Wie in Abbildung \ref{img_solution3} illustriert, ist der Blockchain ein Javaprogramm vorgelagert. Das Programm verwaltet eine eigene Whitelist mit Accounts. Diese sind für gratis Transaktionen berechtigt. Weiter beinhaltet es den  DoS Schutzalgorithmus. Dieser prüft ob der Account auf der Whitelist ist und ob die Transaktion die Schutzrichtlinien verletzt. Falls der Benutzer die Sicherheitsrichtlinien verletzt, wird sein Account vom Algorithmus aus der eigenen Whitelist gelöscht.
//TODO Benutzer oder Transaktion verletzt die Schutzrichtlinien?

Sofern keine Richtlinien verletzt werden, wird die Transaktion ins Data-Feld, siehe \ref{sec_transaktionen}, einer neuen Transaktion gepackt. Das ist nötig, um die Transaktionsinformationen (wie z.B. Sender Identität) zu präservieren. Die neue erstellte Transaktion wird vom Javaprogramm an die Smart Wallet gesendet.  

![Lösungsansatz 3 \label{img_solution3}](images/Lösungsansatz3_V2.png "Lösungsansatz3") 

Weiter wird eine Smart Wallet entwickelt. Diese ist nötig, um die verschachtelten Transaktionen des Javaprogramms zu verarbeiten. Aus dem Data-Feld wird die eigentliche Transaktion extrahiert und abgesetzt.  
Jeder Benutzer besitzt eine eigene Smart Wallet um die Sender Identität für jeden Benutzer einmalig zu halten.
Auf der im Abschnitt \ref{sec_whitelist} beschriebenen Whitelist ist nur der Account des Javaprogrammes aufgelistet. So ist sichergestellt, dass nur Transaktionen die vom Java Programm weitergeleitet werden, kostenfrei durchgeführt werden können. Der Benutzer kann immer mit kostenpflichtigen Transaktionen auf die Smart Wallet zugreifen. Dies ist insbesindere wichtig, falls das Java Programm nicht aufrufbar ist, wenn z.B. der Server ausfällt.


#### Pro

//TODO kürzere Sätze

Ein grosser Vorteil dieses Lösungsansatzes ist, dass alle gratis Transaktionen vom DoS Schutzalgorithmus geprüft werden, da sie alle über das Javaprogramm laufen müssen, weil dort die Whitelist der Accounts geführt wird. Ein weiterer grosser Vorteil ist, dass der DoS Schutzalgorithmus im Javaprogramm geändert werden kann und nur einmalig deployed werden muss und der alte nicht auf der Blockchain bestehen bleibt. Somit muss bei Änderungen die Blockchain nicht resetted werden. Das Besondere bei dieser Lösung ist, dass der DoS Schutzalgorithmus die unerwünschten Transaktionen blockt bevor sie auf die Blockchain treffen.

#### Contra

Durch die zentrale Autorität werden bei diesem Lösungsansatz die Prinzipien der Blockchain verletzt. Ein weiterer Nachteil sind die weitere Komponente die durch das Java Programm und dessen zusätzlichen Server anfallen.
 //TODO mehr Text

#### Prozessworkflow

//Todo flowchart falsch, zuerst Java dann richtige smart wallet

![Flowchart Lösungsansatz 3 \label{img_flow_solution3}](images/FlowchartLösungsansatz3.png "Flowchart Lösungsansatz 3") 

Die Abbildung \ref{img_flow_solution3} zeigt, dass alle gratis Transaktionen in erster Instanz von einem Javaprogramm geprüft werden. Falls keine Richtlinien verletzt werden, wird die Transaktion im Data-Feld einer neu generierten Transaktion an die Smart Wallet übermittelt. 

### Lösungsansatz 4: Super Smart Wallet

Es wird eine zentrale Smart Wallet entwickelt. Im Gegensatz zu Lösungsansatz 1, \ref{sec_solution1}, wird nicht für jeden Benutzer eine Smart Wallet deployed, sondern nur eine einzige. Diese kann von allen Benutzern der Blockchain genutzt werden.
Bei diesem Ansatz wird mit der in Absatz \ref{sec_whitelist} beschriebenen Whitelist gearbeitet.

![Lösungsansatz 4 \label{img_solution4}](images/Lösungsansatz4.png "Lösungsansatz4") 

Die Smart Wallet verwaltet die Whitelist und den Schutzmechanismus gegen DoS Attacken. Das ist auf Abbildung \ref{img_solution4} ersichtlich.

//TODO nicht die Smart Wallet, sondern die Blockchain verwaltet die Whitelist?

#### Pro

Vorteil dieses Lösungsansatzes ist, dass nur eine Smart Wallet deployed werden muss und nicht für jeden Benutzer einzeln eine zur Verfügung gestellt werden muss. Dies bringt weniger administrativer Aufwand.

//TODO Text oder Auflistung

- Nur eine Smart Wallet muss deployed und betrieben werden 
- Weniger administrativer Aufwand für Administratoren

#### Contra

Bei diesem Lösungsansatz ist nicht klar, ob er umsetzbar ist. Die Blockchain muss umgeschrieben werden, da nicht die Senderidentität der Smart Wallet genutzt würde, sondern die des Accounts. Des weiteren ist es bei dieser Lösung möglich, gratis Transaktionen nicht über die Smart Wallet zu schicken und somit den DoS Schutzalgorithmus zu umgehen.

//TODO auflistung oder Text

-Schwierig Sender ID für Transaktion zu setzten (überhaupt möglich?)

## Evaluation der Lösungsansätze

Um einen Lösungsansatz auszuwählen, haben wir folgende Kriterien definiert:

Komplexität (KP)
:     Dieses Kriterium gibt an, wie Komplex die Umsetzung des Lösungsansatzes ist. 
:     Gewichtung 3
// TODO weiter ausführen


Blockchainprinzipien (BCP)
:     Hier wird bewertet, ob die Prinzipien einer Blockchain berücksichtigt werden. Wie Dezentralität, alles "on-Chain" etc 
:     Gewichtung 2
// TODO weiter ausführen


Administrativer Aufwand (AA)
:     Mit diesem Punkt wird der administrative Aufwand für die Betreibung des Lösungsansatzes bewertet. (Deployment Smart Contracts, Anpassung Whitelist, Server Betrieb)
:     Gewichtung 2
//TODO weiter ausführen


Security (SEC)
:     Wie sicher ist der Lösungsansatz? Welche Bedenken bestehen
:     Gewichtung 1
//TODO Weiter ausführen / definieren

//TODO TEXT Erklären, dass Gewichtung 1-3 ist. 3 ist höchste
//TODO bei allen Kriterien noch die Gewichtung + Erklärung 


| |KP | BCP | AA | SEC | Total |
|:------------|:------:|:--------:|:------------:|:----------:|-----:|
| Gewichtung | 3 | 2 | 2 | 1 | |
| Lösungsansatz 1 | 1 | 3 | 1 | | 11 |
| Lösungsansatz 2 | 3 | 2 | 2 | | 17 |
| Lösungsansatz 3 | 2 | 1 | 3 | | 12 |
| Lösungsansatz 4 | 0 | 2 | 2 | | 8 |


Table: Evaluation Lösungsansätze \label{tab_evaluationloesungsansaetze}

### Lösungsansatz 1:  Smart Wallet 

 //TODO nach Prio nochmals umschreiben
Der Lösungsansatz 1 ist die eleganteste Lösung, jedoch laut Evaluation die zweit beste, zusammen mit dem Lösungsansatz 3. Da diese Lösung kein Java Programm wie Lösungsansatz 2 und 3 vorsieht ist sie prioritär zu Lösungsansatz 3. Falls die Kapazitäten ausreichen, wird sie somit auch implementiert. 

### Lösungsansatz 2: Smart Wallet mit externen JavaProgramm nach Whitelist-Check

Ergebnis der Evaluation zeigt, dass diese Lösung die beste nach den Kriterien ist. Deswegen wird diese Lösung als erstes implementiert.

### Lösungsansatz 3: Smart Wallet mit externen JavaProgramm vor Whitelist-Check

Laut Evaluation ist dieser Lösungsansatz auf dem zweiten Platz, zusammen mit Lösungsansatz 1. Da diese Lösung auch ein Javaprogramm wie Lösung 2 vorsieht, wird sie weniger prioritär wie Lösungsansatz 1 betrachtet.

### Lösungsansatz 4: Super Smart Wallet

Dieser Lösungsansatz ist laut Evaluation auf dem letzten Platz. Dies war von Anfang an klar. Dieser Ansatz wurde jedoch aufgezeigt, da er das erste Lösungskonzept war.

### Resultat Evaluation

//Text



