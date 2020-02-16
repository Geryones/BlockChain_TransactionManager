### DoS-Algorithmus

//TODO Spellcheck 

In diesem Abschnitt ist der erarbeitete DoS-Algorithmus-Lösungsansatz (DLA) aufgeführt. Der Algorithmus wird verwendet um getätigte gratis Transaktionen zu überwachen und falls nötig einzuschränken. Wird ein Account als Bedrohung für die Blockchain eingestuft, wird dieser Account von der Whitelist gelöscht. 

#### Parameter 

Die ausgewählten Parameter werden beim Start des externen Programmes aus einer Konfigurationsdatei gelesen. Das erlaubt dem Betreiber, die Überwachung der Blockchain an seine Bedürfnisse anzupassen.

##### Zeitinterval

Alle Interaktionen auf der Blockchain müssen relativ zu einem Zeitinterval bewertet werden. Absolute Werte über die gesammte Lebensdauer einer Blockchain sind nicht aussagekräftig. 

Das Zeitinterval wird in Minuten angegeben. Das erlaubt dem Betreiber eine granulare Überwachung der Blockchain. Es muss jedoch beachtet werden, dass ein zu kleines Zeitintervall sehr Resourcen intensiv sein kann. 

##### Anzahl Transaktionen

Jeder Account verfügt über ein Kontingent von gratis Transaktionen pro Zeitintervall. Der Typ der Transaktion ist dabei nicht relevant. 

##### Komputationskosten

Jeder Account verfügt über ein Kontingent von Gas pro Zeitintervall. Dieser Ansatz berücksichtig die Komputationskosten, die von einer Transaktionen auf der Blockchain verursacht werden.  

#### Benutzermanagement



Die Grösse der Blockierungsparameter ist bei jedem Account gleich. Das heisst jeder kann gleich viele Transaktionen, oder gleich viel "Gas Used" gebrauchen.

##### Pro

- Jeder Benutzer ist gleich
- Weniger kompliziert

##### Contra

- Verschiedene Benutzer, wie zB Dozenten werden gleich wie Studenten behandelt

#### DLA 4: Blockierungsparameter bei jedem Account einzeln konfigurierbar

Die Grösse der Blockierungsparameter ist bei jedem Account konfigurierbar. Das heisst jeder kann verschieden viele Transaktionen, oder verschieden viel "Gas Used" gebrauchen.

##### Pro

- Jeder Benutzer wird einzeln beurteilt

##### Contra

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

##### Contra

- Nicht komplett Anonym



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

##### Contra

- kompliziert



#### Konsequenzen

Falls die Prüfung durch den Algorithmus positiv ausfällt, wird der betreffende Account von der Whitelist gelöscht. In diesem Abschnitt sind mögliche Vorgehensweisen aufgeführt, um einen verdächtigen Account nach der Sperrung, wieder zur Whitelist hinzuzufügen.

#### DLA 6: Blockierungsperiode immer am gleichen Moment für alle aufgehoben

Ein bestimmter Intervalls moment wird definiert. In diesem Moment werden alle Benutzer aus der Liste wieder für die Whitelist certifiziert.

##### Pro

- Einfach

##### Contra

- Accounts werden nicht gleichlang geblockt
- Wer weiss wann der Entblockungsmoment ist, kann dies missbrauchen

#### DLA 7: Blockierungsperiode für alle Accounts gleich ab Blockierung

Die Blockierungsperiode fängt ab dem Punkt an zu zählen, wenn der Account blockiert wird.

##### Pro

- Alle Benutzer/Account werden gleichlang geblockt

##### Contra

- Komplizierter als DLA7

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

##### Contra 

- Kompliziert
- Jeder Benutzer gleich (Kann als positiv oder negativ gewertet werden)

### Evaluation DoS Algorithmus

Es werden mehrer LA implementiert da sie kombinierbar sind.

//TODO Kriterien
//Gewichtung Kriterien
//Tabellarische Evaluation
//Erläuterung Evaluation