### DoS-Algorithmus

//TODO Spellcheck 

In diesem Abschnitt sind die Komponenten des DoS-Algorithmus aufgeführt.
Verschiedene Parameter und deren Verwendung werden untersucht. Die Behandlung
von Accounts, die vom Algorithmus als Gefahr identfiziert werden, wird ebenfalls
evaluiert. 

#### Parameter \label{sec_dla_params}

Um zu bewerten, ob ein Account eine Gefahr für die Blockchain darstellt, braucht
ein Algorithmus Parameter. Diese werden durch die Überwachung von getätigten
gratis Transaktionen gesammelt. Dabei muss jeweils pro Account entschieden
werden, ob ein Verhalten eine Gefahr darstellt. Nachfolgend sind mögliche
Parameter für die Berurteilung von Accounts aufgeführt. 

##### Sender 

Dieser Parameter ist zwingend nötig um eine gratis Transaktionen mit einem
Account zu verknüpfen. 

##### Empfänger

Eine Transaktion wird immer an eine Adresse gesendet. Hierbei kann es sich
sowohl um einen Benutzeraccount oder einen Smart Contract handeln. 

##### Reset-Intervall 

Alle Interaktionen auf der Blockchain müssen relativ zu einem Zeitintervall
bewertet werden. Hier werden zwei unterschiedliche Ansätze untersucht: 

Allgemeines Intervall :      Gratis Transaktionen werden für alle Accounts im
selben Zeitintervall betrachtet. Der Zeitpunkt ist relativ zum Programmstart.
Beispielsweise ist als Intervall eine Stunde gesetzt und der Progammstart
erfolgt um 8:00 UCT. Dadurch sind gratis Transaktionen die um 08:59 UTC gemacht
werden, um 09:01 UTC nicht mehr relevant für die Beurteilung. Das hat zur Folge,
dass Benutzer alle zulässigen Aktionen direkt vor und noch einmal, nach Ablauf
eines Intervalls ausführen können.  

Individuelles Intervall :      Das Intervall ist relativ zum Zeitpunkt einer
getätigter gratis Transaktionen. Bei einer Prüfung wird untersucht, wie viele
gratis Transaktionen der betroffene Account im vergangenen Zeitintervall,
gerechnet ab dem Zeitpunkt der Prüfung, getätigt hat. Mit den selben
Startparametern wie im oben aufgeführten Beispiel, ist eine um 08:59 UTC
getätigte gratis Transaktion bis 09:59 relevant. 

##### Anzahl getätigte Transaktionen

Pro Account wird verfolgt, wie viele gratis Transaktionen pro Zeitintervall
gemacht werden. Hier werden die Transaktionen unabhängig von Typ oder
verursachten Komputationskosten auf der Blockchain gezählt. 

##### Anzahl verbrauchtes Gas

Pro Account wird verfolgt, wie viel Gas pro Zeitintervall auf der Blockchain
durch dessen gratis Transaktionen verbraucht wird. Im Gegensatz zum oben
genannten Parameter, werden hier die verursachten Komputationskosten auf der
Blockchain berücksichtigt. 










#### Wiederaufnahme auf die Whitelist

Falls die Prüfung durch den Algorithmus positiv ausfällt, wird der betreffende
Account von der Whitelist gelöscht. In diesem Abschnitt sind mögliche
Vorgehensweisen aufgeführt, um einen Account nach der Löschung automatisch
wieder zur Whitelist hinzuzufügen.

##### Fixer Zeitpunkt für alle

Es wird ein fixer Zeitpunkt definiert, bei dem alle Accounts zurückgesetzt
werden. Das heisst das Kontingent wird bei allen Accounts wieder auf den
konfigurierten Wert gesetzt. Von der Whitelist gelöschte Accounts werden dieser
wieder hinzugefügt. Zum Beispiel könnte als Zeitpunkt Montag 8:00 UTC definiert
werden.

##### Nach Zeitintervall

Ein Account wird für eine definierte Dauer von der Whitelist gelöscht. Die Zeit
wird ab der Löschung von der Whitelist gemessen. Dadurch werden bei einem
Vergehen alle Accounts gleich lange von gratis Transaktionen ausgeschlossen.  

##### Inkrementierendes Zeitintervall

Wie lange ein Account von der Whitelist entfernt wird, ist abhängig von der
Anzahl bereits begangener Verstösse. 

Beispiel:

| # Verstösse | Dauer Sperrung  |
|:-----------:|-------------------:|
| 1 | 0.50  |
| 2 | 1.00|
| 3 | 3.00 |
| 4 | 12.00|
| 5 | 60.00|
| 6 | 360.00 |

In der oben aufgeführten Tabelle ist ersichtlich, dass die Dauer der Sperrung
proportional zu den Verstössen ist. 








#### Benutzermanagement


Bei der Verwaltung von Accounts geht es darum, wie die vorhergehenden Parameter
und Intervalle auf die Accounts angewendet werden. Es werden drei Mögliche
Ansätze betrachtet. 

##### Kein Benutzermanagement \label{sec_dla_usermngmt_none}

Die Parameter werden global konfiguriert und gelten für alle Accounts. Eine
Differenzierung von Accounts ist somit nicht möglich. 

##### Parameter über Gruppen konfigurierbar

Die Parameter sind über Gruppen konfiguriert. Jedem Account wird eine Gruppe
zugewiesen, dieser erbt die Parameter der Gruppe. So lassen sich Strukturen der
Schule, wie Studenten, Dozenten und Klassen einfach abbilden. 

##### Parameter pro Account konfigurierbar

Die Parameter sind bei jedem Account individuell konfigurierbar. 

