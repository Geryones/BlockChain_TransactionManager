
### Evaluation DoS-Algorithmus \label{sec_evalAlgo}

In diesem Abschnitt werden die Komponenten des Algorithmus evaluiert. 

#### Parameter

Die aufgeführten Parameter werden auf ihre Relevanz für die Erkennung einer DoS
Attacke geprüft. 

Sender
:    Ist zwingend nötig, um eine Transaktion einem Account zuweisen zu können. 

Empfänger
:    Dieser kann vom Sender frei gewählt werden. Es wird kein Einverständnis des
Empfängers für eine Transaktion benötigt. Jeder Benutzer ist in der Lage,
selbst neue Accounts zu erstellen und diese als Empfänger zu verwenden.\
Der Parameter hat keine Aussagekraft und wird nicht verwendet.

Reset-Intervall
:    Wir haben uns für die Implementierung eines allgemeinen Intervalls entschieden.
Der Ansatz ist bedeutend einfacher umzusetzen als ein individuelles Intervall
und kann daher sicher in der gegebenen Zeit realisiert werden. Am Ende des
Intervalls, werden die Zähler für alle Parameter pro Account zurückgesetzt.

Anzahl gratis Transaktionen
:    Dieser Parameter wird verwendet. Er ermöglicht es eine DoS Attacke zu
identifizieren, welche die Beeinträchtigung der Blockchain mittels einer grossen
Zahl von gratis Transaktionen erreichen will. 

Anzahl verbrauchtes Gas
:    Wie unter \ref{sec_dos} erwähnt, können Transaktionen mit einem sehr hohen
Gas-Bedarf für eine DoS-Attacke verwendet werden. Da beim Angreifer mit der
Verwendung von gratis Transaktionen keine Mehrkosten anfallen, ist dieser
Angriff sehr naheliegend. Daher wird dieser Parameter ebenfalls verwendet.

#### Wiederaufnahme auf die Whitelist

Ein fixer Zeitpunkt ist sehr einfach umzusetzen. Allerdings werden dadurch die
Accounts nicht mehr gleichbehandelt. Wie lange ein Account keine gratis
Transaktionen mehr tätigen kann, ist abhängig davon, zu welchem Zeitpunkt er von der Whitelist gelöscht wird. 

Mit einem Zeitintervall ab Zeitpunkt des Vergehens, werden alle Accounts gleich
lange von der Whitelist gelöscht. Dieser Ansatz bietet daher mehr Fairness als
ein fixer Zeitpunkt. Die Implementierung wird als komplexer betrachtet. 

Je öfter mit einem Account gegen die Regeln verstossen wird, desto kleiner ist
die Wahrscheinlichkeit, dass es sich um Versehen handelt. Daher kann davon
ausgegangen werden, dass ein Wiederholungstäter aktiv versucht, die Blockchain
zu schädigen. Mit einem inkrementierenden Intervall werden diese Accounts
gezielt und härter bestraft als bei den anderen Ansätzen.\
Eine inkrementierende Bestrafung ist bei einem Schutz vor DoS Attacken
nicht relevant. Es genügt, wenn der Angriff unterbrochen werden kann. Eine immer
stärkere Bestrafung ist nicht nötig.\
Die Dauer der Suspendierung ist nicht mehr konstant. Daher muss einem Benutzer
mitgeteilt werden, für wie lange er suspendiert ist. Wie diese Kommunikation
realisiert werden soll, ist unklar.

Wir haben uns entschieden, ein Zeitintervall ab Zeitpunkt des Vergehens zu
implementieren. Dieser Ansatz ist fair und verständlich für die Benutzer. Das Intervall ist fortan Revoke-Intervall genannt.


#### Benutzermanagement

Es besteht der Bedarf, dass Accounts von Dozenten toleranter behandelt werden
als solche von Studenten. Daher muss ein Benutzermanagement implementiert
werden. 

Ein gruppenbasiertes Benutzermanagement ist intuitiv und effizient, da
vorhandene Strukturen der FHWN, wie Klassen oder Dozenten, abgebildet werden
können. Die Implementation wird jedoch als sehr komplex eingeschätzt. Die
Realisierbarkeit in der gegebenen Zeit ist fraglich. Der Ansatz wird daher nicht
implementiert.

Das lässt nur die Möglichkeit, jeden Account einzeln zu konfigurieren. Es wird
erwartet, dass für die Mehrheit der Accounts kein Bedarf an individuellen
Parametern besteht. Um diesen Umstand gerecht zu werden, werden
Standardparameter angeboten. Diese werden verwendet, wenn Parameter für einen
Account nicht explizit definiert sind. So müssen nur Ausnahmen individuell
konfiguriert werden.  

### Konfiguration des Algorithmus \label{sec_algConf}

Um dem Betreiber die Möglichkeit zu geben, den Algorithmus an seine Bedürfnisse
anzupassen, können die Parameter und Zeitintervalle, siehe \ref{sec_evalAlgo},
konfiguriert werden. Die Konfiguration wird mit über Dateien vorgenommen. Für
alle Parameter müssen natürliche Zahlen verwendet werden. Folgende Parameter
können pro Account gesetzt werden: 


Gratis Transaktions Limite
:      Definiert die maximale Anzahl gratis Transaktionen die pro Reset-Intervall getätigt werden können.

Gratis Gas Limite
:      Definiert die maximale Menge an Gas, die mit gratis Transaktionen, innerhalb eines Reset-Intervalls verbraucht werden können.

Revoke-Intervall
:      Anzahl Minuten für die ein Account, bei einer positiven Prüfung durch den Algorithmus, von der Whitelist gelöscht wird. 


Folgende Parameter gelten für alle Accounts:

Reset-Intervall
:     Einheit ist Minuten, definiert die Länge des Reset-Intervalls.


Standardwert gratis Transaktions Limite
:      Gilt für Accounts, die ohne Transaktionslimite erfasst werden. Definiert die maximale 
Anzahl gratis Transaktionen, die pro Reset-Intervall getätigt werden können.

Standardwert gratis Gas Limite
:     Gilt für Accounts, die ohne Gaslimite erfasst werden. Definiert die maximale 
Menge an Gas, die mit gratis Transaktionen innerhalb eines Reset-Intervalls verbraucht 
werden können.

Standardwert Revoke-intervall 
:     Gilt für Accounts die ohne
Revoke-Intervall erfasst werden. Definiert wie lange ein Account bei einem
Vergehen von der Whitelist suspendiert wird.

Bei der Konfiguration sollten die Abhängigkeiten zwischen den Parametern
geachtet werden. Verfügbares Gas, Anzahl Transaktionen und das Reset-Intervall
sollten immer zusammen konfiguriert werden. 
