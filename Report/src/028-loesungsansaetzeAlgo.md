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

Jeder Account verfügt über ein Kontingent von gratis Gas pro Zeitintervall. Dieser Ansatz berücksichtig die Komputationskosten, die von einer Transaktionen auf der Blockchain verursacht werden.  

#### Benutzermanagement

Für die Verwaltung der Accounts sind drei grundlegende Ansätze identifiziert worden. 

##### Kein Benutzermanagement

Die Parameter werden global definiert und gelten für alle Accounts. Das bedeuted, dass das Kontingent an gratis Transaktionen und gratis Gas für alle Accounts gleich hoch ist.

Dieser Ansatz ist sehr einfach zu implementieren, erlaubt aber keine Differenzierung bei den Accounts. Falls Bedarf besteht, die Parameter auch nur für einen Account zu ändern, müssen diese für alle angepasst werden.

##### Parameter über Gruppen konfigurierbar

Die Parameter sind über Gruppen konfiguriert. Jedem Account wird eine Gruppe zugewiesen, dieser erbt die Parameter der Gruppe. So lassen sich Strukturen der Schule, wie Klassen und Dozenten einfach abbilden. Die Konfiguration wird daruch intuitiv und effizient. 

Falls zu viele Gruppen definiert werden, verliert das System an Effizienz. Die Implementation von einem gruppenbasierten Benutzermanagement ist sehr komplex. 

##### Parameter pro Account konfigurierbar

Die Parameter sind bei jedem Account individuell konfigurierbar. Die Konfiguration auf Accountebene, bietet die höchste Granularität von allen Ansätzen. Das zur Folge, dass bei Änderungen alle Accounts einzeln angepasst werden müssen. Auch ist die Umsetzung von individuellen Parametern komplex. 

#### Konsequenzen

Falls die Prüfung durch den Algorithmus positiv ausfällt, wird der betreffende Account von der Whitelist gelöscht. In diesem Abschnitt sind mögliche Vorgehensweisen aufgeführt, um einen verdächtigen Account nach der Löschung, wieder zur Whitelist hinzuzufügen.

##### Fixer Zeitpunkt 

Es wird ein fixer Zeitpunkt definiert, bei dem alle Accounts zurückgesetzt werden. Das heisst das Kontingent wird bei allen Accounts wieder auf den konfigurierten Wert gesetzt. Von der Whitelist gelöschte Accounts werden dieser wieder hinzugefügt. Zum Beispiel könnte als Zeitpunkt Montag 8:00 UTC definiert werden.

Ein fixer Zeitpuntk ist sehr einfach umzusetzen. Allerdings werden dadurch die Accounts nicht mehr gleich behandelt. Wie lange ein Account keine gratis Transaktionen mehr tätigen kann, ist abhängig davon, zu welchem Zeitpunkt er von der Whitelist gelöscht wird. Wenn der gesetzte Zeitpunkt von den Benutzer identifiziert ist, kann das System missbraucht werden. Wenn man einen DoS Angriff kurz vor dem Resetzeitpunkt ausführt, hat es praktisch keine Folgen für den Benutzer. Sein Account wird zwar von der Whitelist entfernt, aber mit dem entsprechendem Zeitmanagement gleich wieder resettet. 

##### Nach definiertem Zeitintervall

Ein Account wird für eine definierte Dauer von der Whitelist gelöscht. Die Zeit wird ab der Löschung von der Whitelist gemessen. Dadurch werden bei einem Vergehen alle Accounts gleich lange von gratis Transaktionen ausgeschlossen. Da bei diesem Ansatz, der Zeitpunkt des Vergehens für jeden Account individuell verfolgt werden muss, ist er komplexer in der Umsetzung als ein fixer Zeitpunkt für einen Reset.  

##### Inkrementierendes Zeitintervall

Wie lange ein Account von der Whitelist entfernt wird, ist abhängig von der Anzahl bereits begangener Verstösse. Wiederholungstäter und somit eine potentiell grosse Gefahr für die Blockchain, werden mit diesem System sehr viel härter als Einzeltäter bestraft.  

Beispiel:

| # Verstösse | Dauer Sperrung  |
|:-----------:|-------------------:|
| 1 | 0.25  |
| 2 | 0.50|
| 3 | 2.00 |
| 4 | 6.00|
| 3 | 24.00|
| 4 | 168.00 |

Die Implemantation von diesem Ansatz ist sehr komplex. Für jeden Account muss die Dauer des Ausschlusses von gratis Transaktionen einzeln berechnet und überwacht werden. 

### Evaluation DoS Algorithmus

Es werden mehrer LA implementiert da sie kombinierbar sind.

//TODO Kriterien
//Gewichtung Kriterien
//Tabellarische Evaluation
//Erläuterung Evaluation