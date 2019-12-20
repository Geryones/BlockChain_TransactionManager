## Lösungsansätze 

//TODO Spellcheck über ganze Seite

//TODO Erläuterungen zu Flow Charts

In diesem Kapitel werden die erarbeiteten Lösungsansätze vorgestellt. Die Stärken und Schwächen von jedem Lösungsansatz werden analysiert und dokumentiert. Mit der vorgenommenen Analyse wird ein Favorit bestimmt. Dieser wird weiterverfolgt und implementiert.   

### Lösungsansatz 1: Smart Wallet \label{sec_solution1}

Es wird selbst eine Smart Wallet entwickelt. Diese benötigt die volle Funktionalität einer herkömlichen Wallet. Zusätzlich ist ein Schutzmechanismus gegen DoS Attacken implementiert. Wie in Abbildung \ref{img_loesungsansatz1} ersichtlich, wird für jeden Benutzer eine Smart Wallet deployed. Dies wird von der FHNW übernommen. So fallen für die Benutzer keine Transaktionsgebühren an.
Wie unter \ref{sec_whitelist} beschrieben, wird für die Betreibung der Blockchain der Client Parity mit einer Withelist verwendet. 

![Lösungsansatz1 \label{img_solution1}](images/solution1.png "Lösungsansatz1") 


Es muss sichergestellt werden, dass ein Benutzer auf seine Smart Wallet zugreifen kann, unabhängig davon ob er gratis Transaktionen tätigen darf oder nicht. Dies ist in der Abbildung \ref{img_solution1} dargestellt. 

Wie in \ref{sec_whitelist} beschrieben, prüft Parity bei einer gratis Transaktion nur, ob sich der Account in der Whitelist befindet. Das bedeuted, dass mit einem whitelisted Account auch gratis Transaktionen getätigt werden können, die nicht an die Smart Wallet gerichtet sind. Somit kann der Benutzer den DoS Schutzmechanismus umgehen. Deswegen muss ein Weg gefunden werden, der den Benutzer zwingt Transaktionen über die Smart Wallet abzuwickeln. 
Eine Möglichkeit ist Parity selbst zu erweitern. Anstelle einer Liste mit Accounts, muss eine Liste von Verbindungen geführt werden. So kann definiert werden, dass nur eine Transaktion auf die Smart Wallet gratis ist. 

#### Pro

Dieser Ansatz besticht durch die Tatsache, dass alles auf der Blockchain läuft. Somit werden grundlegende Prinzipien, wie Dezentralität und Integrität, einer Blockchain bewahrt. 

#### Contra

Die Machbarkeit des Ansatzes ist unklar. Um diesen Ansatz umzusetzten, muss der Blockchain Client, Parity, erweitert werden. Es ist unklar, wie weitreichend die Anpassungen an Parity sind. Zusätzlich wird eine zusätzliche Programmiersprache, Rust[@rust], benötigt. 
Ein weiterer Nachteil ist, dass bei einer Änderung am DoS Schutzalgorithmus eine neue Smart Wallet für jeden Account deployed werden muss. Das bedingt, dass die Whitelist ebenfalls mit den neuen Accounts aktualisiert wird. 

#### Prozessworkflow

![Flowchart Lösungsansatz 1 \label{img_flow_solution1}](images/flow_solution1.png "Flowchart Lösungsansatz 1") 

In der Abbildung \ref{img_flow_solution1} ist der Prozessablauf für eine gratis Transaktion dargestellt. 

//TODO weitere Erläuterung?

### Lösungsansatz 2: Smart Wallet mit externen Programm nach Whitelist-Check

Bei diesem Ansatz wird auf die Entwicklung einer Smart Wallet verzichtet. Stattdessen wird der Schutzmechnismus gegen DoS Attacken mit einem externen Programm implementiert, dargestellt in Abbildung \ref{img_solution2}. 

![Lösungsansatz 2 \label{img_solution2}](images/solution2.png "Lösungsansatz2") 

Es wird auch für diesen Ansatz die Whitelist von Parity verwendet, siehe \ref{sec_whitelist}. 
Im externen Programm werden alle gratis Transaktionen analysiert, die das Blockchain Netzwerk erreichen. Das Programm verfügt über einen eigenen Benutzer Account, siehe \ref{sec_account}. Dieser ist berechtigt, die Whitelist zu manipulieren. Dadurch kann bei einer identifizierten Attacke, der angreifende Account automatisch von der Whitelist gelöscht werden. 

Transaktionen für die ein Transaktionsgebühren gezahlt werden sind immer möglich. Diese werden vom externen Programm auch nicht überwacht. Die anfallenden Gebühren sind Schutz genug. 

#### Pro

Dieser Ansatz ist sicher umsetzbar in der zur Verfügung stehenden Zeit. 
Falls eine Anpassung des DoS Schutzalgorithmus nötig ist, muss nur das externe Programm neu deployed werden. Eine aktualisierung der Whitelist ist nicht nötig. 

#### Contra

Es wird das Hauptprinzip, Dezentralität, einer Blockchain verletzt. Das externe Programm ist eine zentrale Authorität, die von der FHNW kontrolliert wird. 
Durch das externen Programm kommt eine weitere Komponente dazu. Diese muss ebenfalls administriert werden.  

#### Prozessworkflow

//TODO Flowchart falsch.. gibt keine Smart wallet, Transaktion kommt immer durch Java wenn auf white list, da java nur passiv mithört


![Flowchart Lösungsansatz 2 \label{img_flow_solution2}](images/flow_solution2.png "Flowchart Lösungsansatz 2") 

Auf dem Flowchart \ref{img_flow_solution2} dargestellt ist, kann ein Benutzer mit einem whitelisted Account direkt gratis Transaktionen ausführen. 

### Lösungsansatz 3: Smart Wallet mit externen Programm vor Whitelist-Check

Wie in Abbildung \ref{img_solution3} illustriert, ist der Blockchain ein externes Programm vorgelagert. Das Programm verwaltet eine eigene Whitelist mit Accounts. Diese sind für gratis Transaktionen berechtigt. Weiter beinhaltet es den  DoS Schutzalgorithmus. Dieser prüft ob der Account auf der Whitelist ist und ob die Transaktion die Schutzrichtlinien verletzt. Falls ein Account die Sicherheitsrichtlinien verletzt, wird dieser vom Algorithmus aus der eigenen Whitelist gelöscht.

Sofern keine Richtlinien verletzt werden, wird die Transaktion ins Data-Feld, siehe \ref{sec_transaktionen}, einer neuen Transaktion gepackt. Das ist nötig, um die Transaktionsinformationen (wie z.B. Sender Identität) zu präservieren. Die neue erstellte Transaktion wird vom Programm an die Smart Wallet gesendet.  

![Lösungsansatz 3 \label{img_solution3}](images/solution3_v2.png "Lösungsansatz3") 

Weiter wird eine Smart Wallet entwickelt. Diese ist nötig, um die verschachtelten Transaktionen des Programms zu verarbeiten. Aus dem Data-Feld wird die eigentliche Transaktion extrahiert und abgesetzt.  
Jeder Benutzer besitzt eine eigene Smart Wallet um die Sender Identität für jeden Benutzer einmalig zu halten.
Auf der im Abschnitt \ref{sec_whitelist} beschriebenen Whitelist ist nur der Account des externen Programmes aufgelistet. So ist sichergestellt, dass nur Transaktionen die vom Programm weitergeleitet werden, kostenfrei durchgeführt werden können. Der Benutzer kann immer mit kostenpflichtigen Transaktionen auf die Smart Wallet zugreifen. Dies ist insbesindere wichtig, falls das Programm nicht aufrufbar ist, wenn z.B. der Server ausfällt.


#### Pro

Dieser Ansatz ist in der gegeben Zeit umsetzbar.
Falls eine Anpassung des DoS Schutzalgorithmus nötig ist, muss nur das externe Programm neu deployed werden. Eine aktualisierung der Whitelist ist nicht nötig.  

#### Contra

Es wird das Hauptprinzip, Dezentralität, einer Blockchain verletzt. Das externe Programm ist eine zentrale Authorität, die von der FHNW kontrolliert wird. 
Durch das externen Programm kommt eine weitere Komponente dazu. Diese muss ebenfalls administriert werden. 
Dieser Ansatz bietet keine Vorteile im Vergleich zum Lösungsansatz 2, ist aber mit der Verschachtelung von Transaktionen komplexer. 

#### Prozessworkflow

//Todo flowchart falsch, zuerst Java dann richtige smart wallet

![Flowchart Lösungsansatz 3 \label{img_flow_solution3}](images/flow_solution3.png "Flowchart Lösungsansatz 3") 

Die Abbildung \ref{img_flow_solution3} zeigt, dass alle gratis Transaktionen in erster Instanz von einem Programm geprüft werden. Falls keine Richtlinien verletzt werden, wird die Transaktion im Data-Feld einer neu generierten Transaktion an die Smart Wallet übermittelt. 

### Lösungsansatz 4: Super Smart Wallet

Es wird eine zentrale Smart Wallet entwickelt. Im Gegensatz zu Lösungsansatz 1, \ref{sec_solution1}, wird nicht für jeden Benutzer eine Smart Wallet deployed, sondern nur eine einzige. Diese kann von allen Benutzern der Blockchain genutzt werden.
Bei diesem Ansatz wird mit der in Absatz \ref{sec_whitelist} beschriebenen Whitelist gearbeitet.

![Lösungsansatz 4 \label{img_solution4}](images/solution4.png "Lösungsansatz4") 

Die Smart Wallet verwaltet die Whitelist und den Schutzmechanismus gegen DoS Attacken. Das ist auf Abbildung \ref{img_solution4} ersichtlich. Wird eine DoS Attacke identifiziert, wir der entsprechende Account aus der Whitelist gelöscht.  

#### Pro

Es existiert nur eine einzige Smart Wallet. Das Deployment ist somit weniger aufwändig. 
Falls eine Änderung am Code gemacht nötig ist, muss nur eine Smart Wallet neu deployed werden. 

#### Contra

Bei diesem Ansatz ist die Machbarkeit unklar. 
Parity muss umgeschrieben werden, da nicht die Senderidentität der Smart Wallet genutzt werden muss, sondern die des Benutzeraccounts. 
Ebenfalls muss die Whitelist-Funktionalität von Parity angepasst werden, analog zu Lösungsansatz 1. 
 

## Evaluation der Lösungsansätze

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

Jeder Lösungsansatz wird auf diese drei Kriterien untersucht. Pro Kriterium können zwischen 3 und 1 Punkt erreicht werden, wobei 3 das Maximum ist. Die erreichten Punkte werden mit der entsprechenden Gewichtung multipliziert. Für die Evaluation, werden alle Punkte zusammengezählt. Der Ansatz mit den meisten Punkten wird weiterverfolgt.  

| |MK | BCP | BT | Total |
|:------------|:------:|:------:|:------:|-----:|
| Gewichtung      | 3 | 2 | 2 |    |
| Lösungsansatz 1 | 1 | 3 | 2 | 13 |
| Lösungsansatz 2 | 3 | 2 | 2 | 17 |
| Lösungsansatz 3 | 2 | 1 | 3 | 12 |
| Lösungsansatz 4 | 0 | 2 | 2 |  8 |

Table: Evaluation Lösungsansätze \label{tab_evaluationloesungsansaetze}

### Lösungsansatz 1:  Smart Wallet 

Wir haben diesen Ansatz als sehr komplex eingestuft. Für die Anpassung von Parity muss eine zusätzliche Programmiersprache verwendet werden. Es ist nicht klar, wie weitreichend die nötigen Anpassungen sind. Zusätzlich muss eine Smart Wallet entwickelt werden. 

Dieser Ansatz ist völlig dezentral und in der Blockchain integriert. Daher maximale Punktzahl bei Blockchain Prinzipien. 

Falls ein Anpassung am DoS Algorithmus nötig ist, muss jede Smart Wallet neu deployed werden. Das bedingt, dass die Whitelist ebenfalls aktualisiert werden muss. Die Adressen aller bestehenden Smart Wallets müssen ersetzt werden. Alle Studierenden müssen informiert werden, dass sie für ihre Smart Wallet eine neue Adresse verwenden müssen. Die Automatisierung dieser Prozesse wird als komplex aber machbar eingeschätzt. Daher sind bei Betrieb 2 Punkte gesetzt. 

### Lösungsansatz 2: Smart Wallet mit externen Programm nach Whitelist-Check



### Lösungsansatz 3: Smart Wallet mit externen Programm vor Whitelist-Check



### Lösungsansatz 4: Super Smart Wallet



### Resultat Evaluation





