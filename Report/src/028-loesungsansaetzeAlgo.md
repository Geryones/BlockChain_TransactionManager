### DoS-Algorithmus

//TODO Spellcheck 

In diesem Abschnitt ist der erarbeitete DoS-Algorithmus-Lösungsansatz aufgeführt. Der Algorithmus wird verwendet um getätigte gratis Transaktionen zu überwachen und falls nötig einzuschränken. Wird ein Account als Bedrohung für die Blockchain eingestuft, wird dieser Account von der Whitelist gelöscht. 

#### Parameter \label{sec_dla_params}

Um zu bewerten, ob ein Account eine Gefahr für die Blockchain darstellt, braucht ein Algorithmus Parameter. Diese werden durch die Überwachung von getätigten gratis Transaktionen gesammelt. Dabei muss jeweils pro Account entschieden werden, ob ein Verhalten eine Gefahr darstellt. Nachfolgend sind mögliche Parameter für die Berurteilung von Accounts aufgeführt. 

##### Sender 

Dieser Parameter ist zwingend nötig um eine gratis Transaktionen mit einem Account zu verknüpfen. 

##### Empfänger

Eine Transaktion wird immer an eine Adresse gesendet. Hierbei kann es sich sowohl um einen Benutzeraccount oder einen Smart Contract handeln. 

Der Empfänger kann von Sender frei gewählt werden. Es wird auch kein Einverständnis des Empfängers für eine Transaktion benötigt. Jeder Benutzer ist in der Lage, selbst neue Accounts zu erstellen und diese als Empfänger zu verwenden. 

##### Relevantes Zeitintervall

Alle Interaktionen auf der Blockchain müssen relativ zu einem Zeitintervall bewertet werden. Absolute Werte über die gesammte Lebensdauer einer Blockchain sind nicht aussagekräftig. 

Hier werden zwei unterschiedliche Ansätze untersucht: 

Intervall für alle Accounts
:      Gratis Transaktionen werden für alle Accounts im selben Zeitintervall betrachtet. Zum beispiel werden die Zähler für getätigte gratis Transaktionen für alle Accounts im 10 Minuten Takt zurückgesetzt. Der Zeitpunkt ist relativ zum Programmstart.

Individuelles Intervall
:      Das Intervall ist relativ zum Zeitpunkt getätigter gratis Transaktionen. Bei einer Prüfung wird untersucht, wie viele gratis Transaktionen ein Account im vergangenen Zeitintervall, gerechnet ab dem Zeitpunkt der Prüfung, getätigt hat.  

##### Anzahl getätigte Transaktionen

Pro Account wird verfolgt, wie viele gratis Transaktionen pro Zeitintervall gemacht werden. Hier werden die Transaktionen unabhängig von Typ oder verursachten Komputationskosten auf der Blockchain gezählt. 

##### Anzahl verbrauchtes Gas

Pro Account wird verfolgt, wie viel Gas pro Zeitintervall auf der Blockchain durch dessen gratis Transaktionen verbraucht wird. Im Gegensatz zum oben genannten Parameter, werden hier die verursachten Komputationskosten auf der Blockchain berücksichtigt. 
Transaktionen mit einem sehr hohen Gas-Bedarf können für eine DoS-Attacke verwendet werden. Da beim Angreifer mit gratis Transaktionen keine Mehrkosten anfallen, ist dieser Angriff der wahrscheinlichste. 









#### Wiederaufnahme auf die Whitelist

Falls die Prüfung durch den Algorithmus positiv ausfällt, wird der betreffende Account von der Whitelist gelöscht. In diesem Abschnitt sind mögliche Vorgehensweisen aufgeführt, um einen Account nach der Löschung automatisch wieder zur Whitelist hinzuzufügen.

##### Fixer Zeitpunkt 

Es wird ein fixer Zeitpunkt definiert, bei dem alle Accounts zurückgesetzt werden. Das heisst das Kontingent wird bei allen Accounts wieder auf den konfigurierten Wert gesetzt. Von der Whitelist gelöschte Accounts werden dieser wieder hinzugefügt. Zum Beispiel könnte als Zeitpunkt Montag 8:00 UTC definiert werden.

Ein fixer Zeitpuntk ist sehr einfach umzusetzen. Allerdings werden dadurch die Accounts nicht mehr gleich behandelt. Wie lange ein Account keine gratis Transaktionen mehr tätigen kann, ist abhängig davon, zu welchem Zeitpunkt er von der Whitelist gelöscht wird. Wenn der gesetzte Zeitpunkt von den Benutzer identifiziert ist, kann das System missbraucht werden. Wenn man einen DoS Angriff kurz vor dem Resetzeitpunkt ausführt, hat es praktisch keine Folgen für den Benutzer. Sein Account wird zwar von der Whitelist entfernt, aber mit dem entsprechendem Zeitmanagement gleich wieder resettet. 

##### Nach Zeitintervall

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







#### Benutzermanagement

Für die Verwaltung der Accounts sind drei grundlegende Ansätze identifiziert worden. 

##### Kein Benutzermanagement \label{sec_dla_usermngmt_none}

Die Parameter werden global definiert und gelten für alle Accounts. Das bedeuted, dass das Kontingent an gratis Transaktionen und gratis Gas für alle Accounts gleich hoch ist.

Dieser Ansatz ist sehr einfach zu implementieren, erlaubt aber keine Differenzierung bei den Accounts. Falls Bedarf besteht, die Parameter auch nur für einen Account zu ändern, müssen diese für alle angepasst werden.

##### Parameter über Gruppen konfigurierbar

Die Parameter sind über Gruppen konfiguriert. Jedem Account wird eine Gruppe zugewiesen, dieser erbt die Parameter der Gruppe. So lassen sich Strukturen der Schule, wie Klassen und Dozenten einfach abbilden. Die Konfiguration wird daruch intuitiv und effizient. 

Falls zu viele Gruppen definiert werden, verliert das System an Effizienz. Die Implementation von einem gruppenbasierten Benutzermanagement ist sehr komplex. 

##### Parameter pro Account konfigurierbar

Die Parameter sind bei jedem Account individuell konfigurierbar. Die Konfiguration auf Accountebene, bietet die höchste Granularität von allen Ansätzen. Das zur Folge, dass bei Änderungen alle Accounts einzeln angepasst werden müssen. Auch ist die Umsetzung von individuellen Parametern komplex. 









### Evaluation DoS-Algorithmus
// TODO

In diesem Abschnitt werden die Aspekte des Algorithmus evaluiert. 

#### Parameter

Die aufgeführten Parameter werden auf ihre Relevanz geprüft. 

##### Sender

ist zwingend nötig um eine Transaktion einem Account zuweisen zu können. 

##### Empfänger

Der Emfänger kann vom Sender frei bestimmt werden und hat somit keine Aussagekraft. Er wird vom Algorithmus nicht berücksichtigt. 

##### Zeitintervall 



##### Anzahl gratis Transaktionen

Dieser Parameter ist für die Beurteilung einer Gefahr von zentraler Bedeutung und wird daher pro Account überwacht und gespeichert. Der gespeicherte Zähler wird abhängig vom definierten Zeitintervall bewertet und zurückgesetzt.

##### Anzahl verbrauchtes Gas

Da wiederholtes ausführen von gratis Transaktionen mit einem sehr hohen Gas-Bedarf für eine DoS-Attacke verwendet werden können, wird dieser Parameter für die Beurteilung von Bedrohungen verwendet. 

#### Wiederaufnahme auf die Whitelist

wird eine Hybridlösung zwischen fixem Zeitpunkt und einen Zeitintervall verfolgt.  

#### Benutzermanagement

 wird für jeden Account individuell definiert. Dieser Ansatz wurde über einem gruppenbasierten Benutzermanagement gewählt, da die Umsetzung einfacher ist und somit in der verbleibenden Zeit realisiert werden kann. Kein Benutzermanagent wird nicht als praktikabel bewertet. Die Betreiber brauchen eine Möglichkeit um einzelne Accounts speziell zu parametrisieren. Zum Beispiel ist es sinnvoll, wenn Dozenten einen höheren Schwellenwert haben. Um einen Unterricht vorzubereiten ist es wahrscheinlich, dass viele Transaktionen getätigt oder grosse Smart Contracts deployed werden müssen. 

Es wird erwartet, dass für die Mehrheit der Accounts kein Bedarf an individuellen Parametern besteht. Um diesen Umstand gerecht zu werden, werden Standardparameter angeboten. Diese sind konfigurierbar und gelten für Accounts bei denen keine Parameter angegeben werden. So kann die Mehrheit der Accounts über die Standardparameter und Ausnahmen individuell konfiguriert werden.  