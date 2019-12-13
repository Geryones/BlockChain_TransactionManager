## Lösungsansätze 

//TODO Spellcheck über ganze Seite

### Lösungsansatz 1: Smart Wallet

![Lösungsansatz1 \label{img_Lösungsansatz1}](images/Lösungsansatz1.png "Lösungsansatz1") 

#### Hauptlösungsansätze

Es wird eine komplett eigene Smart Wallet erstellt, die den DoS Schutzalgorithmus verwaltet. 
Jeder Benutzer erhält eine eigene Smart Wallet die von den Admins deployt wird, um für den Benutzer keine Anfangskosten für die Transaktion zu generieren.
Die Whitelist wird von der Blockchain (Parity) verwaltet.
Auf der Whitelist sind alle Benutzer aufgelistet die berechtigt sind gratis Transaktionen durchzuführen. Benutzer können in diese Liste von den Admins hinzugefügt werden. Gelöscht werden Sie nur von der Smart Wallet. 
Der Sicherheitsalgorithmus prüft ob der Benutzer die Gratistransaktions Richtlinien verletzt. Falls der Benutzer die Sicherheitsrichtlinien verletzt, wird er vom Algorithmus aus der Whitelist gelöscht. Der Benutzer gelangt nur wieder in die Whitelist, wenn ein Admin ihn hinzufügt. Es muss geprüft werden ob die Benutzer automatisiert wieder in die Liste hinzugefügt werden können.

Die bezahlten Transaktionen laufen auch über die SmartWallet, um mit der gleichen Sender Identität Transaktionen an das eigentliche Ziel zu verschicken.

Hier besteht das Problem, dass auch gratis Transaktionen geschickt werden können, ohne über die Smart Wallet zu gehen. Somit kann der Benutzer den DoS Schutzalgorithmus umgehen. Deswegen muss ein Weg gefunden werden, den den Benutzer zwingt über die Smart Wallet Transaktionen zu schicken (z.B. Whitelist wo Sender und Empfänger geführt wird).

#### Pro

- Alles auf der Blockchain
- Dezentral
- Elegant
- Ein System

#### Contra

- Machbarkeit unsicher
- Komplex
- Nach dem Anpassen vom Schutz Algorithmus in der Smart Wallet, muss eine neue Smart Wallet deployed werden. Die alte bleibt bestehen sofern die Blockchain nicht resetted wird


#### Prozessworkflow

![Flowchart Lösungsansatz 1 \label{img_FlowchartLösungsansatz1}](images/FlowchartLösungsansatz1.png "Flowchart Lösungsansatz 1") 

### Lösungsansatz 2: Smart Wallet mit externen JavaProgramm nach Whitelist-Check

![Lösungsansatz 2 \label{img_Lösungsansatz2}](images/Lösungsansatz2.png "Lösungsansatz2") 


#### Hauptlösungsansätze

Dies ist ein Lösungsansatz ohne Smart Wallet. Die Whitelist wird von der Blockchain (Parity) selber verwaltet. Der DoS Schutzalgorithmus wird in einem externen Java Programm durchgeführt. 
Auf einer Whitelist sind alle Benutzer aufgelistet die berechtigt sind gratis Transaktionen durchzuführen. Die Benutzer werden zu Beginn von den Admins in die Liste hinzugefügt. Gelöscht werden sie nur durch den Schutzalgorithmus.
Der externe Sicherheitsalgorithmus prüft nach dem Whitelist-Check ob der Benutzer die Gratistransaktion Richtlinien verletzt. Falls der Benutzer die Sicherheitsrichtlinien verletzt, wird der Benutzer vom Algorithmus aus der Whitelist gelöscht. Der Benutzer gelangt nur wieder in die Whitelist, wenn ein Admin ihn hinzufügt. Es muss geprüft werden ob die Benutzer automatisiert wieder in die Liste hinzugefügt werden können.

#### Pro

- Sicher machbar
- Nach dem Anpassen vom Schutz Algorithmus in der Smart Wallet, muss keine neue Smart Wallet deployed werden, oder die Blockchain resetted werden.

#### Contra

- Mehrere Komponenten
- Zentrale Autorität

#### Prozessworkflow

![Flowchart Lösungsansatz 2 \label{img_FlowchartLösungsansatz2}](images/FlowchartLösungsansatz2.png "Flowchart Lösungsansatz 2") 

### Lösungsansatz 3: Smart Wallet mit externen JavaProgramm vor Whitelist-Check

![Lösungsansatz 3 \label{img_Lösungsansatz3}](images/Lösungsansatz3_V2.png "Lösungsansatz3") 

#### Hauptlösungsansätze

Es wird ein Java Programm entwickelt, welches eine eigene Whitelist führt und den DoS Schutzalgorithmus beinhaltet. Dieser prüft ob der Benutzer auf der Whitelist ist und ob die Transaktion die Schutzrichtlinien nicht verletzt. Ist die Prüfung in Ordnung packt er die Transaktion in eine neue Transaktion ein, um die Transaktionsinformationen (wie z.B. Sender Identität) nicht zu verlieren und schickt die Transaktion an die Smart Wallet. Falls der Benutzer die Sicherheitsrichtlinien verletzt, wird er vom Algorithmus aus der Whitelist gelöscht. 
Jeder Benutzer besitzt eine eigene Smart Wallet um die Sender Identität für jeden Benutzer einmalig zu halten. Die Smart Wallet packt die Transaktion aus und schickt eine neue Transaktion mit den relevanten Informationen an das eigentliche Ziel.
Auf einer Whitelist der Blockchain ist nur das Javaprogram aufgelistet, so dass nur die Transaktionen die vom Java Programm weitergeleitet wurden, kostenfrei durchgeführt werden können. Die kostenpflichtigen Transaktionen werden vom Benutzer auch an die Smart Wallet geschickt.


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



