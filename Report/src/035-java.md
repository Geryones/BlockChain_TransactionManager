
## Transaktionsmanager  \label{sec_prac_ext_prog}

In diesem Kapitl ist die Implementierung des Transaktionsmanagers zur Überwachung
der Whitelist in Parity beschrieben. Anhand von Codeausschnitten ist die
Funktionsweise von einzelnen Komponenten näher erklärt. 

### Wrapperklassen

Für die Interaktion mit Smart Contracts werden generierte Wrapperklassen
verwendet. Es ist je eine Wrapperklasse für die Name Registry und den Certifier
vorhanden. Für dessen Generierung und Verwendung siehe
\ref{sec_prac_deployment}.

### Überwachung von Transaktionen

Um die Transaktionen auf der Blockchain zu Observieren wird ein
Filter[@web3j_filter] von Web3j verwendet. Dieser erlaubt es, eine
```Subscription``` zu erstellen. Diese läuft asynchron in einem eigenen Thread.\
Jede getätigte Transaktion wird von der ```Subscription``` erfasst. In einem
ersten Schritt wird der verwendete Gas Preis der Transaktion betrachtet. Nur
wenn dieser null ist, wird die Transaktion und der dazugehörende Account durch
den DoS Algorithmus evaluiert. 


![Prozess bei der Überwachung von Transaktionen \label{img_prac_interactions}](images/process_whitelist.png "Überwachung von gratis Transaktionen durch Java Programm")

Auf der Abbildung \ref{img_prac_interactions} sind die Interaktionen zwischen
dem Transaktionsmanager, der Blockchain und den Benutzern gezeigt. Transaktionen
sind mit "TX" abgekürzt.\
Links auf dem Diagramm sind die Benutzer "A" und "C" mit ihrem jeweiligen
Account abgebildet. In der Liste ```Accounts``` im Java-Programm sind alle
Accounts erfasst, die für gratis Transaktionen berechtigt sind. Hier ist für
jeden Account vermerkt, wie viele gratis Transaktionen und wie viel gratis Gas
im aktuellen Resett-Intervall bereits verbraucht wurde.\
Die beiden Benutzer erstellen je eine Transaktion mit einem Gas Preis von
null. Diese werden an den Parity Node übermittelt.\
Beim Node wird geprüft, ob der Sender in der Whitelist erfasst ist. Dieser
Vorgang ist unter \ref{prac_nameRegistry_Certifier} genauer erklärt. Der Account
von Benutzer C ist nicht erfasst. Daher wird seine Transaktion vom Node
abgelehnt. Der Benutzer C erhält einen Error, da er einen ungültigen Gas Preis
verwendet hat.\
Die Transaktion von Benutzer A wird vom Node akzeptiert, da sein Account in der
Whitelist erfasst ist. Die Transaktion wird anschliessend verarbeitet und in den
nächsten Block aufgenommen.\
Die Subscription im Java-Programm registriert, dass eine neue Transaktion in die
Blockchain aufgenommen worden ist. Die Daten der Transaktion werden heruntergeladen.
Der verwendete Gas Preis wird überprüft. Bei einem Gas Preis ungleich null, wird
die Transaktion nicht weiter betrachtet.\
Falls bei der Transaktion ein Gas Preis von null festgestellt worden ist, wird
der Sender ermittelt, in diesem Fall der Account XX. Die Zähler des Accounts
werden in der Liste ```Accounts``` aktualisiert. Der Account wird anschliessend
an den DoS Algorithmus übergeben.\
Im DoS Algorithmus wird die Anzahl getätigter gratis Transaktionen und das
verbrauchte Gas ausgewertet. Es wird geprüft, ob mit der neu erfassten
Transaktion ein Grenzwert im aktuellen Resett-Intevall überschritten worden ist.
Wenn das nicht der Fall ist, sind keine weiteren Aktionen nötig. Ist ein
Grenzwert überschritten worden, wird dies für den entsprechenden Account in
```Accounts``` festgehalten. Zusätzlich wird eine Transaktion erstellt, die den
Account von der Whitelist in Parity entfernt.

### Command Pattern und Priority Queue

Für die Handhabung des Resett-Intervalls und Suspendierungen von der Whitelist,
wird ein Command-Pattern[@wiki_command_pattern] verwendet. Die Commands werden mit einem Zeitstempel
versehen. Dieser gibt an, wann die Methode ```execute()``` ausgeführt werden
soll.\
Für die Zeitgerechte Ausführung wird eine Priority-Queue[@java_priority_queue]
verwendet. In einem eigenen Prozess, wird im Sekundentakt geprüft, ob der
Zeitpunkt für die Ausführung des anstehenden Commands gekommen ist.\
Für das Zurücksetzen aller Accountparameter wird das ```ResetAccountsCommand```
verwendet.

```{.java .numberLines caption="ResetAccountsCommand um die Accountparameter zurückzusetzen" label=li_resetAccountsCommand}
    @Override 
    public void execute() {
        log.info(new Date().toString());
        this.setAllCountersToMax();
        this.jsonDefaultSettingsHandler.getDefaultSettings()
                .setTimestampLastReset(new Timestamp(System.currentTimeMillis()));
        this.jsonAccountHandler.writeAccountList();
        this.jsonDefaultSettingsHandler.writeDefaultSettings();

        DoSAlgorithm.getInstance().offerCommand(new ResetAccountsCommand());
    }

```

Der Codeausschnitt \ref{li_resetAccountsCommand} zeigt die ```execute``` Methode
des ```ResetAccountsCommand```. Dieses Command wird am Ende eines
Resett-Intervalls ausgeführt. Auf Zeile 4 bis 8, werden zuerst alle Accounts
zurückgesetzt und der Zeitpunkt der Ausführung wird in den DefaultSettings
gespeichert. Anschliessend werden die Dateien ```AccountList.json``` und
```DefaultSettings.json``` neu geschrieben.\
Auf Zeile 10 wird rekursiv, das nächste ```ResetAccountsCommand``` erstellt und
in die Priority Queue gelegt. Im Constructor des neuen Commands, wird der
Zeitpunkt für dessen Durchführung mit den DefaultSettings berechnet. 


