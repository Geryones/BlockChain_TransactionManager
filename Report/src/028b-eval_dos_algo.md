
### Evaluation DoS-Algorithmus \label{sec_evalAlgo}

In diesem Abschnitt werden die Komponenten des Algorithmus evaluiert. 

#### Parameter

Die aufgeführten Parameter werden auf ihre Relevanz für die Erkennung einer DoS Attacke geprüft. 

##### Sender

Ist zwingend nötig um eine Transaktion einem Account zuweisen zu können. 

##### Empfänger

Dieser kann von Sender frei gewählt werden. Es wird auch kein Einverständnis des Empfängers für eine Transaktion benötigt. Jeder Benutzer ist weiter in der Lage, selbst neue Accounts zu erstellen und diese als Empfänger zu verwenden. Der Parameter hat somit keine Aussagekraft und wird nicht verwendet.

##### Reset-Intervall

Wir haben uns für die Implementierung eines allgemeinen Intervalls entschieden. Der Ansatz ist bedeutend einfacher umzusetzen als ein individuelles Intervall und kann daher sicher in der gegebenen Zeit realisiert werden. Am Ende des Intervalls, werden die Zähler für alle Parameter pro Account zurückgesetzt. 

Die Auswirkung des genannten Nachteils beim allgemeinen Intervall ist stark von dessen Länge abhängig. Je kürzer das Intervall gewählt wird, umso kleiner sind die möglichen Folgen.

##### Anzahl gratis Transaktionen

Dieser Parameter wird verwendet. Er ermöglicht es eine DoS Attacke zu identifizieren, welche die Beeinträchtigung der Blockchain mittels einer grossen Zahl von gratis Transaktionen erreichen will. 

##### Anzahl verbrauchtes Gas

Wie unter \ref{sec_dos} erwähnt, können Transaktionen mit einem sehr hohen Gas-Bedarf für eine DoS-Attacke verwendet werden. Da beim Angreifer mit der Verwendung von gratis Transaktionen keine Mehrkosten anfallen, ist dieser Angriff sehr naheliegend. Daher wird dieser Parameter ebenfalls verwendet.

#### Wiederaufnahme auf die Whitelist

Ein fixer Zeitpuntk ist sehr einfach umzusetzen. Allerdings werden dadurch die Accounts nicht mehr gleich behandelt. Wie lange ein Account keine gratis Transaktionen mehr tätigen kann, ist abhängig davon, zu welchem Zeitpunkt er von der Whitelist gelöscht wird. Wenn der gesetzte Zeitpunkt dem Benutzer bekannt ist, kann das System missbraucht werden. Wird ein DoS Angriff kurz vor dem Resetzeitpunkt ausführt, hat es praktisch keine Folgen für den Benutzer. Sein Account wird zwar von der Whitelist entfernt, aber mit dem entsprechendem Zeitmanagement gleich wieder entsperrt. 

Mit einem Zeitintervall werden alle Accounts gleich lange von der Whitelist gelöscht. Dieser Ansatz bietet daher mehr Fairness als ein fixer Zeitpunkt. 

Je öfter mit einem Account gegen die Regeln verstossen wird, desto kleiner ist die Wahrscheinlichkeit, dass es sich um Versehen handelt. Daher kann davon ausgegangen werden, dass ein Wiederholungstäter aktiv versucht, die Blockchain zu schädigen. Mit einem inkrementierenden Intervall werden diese Accounts gezielt und härter bestraft als bei den anderen Ansätzen.  
Einmalige Verstösse die versehentlich auftreten werden in einer Lernumgebung als wahrschneinlich eingeschätzt. Mit diesem System werden solche Versehn sehr milde bestraft. 

Wir haben uns entschieden, eine Kombination aus einem fixen Zeitpunkt und einem inkrementierenden Intervall zu verwenden. Dieser Ansatz ist in der gegebenen Zeit realisierbar und bietet nebst einem effizienten Schutz auch eine Toleranz für einmalige Verstösse.\
Die Dauer einer Suspendierung von der Whitelist kann mit dem Parameter "Revoke-Faktor" konfiguriert werden. Als Basis wird das Reset-Intervall verwendet.

$t = resInter * revFak * v$

Wobei $t$ die Dauer der Suspendierung, $resInter$ das Reset-Intervall, $revFak$ der Revoke-Faktor und $v$ die Anzahl bereits begangener Verstösse abbilden. 

Anbei Beispiel mit einem Reset-Intervall von fünf Minuten, einem Revoke-Faktor von 3 und der daraus resultierenden Suspendierung von der Whitelist in Minuten:

| resInter | revFak  | Verstösse | Suspendierung (min) |
|:----------:|--------:|----------:|--------------------:|
| 5 | 3 | 1 | 15 | 
| 5 | 3 | 2 | 30 | 
| 5 | 3 | 3 | 45 | 
| 5 | 3 | 4 | 60 | 
| 5 | 3 | 5 | 75 | 
| 5 | 3 | 6 | 90 |



#### Benutzermanagement

Es besteht der Bedarf, dass Accounts von Dozenten toleranter behandelt werden als solche von Studenten. Daher muss ein Benutzermanagement implementiert werden. 

Ein gruppenbasiertes Benutzermanagement ist intuitiv und effizient, da vorhandene Strukturen der FHWN, wie Klassen oder Dozenten, abgebildet werden können. Die Implementation wird jedoch als sehr komplex eingeschätzt. Die Realisierbarkeit in der gegebenen Zeit ist fraglich. Der Ansatz wird daher nicht implementiert.

Das lässt nur die Möglichkeit, jeden Account einzeln zu konfigurieren. Es wird erwartet, dass für die Mehrheit der Accounts kein Bedarf an individuellen Parametern besteht. Um diesen Umstand gerecht zu werden, werden Standardparameter angeboten. Diese werden verwendet, für die Parameter nicht explizit definiert werden. So kann die Mehrheit der Accounts über Standardparameter und Ausnahmen individuell konfiguriert werden.  

Um zu verhindern, dass das externe Programm angreifbar wird, kann das Reset-Intervall nur global definiert werden. Bei einem individuellen Reset-Intervall müsste für jeden Verstoss einer neuer Thread im Programm gestartet werden. Dadurch würde das Programm selbst anfällig für eine DoS Attacke.

### Konfiguration des Algorithmus \label{sec_algConf}

Um dem Betreiber die Möglichkeit zu geben, den Algorithmus an seine Bedürfnisse anzupassen, können die Parameter und Zeitintervalle, siehe \ref{sec_evalAlgo}, konfiguriert werden. 
Die Konfiguration wird mit einer Textdatei vorgenommen. Für alle Parameter müssen natürliche Zahlen verwendet werden. Folgende Parameter können pro Account gesetzt werden: 

Gratis Transaktionen
:       Definiert die maximale Anzahl gratis Transaktionen die pro Reset-Intervall getätigt werden können.

Gratis Gas
:       Definirt die maximale Menge an Gas die mit gratis Transaktionen innerhalb eines Reset-Intervalls verbraucht werden können.

Wenn für einen Account individuelle Schwellenwerte für Transaktionen und Gas definiert werden, müssen immer beide Parameter gesetzt werden. 

Folgende Parameter gelten für alle Accounts:

Reset-Intervall
:     Einheit ist Minuten, definiert die Länge des Reset-Intervalls.

Revoke-Intervall
:      Anzahl der Reset-Intervalls, für die ein Account bei einer positiven Prüfung durch den Algorithmus von der Whitelist gelöscht wird. 

Standardwert gratis Transaktionen
:      Giltet für Accounts die ohne Parameter erfasst werden. Definiert die maximale Anzahl gratis Transaktionen die pro Reset-Intervall getätigt werden können.

Standardwert gratis Gas
:     Giltet für Accounts die ohne Parameter erfasst werden.  Definirt die maximale Menge an Gas die mit gratis Transaktionen innerhalb eines Reset-Intervalls verbraucht werden können.

Bei der Konfiguration sollten die Abhängigkeiten zwischen den Parametern geachtet werden. Verfügbares Gas, Anzahl Transaktionen und das Reset-Intervall sollten immer zusammen konfiguriert werden. 
