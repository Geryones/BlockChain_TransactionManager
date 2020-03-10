
### Tests
Um das Programm getestet zu haben. Haben wir nebst einigen Unit Tests auch automatisierte Abnahme Tests gemacht, mit den wichtigsten Funktionen. Zu denen gehören Performance Tests, das Tesetn des richtigen Einlesens der Files und das Testen vom Resett Intervall.
#### Performance Tests
Bei den Performance Tests wurden für eine Account verschieden viele Transaktionen ausgelöst.
- MaxTxLimite -1
- MaxTxLimite
- MaxTxlimite +1
- 10
- 100
- 500 mit eine Tx Linmite von 450.

Resultat:
Diese Tests haben gezeigt, dass das Programm erst ab der 30sten Transaktion anfängt die Transktionen zu beobachten. Also lohnt sich eine Limite unter 30 nicht wirklich. Auch weil eine kleinere Limite nicht einer DoS Attacke wiederspiegelt.
Auch haben die Tests gezeigt, dass das System viele (500) Transaktionen verarbeiten kann der das Programm diese beobachten kann

#### Lese Tests
Bei diesen Tests wurde geschaut ob die Daten richtig aus der Datei gelesen wird. Dabei wurde eine Test für die Attributliste und ein Test für die Default Settings geschrieben. 

Resultat:
Die Daten werden korrekt aus dem File ausgelesen
#### Intervall Tests
Bei den Intervall Tests wurden Transaktionen betätigt und dannach geschaut, ob Transaktionen und Gas abgezogen wurden. Nach dem eingestellten ResetIntervall Time vom DefaultSettings File wurde geschaut ob die Counter wieder zurückgesetzt sind.

Resultat:
Die Tests sind positiv ausgefallen und haben bestätig wa die manuellen Tests auch betsätigt haben, das der Intervall mit dem Priority Queue Pattern funktioniert
#### Unit Tests
Hier werden verschiedene einzelne Methoden getestet. Wir steuern keine 100% Testbadeckung an und wollen durch Tests der gesamten Funktionalitäten das Programm mehrheitlich testen.

- RevokeAccount
- RevokeAccountList
- CertifyAccount
- CertifyAccountList
//TODO - Gemachte Tests, Resultat, Schlussfolgerung

#### Schlussfolgerung
Automatisierte Tests bestätigen was manuelle Tests bewiesen hatten
Es können viele Transaktionen gemacht werden
Tests brauchen lange um abgespielt zu werden, da man zwischen den Tests warten muss, dass der nächste ausgeführt werden kann
Eine hoche Limite bei den Transaktionen und Gas ist erforderlich
