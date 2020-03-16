## Abnahmekriterien  \label{sec_prac_abnahmekriterien}

In diesem Kapitel werden alle Abnahmekriterien des Blockchain Transaktions Managers aufgelistet und Kategorisiert.
Es wird zwischen funktionalen und nicht-funktionales Kriterien unterschieden.
//TODO Text

 
| Nr.   | Titel                             | Beschreibung                                   |
| -----:|:----------------------------------|:-----------------------------------------------|
| 1.    | Bezahlte Transaktionen für alle Accounts | Jeder gültige Account kann Transaktionen mit Gas Price durchführen|
| 2.    | Gratis Transaktionen nur für Accounts in Whitelist | Ein Account der für die Whitelist zertifiziert ist, kann Transaktionen mit Gas Price "0" durchführen. Alle anderen Accounts können dies nicht. |
| 3.    | Account aus Liste für Whitelist zertifizieren  | Account die für die Whitelist zertifiziert werden sollen, stehen in der JSON Datei |
| 4.    | Account aus Liste und Whitelist entfernen  |  Account die für die gelöscht werden sollen, stehen in der JSON Datei mit einer Kennzeichnung, dass sie gelöscht werden. Sobald ein Account gelöscht wird, wird er von der Whitelist wie auch von der JSON  Datei entfernt |
| 5.    | Account nach Transaktionen sperren  | Ein Account der zu viele Transaktionen betätigt hat, wird für eine Zeitspanne gesperrt. |
| 6.    | Account nach GasUsed sperren | Ein Account der zu viel Gas für seine Transaktionen benutzt hat wird gesperrt  |
| 7.    | Gesperrte Account entsperren |  Ein gesperrter Account wird nach einer gesetzten Zeitspanne wieder entsperrt. Diese wird in der Account Datei definiert. Sobald ein Account gesperrt wird, wird ein Zeitstempel mit dem Zeitpunkt wann wieder der Account zertifiziert wird, gesetzt. Somit ist die genaue Sperrzeit garantiert, auch wenn das Programm für eine Zeit ausfällt. |
| 8.    | Reset Zeitintervall setzten | Es wird ein allgemeines Zeitintervall gesetzt, welches definiert wann alle Counters der Accounts auf ihre Default Werte zurückgesetzt werden.  |
| 9.    | Speicherung des Zeitintervalls | Nach jedem Reset wird der Zeitstempel gespeichert. Somit wird das genaue Intervall gesichert auch wenn das Programm kurz ausfällt. |
| 10.   | Sperrzeit | Die Zeitspanne wie lang ein Account gesperrt wird, kann global in der DefaultSettings Datei gesetzt werden. Für Ausnahmen kann in der Account Datei für ein Account ein eigener Wert gesetzt werden.  |
| 11.   | Transaktionslimite pro User | Die Anzahl Transaktionen bis ein Account gesperrt wird, kann für jeden Account individuell eingestellt werden |
| 12.   | GasUsed Limite pro User | Die Anzahl Gas Used bis ein Account gesperrt wird, kann für jeden Account individuell eingestellt werden |
| 13.   | Default Werte für Limiten | Es können default Werte für max. Transaktionen und max Gas Used gesetzt werden  |
| 14.   | Certifier nur von Owner deployen | Der Certifier kann nur vom Owner registriert werden  |
| 15.   | Certifier nur einmal deploybar  | Der Certifier kann nur einmal deployt/registriert werden |
| 16.   | Transaktions Manager Account kann nicht gesperrt werden | Transaktions Manager Account kann nicht gesperrt werden |
\newpage


