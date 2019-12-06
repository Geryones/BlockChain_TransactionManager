## Lösungsansätze 

//TODO Spellcheck über ganze Seite

### Lösungsansatz 1: Super Smart Wallet

//TODO Bild

![Lösungsansatz1 \label{img_Lösungsansatz1}](images/Lösungsansatz1.png "Lösungsansatz1") 

#### Hauptlösungsansätze

Es wird eine komplett eigene Smart Wallet erstellt, die sowohl die Whitelist wie auch den Schutzalgorithmus verwaltet.
Jeder Benutzer erhält eine eigene Smart Wallet die von den Admins deployt wird.
Auf einer Whitelist sind alle Benutzer aufgelistet die berechtigt sind gratis Transaktionen durchzuführen. Diese Liste wird von den Admins gepfleft. Der Sicherheitsalgorithmus prüft ob der Benutzer die Gratistransaktions Richtlinien verletzt. Falls der Benutzer die Sicherheitsrichtlinien verletzt, wird er vom Algorithmus aus der Whitelist gelöscht. Der Benutzer gelangt nur wieder in die Whitelist, wenn ein Admin ihn hinzufügt.

#### Pro

- Alles auf der Blockchain
- Dezentral
- Elegant
- Komplett eigene Lösung
- Ein System

#### Contra

- Machbarkeit unsicher
- Komplex
- Schutz Algorithmus kann nicht angepasst werden ohne Blockchain zu rebooten


#### Prozessworkflow

//TODO Bild


### Lösungsansatz 2: Smart Wallet mit externen JavaProgramm nach Whitelist-Check

//TODO Bild
![Lösungsansatz2 \label{img_Lösungsansatz2}](images/Lösungsansatz2.png "Lösungsansatz2") 


#### Hauptlösungsansätze

Es wird eine komplett eigenen Smart Wallet erstellt, die die Whitelist verwaltet. Zusätzlich wird ein Java Programm entwickelt, der den Schutzalgorithmus beinhaltet. 
Jeder Benutzer erhält eine eigene Smart Wallet die von den Admins deployt wird.
Auf einer Whitelist sind alle Benutzer aufgelistet die berechtigt sind gratis Transaktionen durchzuführen. Diese Liste wird von den Admins gepfleft.
Der externe Sicherheitsalgorithmus prüft nach dem Whitelist-Check ob der Benutzer die Gratistransaktion Richtlinien verletzt. Falls der Benutzer die Sicherheitsrichtlinien verletzt, wird er vom Algorithmus aus der Whitelist gelöscht. Der Benutzer gelangt nur wieder in die Whitelist, wenn ein Admin ihn hinzufügt.

#### Pro

- Sicher machbar
- Komplett eigene Lösung
- Algorithmus kann angepasst werden ohne Blockchain zu rebooten

#### Contra

- Mehrere Komponenten
- Zentrale Autorität

#### Prozessworkflow

//TODO Bild

### Lösungsansatz 3: Smart Wallet mit externen JavaProgramm vor Whitelist-Check

//TODO Bild
![Lösungsansatz3 \label{img_Lösungsansatz3}](images/Lösungsansatz3_V2.png "Lösungsansatz3") 

#### Hauptlösungsansätze

Es wird eine komplett eigenen Smart Wallet erstellt, die die Whitelist verwaltet. Zusätzlich wird ein Java Programm entwickelt, der den Schutzalgorithmus beinhaltet. 
Jeder Benutzer erhält eine eigene Smart Wallet die von den Admins deployt wird.
Auf einer Whitelist sind alle Benutzer aufgelistet die berechtigt sind gratis Transaktionen durchzuführen. Diese Liste wird von den Admins gepfleft.
Der externe Sicherheitsalgorithmus prüft vor dem Whitelist-Check ob der Benutzer die Gratistransaktion Richtlinien verletzt. Falls der Benutzer die Sicherheitsrichtlinien verletzt, wird er vom Algorithmus aus der Whitelist gelöscht. Der Benutzer gelangt nur wieder in die Whitelist, wenn ein Admin ihn hinzufügt.

#### Pro

- Komplett eigene Lösung
- Algorithmus kann angepasst werden ohne Blockchain zu rebooten
- DOS Algorithmus blockt bevor Transaktion auf SmartWallet trifft

#### Contra

- Mehrere Systeme
- Zentrale Autorität

#### Prozessworkflow

//TODO Bild

### Lösungsansatz 4: Zentrale Smart Wallet für jeden Benutzer

//TODO Bild
![Lösungsansatz4 \label{img_Lösungsansatz4}](images/Lösungsansatz4.png "Lösungsansatz4") 

#### Hauptlösungsansätze

Dieser Lösungsansatz war der
Es wird eine komplett eigene Smart Wallet erstellt, die sowohl die Whitelist wie auch den Schutzalgorithmus verwaltet.
Alle Benutzer erhalten eine zentrale Smart Wallet die von den Admins deployt wird.
Auf einer Whitelist sind alle Benutzer aufgelistet die berechtigt sind gratis Transaktionen durchzuführen. Diese Liste wird von den Admins gepfleft. Der Sicherheitsalgorithmus prüft ob der Benutzer die Gratistransaktions Richtlinien verletzt. Falls der Benutzer die Sicherheitsrichtlinien verletzt, wird er vom Algorithmus aus der Whitelist gelöscht. Der Benutzer gelangt nur wieder in die Whitelist, wenn ein Admin ihn hinzufügt.

#### Pro

- Nur eine Smart Wallet muss deployed und betrieben werden 
- Weniger administrativer Aufwand für Admins

#### Contra

-Schwierig Sender ID für Transaktion zu setzten (überhaupt möglich?)

#### Prozessworkflow

//TODO Bild



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

| Sichere Machbarkeit | Tiefe Komplexität | Komplexität bei Anpassungen | Tiefer Waste bei Anpassungen | Alles On Chain | Wenig administrativer Aufwand | Elegantheit der Lösung | Normale Transaktion | Security | Total |
|---:|:------|:--------|----|---|---|---|---|---|---|
|Prio|3|3|2|2|1|1|?|?| |
| Lösungsansatz 1 | 2 | 1 | 0 | 0 | 2 | 1 | 2 | 2 |?|
| Lösungsansatz 2 | 2 | 2 | 2 | 2 | 0 | 1 | 1 | 2 |?|
| Lösungsansatz 3 | 2 | 1 | 2 | 2 | 0 | 1 | 0 | 0 |?|
| Lösungsansatz 4 | 0 | 0 | 0 | 2 | 0 | 2 | 1 | 0 |?|


Table: Evaluation Lösungsansätze \label{tab_evaluationloesungsansaetze}

### Lösungsansatz 1:  Smart Wallet 
 //TODO nach Prio nochmals umschreiben
Der Lösungsansatz 1 ist die eleganteste Lösung, jedoch laut Evaluation die zweit beste, zusammen mit dem Lösungsansatz 3. Da diese Lösung kein Java Programm wie Lösungsansatz 2 und 3 vorsieht ist sie prioritär. Falls die Kapazitäten ausreichen, wird sie somit auch implementiert. 

### Lösungsansatz 2: Smart Wallet mit externen JavaProgramm nach Whitelist-Check

Ergebnis der Evaluation zeigt, dass diese Lösung die beste nach den Kriterien ist. Deswegen wird diese Lösung als erstes implementiert.

### Lösungsansatz 3: Smart Wallet mit externen JavaProgramm vor Whitelist-Check

Laut Evaluation ist dieser Lösungsansatz auf dem dritten Platz. Deswegen wird

### Lösungsansatz 4: Super Smart Wallet
Dieser Lösungsansatz ist laut Evaluation auf dem letzten Platz. Dies war von Anfang an klar, er wurde aufgezeigt, da es die erste Idee war, für die Lösung.



