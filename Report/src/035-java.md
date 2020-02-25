
## Externes Programm  \label{sec_prac_ext_prog}

In diesem Kapitl ist die Implementierung des externen Programms zur Überwachung
der Whitelist in Parity beschrieben. Anhand von Codeausschnitten ist die
Funktionsweise von einzelnen Komponenten näher erklärt. 

### Wrapperklassen

Für die Interaktion mit Smart Contracts werden generierte Wrapperklassen
verwendet. Es ist je eine Wrapperklasse für die Name Registry und den Certifier
vorhanden. Für dessen Generierung und Verwendung siehe
\ref{sec_prac_deployment}.

### Überwachung von Transaktionen

Um die Transaktionen auf der Blockchain zu Observieren wird ein
Filter[@web3j_filter] von Web3j verwendet. Dieser erlaubt es uns, eine
```Subscription``` zu erstellen. Diese läuft asynchron in einem eigenen Thread.\
Jede getätigte Transaktion wird von der ```Subscription``` erfasst. Es werden
jedoch nur Transaktionen genauer untersucht, die einen Gas Preis von Null
aufweisen. 

//TODO

### Initialisierung

Erstes Mal starten ++ Deployment 

### DoS Algorithmus

//TODO

### Persistenz

Um die Datenpersistenz zu gewährleisten, werden diese in einer Textdatei
gespeichert. Wird das Programm gestoppt, kann so bei beim nächsten Start der
letzte Zustand wieder hergestellt werden.\

In dieser Datei sind nebst allen konfigurierbaren Parameter, auch alle Accounts
die auf der Whitelist sind erfasst. Nach einem Programmstop, wird die Datei
ausgelesen. Alle Parameter werden wieder gesetzt. Alle Accounts werden geladen
und überprüft, ob sie sich noch auf der Whitelist befinden. Falls nötig, werden
sie erneut certifiziert oder permanent von der Whitelist gelöscht. Mehr zur
Konfigurationsdatei ist im nachfolgenden Abschnitt, \ref{sec_prac_conf}, zu
finden.\


#### Konfiguration \label{sec_prac_conf}

Die Konfiguration des Programmes findet mit einer Textdatei statt. In dieser
werden alle Accounts angegeben, welche auf die Whitelist sollen. Weiter werden
die Schwellenwerte für den DoS Algorithmus angegeben.

Die Konfigurationsdatei wird zeilenweise interpretiert. Das Einlesen der Datei
hat keine Fehlertoleranz. Daher muss die hier beschriebene Struktur stets
eingehalten werden.\ Wie unter \ref{sec_algConf} erläutert, gibt es
Einstellungen pro Account und solche die global gelten. In der ersten Zeile der
Datei werden alle globalen Parameter in folgender Reihenfolge aufgelistet:

1. Reset-Intervall in Minuten
2. Revoke-Intervall
3. Standardwert für gratis Transaktionen
4. Standardwert für gratis Gas

Es müssen alle vier Parameter angegeben und mit einem ```;``` separiert werden. 

Alle nachfolgenden Zeilen enthalten jeweils eine Accountadresse. Zusätzlich kann
die Anzahl gratis Transaktionen und die Menge gratis Gas pro Account definiert
werden. Hier muss beachtet werden, dass es nicht möglich ist, nur einen der
fakultativen Parameter anzugeben. Es müssen beide angegeben werden.\
Ab Zeile 2 müssen die Parameter folgendermassen angegeben werden:

1. Accountadresse
1. Anzahl Vergehen 
1. Anzahl verbleibende Revoke-Intervalls 
2. [Anzahl gratis Transaktionen]
3. [Menge an gratis Gas]

#### Beispiel

Ein mögliche Konfigurationsdatei könnte folgendermassen ausehen: 

```{.numberLines}
2;3;10;50000000;
0xaf02DcCdEf3418F8a12f41CB4ed49FaAa8FD366b;0;0;5;100000
0xf13264C4bD595AEbb966E089E99435641082ff24;0;0
0x00a329c0648769A73afAc7F9381E08FB43dBEA72;0;5;3;500000
```

Zeile 1
:     Reset-Intervall mit 2 Minuten, Revoke-Intervall mit einem Multiplikator 
von 3, den Standardwert für gratis Transaktionen mit 10 und der Standardwert 
für gratis Gas mit 50'000'000 Einheiten. 

Zeile 2
:     Accountadresse mit individuell konfigurierten Parametern. Der Account 
ist noch nie von der Whitelist suspendiert worden und hat auch keine verbleibenden 
Revoke-Intervalls. Das heisst, der Account ist auf der Whitelist. Der Account kann 
also 5 gratis Transaktionen oder 100'000 Gaseinheiten pro Reset-Intervall verbrauchen. 

Zeile 3
:     Eine Accountadresse ohne individuelle Parameter. Auch dieser Account wurde 
noch nie suspendiert und hat keine verbleibenden Revoke-Intervalls. Dieser Account 
wird mit Standardwerten versehen. Er kann also 10 gratis Transaktionen oder 50'000'000 
Einheiten Gas pro Reset-Intervall verbrauchen. 

Zeile 4
:     Accountadresse mit individuell konfigurierten Parametern. Dieser Account wurde 
bereits 1 Mal suspendiert. Er befindet sich zur Zeit nicht auf der Whitelist, da er noch 
für 5 weitere Revoke-Intervalle suspendiert ist. Der Account kann, sobald der Zähler 
für Revoke-Intervalle wieder auf 0 ist, 3 gratis Transaktionen oder 50'000 Gaseinheiten 
pro Reset-Intervall verbrauchen. 




