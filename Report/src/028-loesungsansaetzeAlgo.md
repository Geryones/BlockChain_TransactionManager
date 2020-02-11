### DoS-Algorithmus

In diesem Abschnitt sind die erarbeiteten DoS-Algorithmus-Lösungsansätze (DLA) aufgeführt. 

// TODO Faustina

#### DLA 1: Blockierung eines Accounts anhand Transaktionen
Ein Account wird anhand der Anzahl Transaktionen blockiert.

##### Pro
- Alle Accounts können gleichviel Transaktionen betätigen. 

#### Contra
- Die Grösse der Transaktionen wird nicht berücksichtigt bei der Blockierung.

#### DLA 2: Blockierung eines Account anhand grösse der Transaktionen (Gas Used)
Ein Account wird anhand der grössen der Transaktionen geblockt.

##### Pro
- Transaktionsgrössen werden berücksichtigt

#### Contra
- Wenn ein Benutzer eine sehr grosse Transaktion macht, kann es passieren, dass er nur eine machen kann und dann geblockt wird.


#### DLA 3: Blockierungs Parameter bei jedem Account gleich
Die Grösse der Blockierungsparameter ist bei jedem Account gleich. Das heisst jeder kann gleich viele Transaktionen, oder gleich viel "Gas Used" gebrauchen.

##### Pro
- Jeder Benutzer ist gleich
- Weniger kompliziert

#### Contra
- Verschiedene Benutzer, wie zB Dozenten werden gleich wie Studenten behandelt

#### DLA 4: Blockierungsparameter bei jedem Account einzeln konfigurierbar
Die Grösse der Blockierungsparameter ist bei jedem Account konfigurierbar. Das heisst jeder kann verschieden viele Transaktionen, oder verschieden viel "Gas Used" gebrauchen.

##### Pro
- Jeder Benutzer wird einzeln beurteilt
#### Contra
- kompliziert

#### DLA 5: Blockierungsparameter über Gruppen konfigurierbar
Die Grösse der Blockierungsparameter ist über verschieden definierte Gruppen konigurierbar. Je nach Gruppe wird die maximale Anzahl Transaktionen oder "Gas Used" definiert.

Mögliche Gruppen:
- Student  --> für Module
- Power Student --> für spezielle Projekte (IP1-IP6)
- Dozent --> Mehr Rechte wie Studenten
- Power User --> Mehr rechte als Dozent
- Admin --> Wird nie geblockt

##### Pro
- Weniger kompliziert als alle einzeln
- Durch Gruppendefinition klar welche Rolle Account hat 
- Alle Gruppenmitglieder gleich (Ein Dozent mehr als der andere)

#### Contra
- Nicht komplett Anonym

#### DLA 6: Blockierungsperiode immer am gleichen Moment für alle aufgehoben
Ein bestimmter Intervalls moment wird definiert. In diesem Moment werden alle Benutzer aus der Liste wieder für die Whitelist certifiziert.

##### Pro
- Einfach

#### Contra
- Accounts werden nicht gleichlang geblockt
- Wer weiss wann der Entblockungsmoment ist, kann dies missbrauchen

#### DLA 7: Blockierungsperiode für alle Accounts gleich ab Blockierung
Die Blockierungsperiode fängt ab dem Punkt an zu zählen, wenn der Account blockiert wird.

##### Pro
- Alle Benutzer/Account werden gleichlang geblockt

#### Contra
- Komplizierter als DLA7

#### DLA 8: Blockierungsperiode bei jedem Account einzeln konfigurierbar
Dieser Lösungsansatz ist nur mit DLA7 kombinierbar. In der Konfiguration wird ein Parameter mitgegeben, der definiert für wieviel Perioden der Account gesperrt ist.
Periodenintervalle könnten sein:
//TODO Faustina ist für 4h oder 1Tag
- 1h
- 4h 
- 6h
- 1Tag 
- 1 Woche
##### Pro
- Länge der Blockierung je nach Benutzer definierbar (zB Dozent weniger lang)
#### Contra
- kompliziert

#### DLA 9: Blockierungslänge erhöht sich, nach Vergehenszahl
Bei diesem DLA wird ein Account je nach Vergehenszahl länger blockiert. Zuerst wird er nur kurz blockiert, wird er ein weiteres mal gesperrt, wird er länger gesperrt.
Beispiel:
- Bei 20 Transaktionen --> 15' gesperrt
- Bei 40 Transaktionen -->30' gesperrt
- Bei 20 Transaktionen --> 60' gesperrt
- Bei 20 Transaktionen --> 4h gesperrt
- Bei 20 Transaktionen --> 1 Tag gesperrt
- Bei 20 Transaktionen --> 1 Woche gesperrt

#### Pro
- Bei mehr Vergehen, wird man mehr bestraft
- Jeder Benutzer gleich (Kann als positiv oder negativ gewertet werden)

#### Contra 
- Kompliziert
- Jeder Benutzer gleich (Kann als positiv oder negativ gewertet werden)

### Evaluation DoS Algorithmus

Es werden mehrer LA implementiert da sie kombinierbar sind.

//TODO Kriterien
//Gewichtung Kriterien
//Tabellarische Evaluation
//Erläuterung Evaluation


#### Resultat Evaluation
