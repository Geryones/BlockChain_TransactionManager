
### Evaluation DoS-Algorithmus
// TODO

In diesem Abschnitt werden die Komponenten des Algorithmus evaluiert. 

#### Parameter

Die aufgeführten Parameter werden auf ihre Relevanz geprüft. 

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

Wir haben uns entschieden, eine Kombination aus einem fixen Zeitpunkt und einem inkrementierenden Intervall zu verwenden. Dieser Ansatz ist in der gegebenen Zeit realisierbar und bietet nebst einem effizienten Schutz auch eine Toleranz für einmalige Verstösse.
Die Dauer einer Suspendierung von der Whitelist kann mit dem Parameter "Revoke-Faktor" konfiguriert werden. Als Basis wird das Reset-Intervall verwendet. Ein Account kann für ein Vielfaches dieses Intervalls von der Whitelist ausgeschlossen werden. 

$t = resInter * revFak * v$

Wobei $t$ die Dauer der Suspendierung, $resInter$ das Reset-Intervall, $revFak$ ist der Revoke-Faktor und $v$ ist die Anzahl bereits begangener Verstösse. 



#### Benutzermanagement

 wird für jeden Account individuell definiert. Dieser Ansatz wurde über einem gruppenbasierten Benutzermanagement gewählt, da die Umsetzung einfacher ist und somit in der verbleibenden Zeit realisiert werden kann. Kein Benutzermanagent wird nicht als praktikabel bewertet. Die Betreiber brauchen eine Möglichkeit um einzelne Accounts speziell zu parametrisieren. Zum Beispiel ist es sinnvoll, wenn Dozenten einen höheren Schwellenwert haben. Um einen Unterricht vorzubereiten ist es wahrscheinlich, dass viele Transaktionen getätigt oder grosse Smart Contracts deployed werden müssen. 

Es wird erwartet, dass für die Mehrheit der Accounts kein Bedarf an individuellen Parametern besteht. Um diesen Umstand gerecht zu werden, werden Standardparameter angeboten. Diese sind konfigurierbar und gelten für Accounts bei denen keine Parameter angegeben werden. So kann die Mehrheit der Accounts über die Standardparameter und Ausnahmen individuell konfiguriert werden.  