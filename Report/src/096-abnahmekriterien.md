# Abnahmekriterien

In diesem Kapitel werden alle Abnahmekriterien des Blockchain Transaktions Managers aufgelistet und Kategorisiert.
Es wird zwischen funktionalen und nicht-funktionales Kriterien unterschieden.
//TODO Text

| Nr.       | Titel  | Beschreibung |
| :------------- |:------------| :-----|
| 1.     |  Bezahlte Transaktionen für alle  | Jeder gültige Account kann Transaktionen mit Gas Price durchführen|
| 2.     |  Gratis Transaktionen für Whitelist | Ein Account der für die Whitelist certifiziert ist, kann Transaktionen mit Gas Price "0" durchführen  |
| 3.     |  Account aus Liste für Whitelist certifizieren  | Alle Account die auf der Liste stehen sind für die Whitelist certifiziert |
| 4.     |  Account aus Liste und Whitelist entfernen  | Wenn ein Account gelöscht wird, wird er von der Whitelist wie auch von der Account Liste entfernt |
| 5.     |  Account nach 20 Transaktionen sperren  | Ein Account der 20 Transaktionen betätigt hat, wird für eine Zeitspanne gesperrt |
| 6. | Gesperrte Account entsperren |  Ein gesperrter Account wird nach einer gesetzten Zeitspanne wirder entsperrt |
| 7.     |  Account manuell sperren  | Ein Account kann manuell gesperrt werden |
| 8.     | Counter resetten | Der Counter aller Accounts wird nach einer Woche wieder auf 0 gesetzt |


