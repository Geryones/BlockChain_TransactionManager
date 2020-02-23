## Abnahmekriterien

In diesem Kapitel werden alle Abnahmekriterien des Blockchain Transaktions Managers aufgelistet und Kategorisiert.
Es wird zwischen funktionalen und nicht-funktionales Kriterien unterschieden.
//TODO Text

| Nr.       | Titel  | Beschreibung |
| :------------- |:------------| :-----|
| 1.     |  Bezahlte Transaktionen für alle  | Jeder gültige Account kann Transaktionen mit Gas Price durchführen|
| 2.     |  Gratis Transaktionen für Whitelist | Ein Account der für die Whitelist zertifiziert ist, kann Transaktionen mit Gas Price "0" durchführen  |
| 3.     |  Account aus Liste für Whitelist zertifizieren  | Alle Account die auf der Liste stehen sind für die Whitelist certifiziert |
| 4.     |  Account aus Liste und Whitelist entfernen  | Wenn ein Account gelöscht wird, wird er von der Whitelist wie auch von der Account Liste entfernt |
| 5.     |  Account nach Transaktionen sperren  | Ein Account der zu viele Transaktionen betätigt hat, wird für eine Zeitspanne gesperrt |
| 6. | Gesperrte Account entsperren |  Ein gesperrter Account wird nach einer gesetzten Zeitspanne wirder entsperrt |
| 7.     |  Account manuell sperren  | Ein Account kann manuell gesperrt werden |
| 8.     | Counter resetten | Der Counter aller Accounts wird nach Zeitperiode wieder auf 0 gesetzt |
| .     | Account nach GasUsed sperren | Ein Account der zu viel Gas für seine Transaktionen benutzt hat wird gesperrt  |
| .     | Transaktionslimite pro User | Die Anzahl Transaktionen bis ein Account gesperrt wird, kann für jeden Account individuell eingestellt werden |
| .     | GasUsed Limite pro User | Die Anzahl Gas Used bis ein Account gesperrt wird, kann für jeden Account individuell eingestellt werden |
| .     | Zeitintervall setzten | Das zeitintervall für wann die Limiten und Sperrungen gelten kann angepasst werden  |
| .     | |   |
| .     | |   |
| .     | |   |
| .     | Anzahl Sperrungen speichern | Die Anzahl Sperrungen eines Accounts werden in einem File gespeichert  |
| .     | Sperrzeit Abhängig von Anzahl Sperrungen | Die Sperrzeit wird höher, je öfter der Account gesperrt wurde  |

| .     | Certifier nur von Owner deployen | Der Certifier kann nur vom Owner registriert werden  |
| .     | Certifier nur einmal deploybar  | Der Certifier kann nur einmal deplyt/registriert werden |


