
## Weitere Lösungsansätze \label{app_weitereLoesungen}

### Super Smart Wallet

Es wird eine zentrale Smart Wallet entwickelt. Im Gegensatz zu LA 1, \ref{sec_ala_1}, wird nicht für jeden Benutzer eine Smart Wallet deployed, sondern nur eine einzige. Diese kann von allen Benutzern der Blockchain genutzt werden.
Bei diesem Ansatz wird mit der in Absatz \ref{sec_whitelist} beschriebenen Whitelist gearbeitet.

![Super Smart Wallet \label{img_solution4}](images/solution4.png "Super Smart Wallet") 

Die Smart Wallet verwaltet die Whitelist und den Schutzmechanismus gegen DoS Attacken. Das ist auf Abbildung \ref{img_solution4} ersichtlich. Wird eine DoS Attacke identifiziert, wir der entsprechende Account aus der Whitelist gelöscht.  

#### Pro

Es existiert nur eine einzige Smart Wallet. Das Deployment ist somit weniger aufwändig. 
Falls eine Änderung am Code gemacht nötig ist, muss nur eine Smart Wallet neu deployed werden. 

#### Contra

Bei diesem Ansatz ist die Machbarkeit unklar. 
Parity muss umgeschrieben werden, da nicht die Senderidentität der Smart Wallet genutzt werden muss, sondern die des Benutzeraccounts. 
Ebenfalls muss die Whitelist-Funktionalität von Parity angepasst werden, analog zu LA 1. 
\newpage
