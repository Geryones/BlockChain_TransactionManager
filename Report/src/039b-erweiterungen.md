
### Mögliche Erweiterungen

In diesem Abschnitt sind mögliche Erweiterungen respektive Anpassungen aufgeführt. 

#### Alles auf der Blockchain

Zur Zeit ist der Transaktionsmanger nicht Teil der Blockchain. Weiter ist er
eine zentrale Authorität.\
Wenn der Transaktionsmanager mit Smart Contracts auf der Blockchain realisiert
ist, wird eine vollständige Transparenz und Dezentralität erreicht. Das erhöht
auch die Sicherheit, da der Transaktionsmanager von den vorhandenen
Schutzmechanismen der Blockchain profitieren kann.

Wie unter \ref{sec_ala_1} erklärt, muss dafür Parity erweitert werden. Eine
Whitelist mit priviligierten Accounts ist nicht ausreichend. Es ist eine Liste
mit Verbindungen nötig. 


#### Automatisiertes Deployment

Wenn die Blockchain frisch aufgesetzt wird, könnte das Deployment und die
Registrierung des Certifiers automatisiert werden. Analog zur Name Registry kann
der Certifier direkt in der Blockchainspezifikation deployed werden. Zusätlich
ist es möglich, den Constructor vom Certifier so anzupassen, dass er sich
automatisch bei der Name Registry registriert.\
Dafür muss der ```SimpleCertifier``` und die Blockchainspezifikation angepasst werden.

#### Report

Um die Benutzerfreundlichkeit zu erhöhen, könnte eine leserliche
Zusammenstellung aller Ereignisse erstellt werden. Diese könnte manuell
abgerufen oder automatisch via Email an die Betreiber des Transaktionsmanagers
gesendet werden.\
Für eine Zustellung via Mail muss ein Mailserver zur Verfügung stehen. 

#### Inputvalidierung

Mit einer Validierung der Input-Dateien und einer entsprechenden Meldung, könnte
mehr Benutzerfreundlichkeit erreicht werden.


