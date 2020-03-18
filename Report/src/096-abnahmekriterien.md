## Abnahmekriterien  \label{sec_prac_abnahmekriterien}

In der Tabelle \ref{tab_abnahmekriterien} sind die Abnahmekriterien aufgeführt.
 
| Nr.   | Titel                             | Beschreibung                                   |
| -----:|:----------------------------------|:-----------------------------------------------|
| 1.    | Bezahlte Transaktionen für alle Accounts | Jeder Account kann Transaktionen durchführen mit einem gültigen Gas Preis durchführen|
| 2.    | Gratis Transaktionen nur für Accounts in Whitelist | Nur Accounts die in der Whitelist erfasst sind, können gratis Transaktionen durchführen. |
| 3.    | Liste von Accounts der Whitelist hinzufügen  | Accounts die für die Whitelist zertifiziert werden sollen, stehen in der JSON Datei. Diese Accounts werden geladen und der Whitelist hinzugefügt.|
| 4.    | Accounts permanent von Whitelist entfernen  | In der Datei ```AccountList.json``` wird ein Account für die Löschung markiert. Dafür wird der Parameter ```deleteMe``` verwendet. Der Account wird von der Whitelist und ```AccountList.json``` entfernt.|
| 5.    | Sperrung eines Accounts nach zu vielen Transaktionen | Ein Account der die Transaktionslimite überschreitet, wird temporär von der Whitelist gelöscht. |
| 6.    | Sperrung eines Accounts bei zu hohem gratis Gas Verbrauch | Ein Account der die Limite von gratis Gas überschreitet, wird temporär von der Whitelist gelöscht |
| 7.    | Revoke-Intervall | Beim Entfernen eines Accounts von der Whitelist, wird der Zeitstempel für das Revoke-Intervall korrekt gesetzt. Sobald der im Stempel definierte Zeitpunkt erreicht wird, wird der Account wieder auf die Whitelist gesetzt. |
| 8.    | Reset-Intervall | Die Zähler der Accounts werden nach Ablauf des Reset-Intervalls zurückgesetzt. Ein neues Command für das Reset-Intervall wird durch Rekursion in die Priority-Queue eingefügt.  |
| 9.    | Zeitstempel für Reset-Intervall | Der Zeitstempel des Rest-Intervalls wird in der Datei ```DefaultSettings.json``` korrekt gesetzt.|
| 10.   | Standardwert für Revoke-Intervall | Der Standardwert des Revoke-Intervalls wird auf Accounts ohne individuelles Revoke-Intervall angewendet.  |
| 11.   | Transaktionslimite pro Account | Die Transaktionslimite kann für jeden Account inidviduell gesetzt werden.|
| 12.   | Gaslimite pro User | Die Menge an verbrauchten gratis Gas kann für jeden Account individuell eingestellt werden |
| 13.   | Standardwerte für Limiten | Es können Standardwerte für Transaktionslimite und Gaslimite gesetzt werden. |
| 14.   | Registrierung Certifier | Die Registrierung des Certifiers kann nicht überschrieben werden |

Table: Abnahmekriterien \label{tab_abnahmekriterien}



\newpage


