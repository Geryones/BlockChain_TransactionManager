
### Tests
Um das Programm getestet zu haben. Haben wir nebst einigen Unit tests auch automatisierte Abnahme Tests gemacht. Zu denen gehören Performance Tests, das Tesetn des richtigen Einlesens der Files und Intervall Tests.
#### Performance Tests
Bei den Performance Tests wurden für eine Account verschieden viele Transaktionen ausgelöst.
- MaxTxLimite -1
- MaxTxLimite
- MaxTxlimite +1
- 10
- 100
- 500 mit eine Tx Linmite von 450.

Resultat:
Diese Tests haben gezeigt, dass das Programm erst ab der 30sten Transaktion anfängt die Transktionen zu beobachten. Also lohnt sich eine Limite unter 30 nicht wirklich.
Auch haben die tests gezeigt, dass das System viele (500) Transaktionen verarbeiten kann der das Programm diese beobachten kann

#### Lese Tests
bei diesen tests wurde geschaut ob die Daten richtig aus der Datei gelesen wird. Dabei wurde eine test für die Attributliste und ein test für die Default Settings geschrieben. 
#### Intervall Tests
#### Unit Tests
//TODO - Gemachte Tests, Resultat, Schlussfolgerung
