## Lösungsansätze 

//TODO Spellcheck über ganze Seite

### Lösungsansatz 1: Super Smart Wallet

//TODO Bild

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

#### Hauptlösungsansätze

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

### Lösungsansatz 1: Super Smart Wallet

//TODO Evaluation

### Lösungsansatz 2: Smart Wallet mit externen JavaProgramm nach Whitelist-Check

//TODO Evaluation

### Lösungsansatz 3: Smart Wallet mit externen JavaProgramm vor Whitelist-Check

//TODO Evaluation

### Lösungsansatz 4: Zentrale Smart Wallet für jeden Benutzer

//TODO Evaluation


