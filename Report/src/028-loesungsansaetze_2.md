## Lösungsansätze 

//TODO Spellcheck über ganze Seite
//Benutzer != Account --> Auf der Whitelist sind Accounts !

In diesem Kapitel werden die erarbeiteten Lösungsansätze vorgestellt. Die Stärken und Schwächen von jedem Lösungsansatz werden analysiert und dokumentiert. Mit der vorgenommenen Analyse wird ein Favorit bestimmt. Dieser wird weiterverfolgt und implementiert.   

### Lösungsansatz 1: Smart Wallet

Es wird selbst eine Smart Wallet entwickelt. Diese benötigt die volle Funktionalität einer herkömlichen Wallet. Zusätzlich ist ein Schutzmechanismus gegen DoS Attacken implementiert. Wie in Grafik \ref{img_loesungsansatz1} ersichtlich, wird für jeden Benutzer eine Smart Wallet deployed. Dies wird von der FHNW übernommen. So fallen für die Benutzer keine Transaktionsgebühren an.
Wie unter \ref{sec_whitelist} beschrieben, wird für die Betreibung der Blockchain der Client Parity mit einer Withelist verwendet. 

![Lösungsansatz1 \label{img_solution1}](images/Lösungsansatz1.png "Lösungsansatz1") 

//TODO klären: Bezahlte Transaktionen dürfen überall hin, müssen nicht über wallet (Behauptung Jurij)

Es muss sichergestellt werden, dass ein Benutzer auf seine Smart Wallet zugreifen kann, unabhängig davon ob er gratis Transaktionen tätigen darf oder nicht. Dies ist in der Grafik \ref{img_solution1} dargestellt. 

Wie in \ref{sec_whitelist} beschrieben, prüft Parity bei einer gratis Transaktion nur, ob sich der Account in der Whitelist befindet. Das bedeuted, dass mit einem whitelisted Account auch gratis Transaktionen getätigt werden können, die nicht an die Smart Wallet gerichtet sind. Somit kann der Benutzer den DoS Schutzmechanismus umgehen. Deswegen muss ein Weg gefunden werden, der den Benutzer zwingt Transaktionen über die Smart Wallet abzuwickeln. 
Eine Möglichkeit ist Parity selbst zu erweitern. Anstelle einer Liste mit Accounts, muss eine Liste von Verbindungen geführt werden. So kann definiert werden, dass nur eine Transaktion auf die Smart Wallet gratis ist. 

#### Pro

//vlt als text ausformulieren? --> Bei allen PRO und CONTRAS

- Alles auf der Blockchain
- Dezentral
- Elegant
- Ein System

#### Contra

- Machbarkeit unsicher
- Komplex
- Parity muss angepasst werden
- Nach dem Anpassen vom Schutz Algorithmus in der Smart Wallet, muss eine neue Smart Wallet deployed werden. Die alte bleibt bestehen sofern die Blockchain nicht resetted wird


#### Prozessworkflow

![Flowchart Lösungsansatz 1 \label{img_flow_solution1}](images/FlowchartLösungsansatz1.png "Flowchart Lösungsansatz 1") 

In der Grafik \ref{img_flow_solution1} ist der Prozessablauf für eine gratis Transaktion dargestellt. 

### Lösungsansatz 2: Smart Wallet mit externen JavaProgramm nach Whitelist-Check

Bei diesem Lösungsansatz wird auf die Entwicklung einer Smart Wallet verzichtet. Stattdessen wird der Schutzmechnismus gegen DoS Attacken mit einem Javaprogramm implementiert. 

![Lösungsansatz 2 \label{img_solution2}](images/Lösungsansatz2.png "Lösungsansatz2") 

Wie in Grafik \ref{img_solution2} ersichtlich ist, wird für diesen Lösungsansatz der DoS Schutzalgorithmus in einem externen Java Programm implementiert. Es wird auch für diesen Lösungsansatz die Whitelist von Parity verwendet, siehe \ref{sec_whitelist}. 
Der externe Sicherheitsalgorithmus überwacht getätigte gratis Transaktionen. Falls ein Account die Sicherheitsrichtlinien verletzt, wird dieser vom Algorithmus aus der Whitelist gelöscht. 

#### Pro

- Sicher machbar
- Nach dem Anpassen vom Schutz Algorithmus in der Smart Wallet, muss keine neue Smart Wallet deployed werden, oder die Blockchain resetted werden.

#### Contra

- Mehrere Komponenten
- Zentrale Autorität

#### Prozessworkflow

//TODO Flowchart falsch.. gibt keine Smart wallet, Transaktion kommt immer durch Java wenn auf white list, da java nur passiv mithört


![Flowchart Lösungsansatz 2 \label{img_flow_solution2}](images/FlowchartLösungsansatz2.png "Flowchart Lösungsansatz 2") 

Auf dem Flowchart \ref{img_flow_solution2} dargestellt ist, kann ein Benutzer mit einem whitelisted Account direkt gratis Transaktionen ausführen. 

### Lösungsansatz 3: Smart Wallet mit externen JavaProgramm vor Whitelist-Check

Wie in Grafik \rev{img_solution3} ilustriert, ist der Blockchain ein Javaprogramm vorgelagert. Das Programm verwaltet eine Liste von Accounts. Diese sind für gratis Transaktionen berechtigt. Weiter beinhaltet es den  DoS Schutzalgorithmus. Dieser prüft ob der Account auf der Whitelist ist und ob die Transaktion die Schutzrichtlinien verletzt. Falls der Benutzer die Sicherheitsrichtlinien verletzt, wird sein Account vom Algorithmus aus der Whitelist gelöscht.
Sofern keine Richtlinien verletzt werden, wird die Transaktion ins Data-Feld, siehe \ref{sec_transaktionen}, einer neuen Transaktion gepackt. Das ist nötig, um die Transaktionsinformationen (wie z.B. Sender Identität) zu präservieren. Die neue erstellte Transaktion wird vom Javaprogramm an die Smart Wallet gesendet.  

![Lösungsansatz 3 \label{img_solution3}](images/Lösungsansatz3_V2.png "Lösungsansatz3") 

Weiter wird eine Smart Wallet entwickelt. Diese ist nötig, um die verschachtelten Transaktionen des Javaprogramms zu verarbeiten. Aus dem Data-Feld wird die eigentliche Transaktion extrahiert und abgesetzt.  
Jeder Benutzer besitzt eine eigene Smart Wallet um die Sender Identität für jeden Benutzer einmalig zu halten.
Auf der im Abschnitt \ref{sec_whitelist} beschriebenen Whitelist ist nur der Account des Javaprogrammes aufgelistet. So ist sichergestellt, dass nur Transaktionen die vom Java Programm weitergeleitet werden, kostenfrei durchgeführt werden können. Der Benutzer kann immer mit kostenpflichtigen Transaktionen auf die Smart Wallet zugreifen.


#### Pro
- Nach dem Anpassen vom Schutz Algorithmus in der Smart Wallet, muss keine neue Smart Wallet deployed werden.
- DOS Algorithmus blockt bevor Transaktion auf SmartWallet trifft
- Problem dass gratis Transaktionen nicht über die Smart Wallet geschickt werden, ist hier gelöst

#### Contra

- Mehrere Systeme
- Zentrale Autorität

#### Prozessworkflow

![Flowchart Lösungsansatz 3 \label{img_FlowchartLösungsansatz3}](images/FlowchartLösungsansatz3.png "Flowchart Lösungsansatz 3") 

### Lösungsansatz 4: Super Smart Wallet

![Lösungsansatz 4 \label{img_Lösungsansatz4}](images/Lösungsansatz4.png "Lösungsansatz4") 

#### Hauptlösungsansätze

Dieser Lösungsansatz war der erste konzipierte Lösungsansatz.
Es wird eine komplett eigene Smart Wallet erstellt, die sowohl die Whitelist wie auch den Schutzalgorithmus verwaltet.
Alle Benutzer erhalten eine zentrale Smart Wallet die von den Admins deployt wird.
Auf einer Whitelist sind alle Benutzer aufgelistet die berechtigt sind gratis Transaktionen durchzuführen. Der Benutzer wirdvon den Admins zu Beginn in diese Liste  hinzugefügt. Der Sicherheitsalgorithmus prüft ob der Benutzer die Gratistransaktions Richtlinien verletzt. Falls der Benutzer die Sicherheitsrichtlinien verletzt, wird er vom Algorithmus aus der Whitelist gelöscht. Der Benutzer gelangt nur wieder in die Whitelist, wenn ein Admin ihn hinzufügt. Es muss geprüft werden ob die Benutzer automatisiert wieder in die Liste hinzugefügt werden können.

#### Pro

- Nur eine Smart Wallet muss deployed und betrieben werden 
- Weniger administrativer Aufwand für Admins

#### Contra

-Schwierig Sender ID für Transaktion zu setzten (überhaupt möglich?)

## Evaluation der Lösungsansätze
Folgende Evaluationskriterien wurden bestummen

- Sichere Machbarkeit (hohe Priorität)
- Tiefe Komplexität (hohe Priorität)
- Komplexität bei Anpassungen (mittlere Priorität)
- Tiefer Waste bei Anpassungen (mittlere Priorität)
- Alles On Chain (tiefe Priorität)
- Wenig administrativer Aufwand (tiefe Priorität)
- Elegantheit der Lösung (tiefe Priorität)
- Normale Transaktion ( ?? Prio)
- Security ( ?? Prio )
//TODO Prioritäten besprechen

| |Sichere Machbarkeit | Tiefe Komplexität | Komplexität bei Anpassungen | Tiefer Waste bei Anpassungen | Alles On Chain | Wenig administrativer Aufwand | Elegantheit der Lösung | Normale Transaktion | Security | Total |
|------------:|:------|:--------|:------------|:----------|:----------|:------------|:------------|:-----------|:----------|-----:|
|Prio|3|3|2|2|1|1|1|?|2| |
| Lösungsansatz 1 | 2 | 1 | 0 | 0 | 2 | 1 | 2 | ? | ? | ? |
| Lösungsansatz 2 | 2 | 2 | 2 | 2 | 0 | 1 | 1 | ? | ? | ? |
| Lösungsansatz 3 | 2 | 1 | 2 | 2 | 0 | 1 | 0 | ? | ? | ? |
| Lösungsansatz 4 | 0 | 0 | 0 | 2 | 0 | 2 | 1 | ? | ? | ? |


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



