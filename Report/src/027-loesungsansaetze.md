## Lösungsansätze 

### Lösungsansatz 1: Super Smart Wallet

#### Hauptlösungsansätze
Es wird eine komplett eigene Smart Wallet erstellt, die sowohl die Whitelist wie auch den Schutzalgorithmus verwaltet.
Jeder Benutzer erhält eine eigene Smart Wallet die von den Admins deployt wird.
Auf der Whitelist sind alle Benutzer aufgelistet die berechtigt sind gratis Transaktionen durchzuführen. Diese Liste wird von den Admins gepfleft. Der Sicherheitsalgorithmus prüft ob der Benutzer die Gratistransaktions Richtlinien verletzt. Falls der Benutzer die Sicherheitsrichtlinien verletzt, wird er vom Algorithmus aus der Whitelist gelöscht. Der Benutzer gelangt nur wieder in die Whitelist, wenn ein Admin ihn hinzufügt.

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

### Lösungsansatz 2: Smart Wallet mit externen JavaProgramm nach Whitelist-Check
#### Hauptlösungsansätze
Es wird eine komplett eigenen Smart Wallet erstellt, die die Whitelist verwaltet. Zusätzlich wird ein Java Programm entwickelt, der den Schutzalgorithmus beinhaltet. 
Jeder Benutzer erhält eine eigene Smart Wallet die von den Admins deployt wird.
Auf der Whitelist sind alle Benutzer aufgelistet die berechtigt sind gratis Transaktionen durchzuführen. Diese Liste wird von den Admins gepfleft.
Der externe Sicherheitsalgorithmus prüft nach dem Whitelist-Check ob der Benutzer die Gratistransaktion Richtlinien verletzt. Falls der Benutzer die Sicherheitsrichtlinien verletzt, wird er vom Algorithmus aus der Whitelist gelöscht. Der Benutzer gelangt nur wieder in die Whitelist, wenn ein Admin ihn hinzufügt.

#### Pro

#### Contra

#### Prozessworkflow

### Lösungsansatz 3: Smart Wallet mit externen JavaProgramm vor Whitelist-Check
#### Hauptlösungsansätze
Es wird eine komplett eigenen Smart Wallet erstellt, die die Whitelist verwaltet. Zusätzlich wird ein Java Programm entwickelt, der den Schutzalgorithmus beinhaltet. 
Jeder Benutzer erhält eine eigene Smart Wallet die von den Admins deployt wird.
Auf der Whitelist sind alle Benutzer aufgelistet die berechtigt sind gratis Transaktionen durchzuführen. Diese Liste wird von den Admins gepfleft.
Der externe Sicherheitsalgorithmus prüft vor dem Whitelist-Check ob der Benutzer die Gratistransaktion Richtlinien verletzt. Falls der Benutzer die Sicherheitsrichtlinien verletzt, wird er vom Algorithmus aus der Whitelist gelöscht. Der Benutzer gelangt nur wieder in die Whitelist, wenn ein Admin ihn hinzufügt.

#### Pro

#### Contra

#### Prozessworkflow

### Lösungsansatz 4: Zentrale Smart Wallet für jeden Benutzer
#### Hauptlösungsansätze
#### Pro
#### Contra
#### Prozessworkflow

blub

### Evaluation der Lösungsansätze


