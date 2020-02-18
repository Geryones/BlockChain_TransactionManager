
### Evaluation DoS-Algorithmus
// TODO

In diesem Abschnitt werden die Komponenten des Algorithmus evaluiert. 

#### Parameter

Die aufgeführten Parameter werden auf ihre Relevanz geprüft. 

##### Sender

Ist zwingend nötig um eine Transaktion einem Account zuweisen zu können. 

##### Empfänger

Dieser kann vom Sender frei bestimmt werden und hat somit keine Aussagekraft. Er wird vom Algorithmus nicht berücksichtigt. 

##### Relevantes Zeitintervall für die Beurteilung einer Gefahr 

Wir haben uns für die Implementierung eines allgemeinen Intervalls entschieden. Der Ansatz ist bedeutend einfacher umzusetzen als ein individuelles Intervall und kann daher sicher in der gegebenen Zeit realisiert werden. 

Die Auswirkung des genanten Nachteils beim allgemeinen Intervall ist stark von dessen Länge abhängig. Je kürzer das Intervall gewählt wird, umso kleiner sind die möglichen Folgen.

##### Anzahl gratis Transaktionen

Dieser Parameter ist für die Beurteilung einer Gefahr von zentraler Bedeutung und wird daher pro Account überwacht und gespeichert. Der gespeicherte Zähler wird abhängig vom oben erwähten Zeitintervall bewertet.

##### Anzahl verbrauchtes Gas

//TODO Referenz auf DoS Abschnitt
Transaktionen mit einem sehr hohen Gas-Bedarf können für eine DoS-Attacke verwendet werden. Da beim Angreifer mit gratis Transaktionen keine Mehrkosten anfallen, ist dieser Angriff der wahrscheinlichste.

#### Wiederaufnahme auf die Whitelist

wird eine Hybridlösung zwischen fixem Zeitpunkt und einen Zeitintervall verfolgt.  

#### Benutzermanagement

 wird für jeden Account individuell definiert. Dieser Ansatz wurde über einem gruppenbasierten Benutzermanagement gewählt, da die Umsetzung einfacher ist und somit in der verbleibenden Zeit realisiert werden kann. Kein Benutzermanagent wird nicht als praktikabel bewertet. Die Betreiber brauchen eine Möglichkeit um einzelne Accounts speziell zu parametrisieren. Zum Beispiel ist es sinnvoll, wenn Dozenten einen höheren Schwellenwert haben. Um einen Unterricht vorzubereiten ist es wahrscheinlich, dass viele Transaktionen getätigt oder grosse Smart Contracts deployed werden müssen. 

Es wird erwartet, dass für die Mehrheit der Accounts kein Bedarf an individuellen Parametern besteht. Um diesen Umstand gerecht zu werden, werden Standardparameter angeboten. Diese sind konfigurierbar und gelten für Accounts bei denen keine Parameter angegeben werden. So kann die Mehrheit der Accounts über die Standardparameter und Ausnahmen individuell konfiguriert werden.  