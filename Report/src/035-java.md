
## Transaktionsmanager  \label{sec_prac_ext_prog}

In diesem Kapitl ist die Implementierung des Transaktionsmanagers zur Überwachung
der Whitelist in Parity beschrieben. Anhand von Codeausschnitten ist die
Funktionsweise von einzelnen Komponenten näher erklärt. 

### Wrapperklassen

Für die Interaktion mit Smart Contracts werden generierte Wrapperklassen
verwendet. Es ist je eine Wrapperklasse für die Name Registry und den Certifier
vorhanden. Für dessen Generierung und Verwendung siehe
\ref{sec_prac_deployment}.

### Initialisierung

Wenn die Blockchain frisch aufgesetzt wird, sind inital keine gratis
Transaktionen möglich. Der dafür nötige Certifier ist noch nicht deployed oder
bei der Name Registry registriert.\
Mit der Methode ```init``` in der Klasse ```Main``` wird die Blockchain für den
Betrieb vorbereitet. Folgende Schritte werden dabei ausgeführt:

1. Instanzierung der Name Registry\
   Mit der Wrapperklasse für die Name Registry und deren Adresse auf der
   Blockchain wird ein Objekt für die Interaktion mit dem eigentlichen Smart
   Contract erzeugt. 
1. Deployment des Certifiers\
   Die Wrapperklasse für den Certifier wird instanziert und auf die Blockchain
   deployed. 
1. Registrierung des Certifiers bei der Name Registry\
   Die Adresse des Certifiers wird bei der Name Registry registriert.
1. Zertifizierung von Account für Transaktionsmanager\
   Der Account des Transaktionsmanagers wird für gratis Transaktionen
   berechtigt. 

Siehe \ref{sec_prac_deployment} für mehr Informationen zu Wrapperklassen,
Deployment und Registrierung von Accounts.

Die Adresse der Name Registry wird aus der Konfigurationsdatei gelesen, siehe
\ref{sec_prac_conf}. Hier muss beachtet werden, dass diese mit der Adresse in
der Blockchainspezifkation, siehe \ref{sec_prac_spec}, übereinstimmen muss.\
Sobald der Certifier deployed ist, wird dessen Adresse in die
Konfigurationsdatei geschrieben. Sobald die Überwachung der Blockchain gestartet
wird, wird die Adresse ausgelesen und der Certifier instanziert.\
Der Account für den Transaktionsmanger wird in der Blockchainspezifikation
definiert, siehe \ref{sec_prac_spec}. Dieser Account wird verwendet um
Änderungen an der Whitelist vorzunehmen. Aus Sicherheitsgründen wird der private
Schlüssel von diesem Account nicht in den Quellcode des Transaktionsmanagers
geschrieben. Er wird beim Start der Applikation aus einer eigenen Datei gelesen.
Hier muss beachtet werden, dass diese Datei bei der Verwendung von einer
Versionierungssoftware nicht inkludiert wird.



### DoS Algorithmus

//TODO

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
im aktuellen Reset-Intervall bereits verbraucht wurde.\
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
Transaktion ein Grenzwert im aktuellen Reset-Intevall überschritten worden ist.
Wenn das nicht der Fall ist, sind keine weiteren Aktionen nötig. Ist ein
Grenzwert überschritten worden, wird dies für den entsprechenden Account in
```Accounts``` festgehalten. Zusätzlich wird eine Transaktion erstellt, die den
Account von der Whitelist in Parity entfernt.


### Persistenz \label{prac_persistenz}

Um die Datenpersistenz zu gewährleisten, wird die Whitelist des
Transaktionsmanagers in einer JSON-Datei gespeichert. 

Dafür wird die Datei ```AccountList.json``` verwendet. Relativ zur JAR-Datei des
Transatkionsmanagers muss sie in folgendem Verzeichnis liegen: 

//TODO Filepath

In dieser Datei sind alle Accounts, die auf der Whitelist sind erfasst. Bei
jedem Account können die inidviduell konfigurierbaren Parameter gesetzt werden.\
Nach einem Programmstop, wird die Datei ausgelesen. Alle Accounts werden
geladen. Wo nötig, die individuellen Parameter gesetzt. Für alle Parameter die
nicht gesetzt sind, werden die konfigurierten Standardwerte verwendet, siehe \ref{sec_prac_conf} Parameter,
für die der Standardwert verwendet werden soll, können entweder mit Wert
```null``` erfasst oder ganz weggelassen werden. 

Die Datei ist als Array von Accounts aufgebaut. Für jeden Account sind folgende
Felder vorhanden:

address 
:     Die Adresse des Accounts. Das ist der einzige Parameter, der
zwingend definiert sein muss. 

txLimit
:     Definiert die maximale Anzahl gratis Transaktionen, die ein Account in 
einem Reset-Intervall tätigen darf. 

transactionCounter 
:     Mit diesem Feld wird bestimmt, über wie viele gratis
Transatkionen ein Account noch verfügt. Dieser Wert wird vom Transaktionsmanager
gepflegt und sollte nicht erfasst oder geändert werden. 

gasLimit
:    Definiert die maximale Anzahl gratis Gas, die ein Account während eines 
Reset-Intervalls verbrauchen darf. 

gasUsedCounter 
:     Mit diesem Feld wird bestimmt, über wie viel gratis Gas ein
Account noch verfügt. Dieser Wert wird vom Transaktionsmanager gepflegt und
sollte nicht erfasst oder geändert werden.

revokeTime 
:     Definiert, wie lange ein Account bei einem Vergehen von der
Whitelist suspendiert wird. Die Angabe ist in Minuten.

deleteMe 
:     Dieser Parameter wird nur verwendet, wenn ein Account permanent
von der Whitelist gelöscht werden soll. Nach dem der Account von der Whitelist
entfernt wurde, wird der Eintrag auch aus ```AccountList.json``` gelöscht.

timeStamp 
:     Definiert, wann ein Account wieder in die Whitelist aufgenommen
werden soll. Dieser Wert wird vom Transaktionsmanager gepflegt und sollte nicht
erfasst oder geändert werden.

Wenn der Transaktionsmanager die Datei neu schreibt, werden alle Parameter
geschrieben. Das bedeuted, Parameter die nicht gesetzt waren, sind nun mit einem
Wert ```null``` erfasst. Ausnahme sind ```gasUsedCounter``` und ```transactionCounter```, diese
werden mit der entsprechenden Limite initialisiert. 

Falls ein Account zum Zeitpunkt des Programmstops von gratis Transaktionen
suspendiert war, ist der ```timeStamp``` gesetzt. Sollte der Zeitpunkt in der
Vergangenheit liegen, wird der Account wieder certifiziert. Andernfalls wird er
erneut der Priority-Queue hinzugefügt und bleibt bis zum vorgesehenen Zeitpunkt
suspendiert.

Automatische Suspendierungen von Transaktionsmanager sind immer temporär. Soll
ein Account permanent von der Whitelist gelöscht werden, muss dies manuell in
der Datei ```AccountList.json``` mit dem Parameter ```deleteMe``` oder via
____________TODO Funktion CLI___________  gemacht werden.



Mehr zur Konfigurationsdatei und Beispiele sind im nachfolgenden Abschnitt,
\ref{sec_prac_conf}, zu finden.\

#### Beispiele

Erfasst werden 3 Accounts. Vor Programmstart könnte die Datei so aussehen:

```{caption="AccountList.json für die Erfassung von 4 Accounts. Datei vor Programmstart" label=li_accountList_before .json .numberLines}
[
  {
    "address": "0xaf02DcCdEf3418F8a12f41CB4ed49FaAa8FD366b",
    "txLimit": 8,
    "revokeTime": 15,
    "gasLimit": 60000000
  },
  {
    "address": "0xf13264C4bD595AEbb966E089E99435641082ff24"
  },
  {
    "address": "0x00a329c0648769A73afAc7F9381E08FB43dBEA72",
    "revokeTime": 25,
    "gasLimit": 999999999999999
   },
   {
    "address": "0xf1326lasdfaösLDFJDLSNd23nlDD35641082ff24"
    "revokeTime": 2
  }

]
```

Unter \ref{li_accountList_before} ist die Erfassung von 3 Accounts gezeigt. Der
erste verwendet überall individuelle Parameter.\
Der zweite Account hat keine Parameter und verwendet daher überall die Standardwerte.\
Beim dritten und vierten Account ist gezeigt, dass auch ganz selektiv, einzelne
Parameter gesetzt werden können.

Sobald die unter \ref{li_accountList_before} Liste von Accounts eingelesen und
verarbeitet wurde, wird sie vom Transaktionsmanager neu geschrieben. Das
Resultat ist abhängig von den konfigurierten Standardwerten, dazu mehr im
folgenden Kapitel \ref{sec_prac_conf}. Unter der Annahme, dass der Standarwert
für Transaktionen auf 5 und für Gas auf 50000000 konfiguriert ist, sieht die
Datei folgendermassen aus:

```{caption="AccountList.json mit 4 Accounts. Datei nach Programmstart" label=li_accountList_after .json .numberLines}
[
  {
    "address": "0xaf02DcCdEf3418F8a12f41CB4ed49FaAa8FD366b",
    "transactionCounter": 8,
    "txLimit": 8,
    "revokeTime": 15,
    "gasLimit": 60000000,
    "gasUsedCounter": 60000000,
    "deleteMe": false,
    "timeStamp": null
  },
  {
    "address": "0xf13264C4bD595AEbb966E089E99435641082ff24",
    "transactionCounter": 5,
    "txLimit": null,
    "revokeTime": null,
    "gasLimit": null,
    "gasUsedCounter": 50000000,
    "deleteMe": false,
    "timeStamp": null
  },
  {
    "address": "0x00a329c0648769A73afAc7F9381E08FB43dBEA72",
    "transactionCounter": 5,
    "txLimit": null,
    "revokeTime": 25,
    "gasLimit": 999999999999999,
    "gasUsedCounter": 999999999999999,
    "deleteMe": false,
    "timeStamp": null
  },
    {
    "address": "0xf1326lasdfaösLDFJDLSNd23nlDD35641082ff24",
    "transactionCounter": 5,
    "txLimit": null,
    "revokeTime": 2,
    "gasLimit": null,
    "gasUsedCounter": 50000000,
    "deleteMe": false,
    "timeStamp": null
  }
]

```

Das Listing \ref{li_accountList_after} zeigt die Datei ```AccountList.json```
nachdem der Transaktionmanger gestartet und die initiale Datei verarbeitet hat.
Überall wo ein Standardwert verwendet ist der Paramater mit einem Wert von
```null``` gesetzt worden. 


### Konfiguration \label{sec_prac_conf}

Der Transaktionsmanagers kann mit der Datei ```DefaultSettings.json```
konfiguriert werden. 

//TODO Filepath

Folgende Parameter sind unterstützt:

connectionAddress
:      URL um sich mit der Blockchain zu verbinden. 

resetInterval 
:      Definiert in welchem Intervall, die Zähler von allen
Accounts zurückgesetzt werden. Wird in Minuten angegeben.

defaultTXLimit
:      Der Standardwert für die gratis Transaktionslimite pro Account.

defaultGasLimit
:      Der Standardwert für die gratis Gaslimite pro Account.

defaultRevokeTime
:      Der Standardwert für die Dauer der Suspendierung von der Whitelist bei einem Vergehen.

certifierAddress 
:      Die Adresse des Certifiers. Er wird automatisch beim Deployment des Certifiers gesetzt. Dieser Parameter sollte nicht bearbeitet werden.

nameRegistryAddress
:      Die Adresse der Name Registry. Hier muss dieselbe Adresse wie in der Blockchainspezifikation verwendet werden. Siehe \ref{sec_prac_spec}.

timestampLastReset
:      Hier wird der Zeitpunkt des letzen Reset-Intervalls vermerkt. Dieser Wert wird vom Transaktionsmanager gepflegt und sollte nicht bearbeitet werden.


Eine weitere, sehr zentrale Konfiguration ist der Account des
Transaktionsmanagers. Dieser wird für jede Interaktion mit der Blockchain
verwendet. Um zu verhindern, dass dieser fix im Code eingetragen werden muss,
wird er ebenfalls aus einer Datei geladen. Hier wird die Datei
```TransaktionsManagerAccount.json``` verwendet.\

//TODO Filepath

Die Datei hat nur einen einzigen Parameter:

```{caption="TransaktionsManagerAccount.json mit einem privaten Schlüssel" .json .numberLines label=li_masterKey}
{
  "privateKey": "0x4d5db4107d237df6a3d58ee5f70ae63d73d7658d4026f2eefd2f204c81682cb7"
}
```

Die unter \ref{li_masterKey} gezeigte Datei beinhaltet den Account für den
Transaktionsmanager. Dieser sollte auf keinen Fall öffentlich gemacht werden.
Der hier gezeigte Schlüssel ist der Standardaccount im Entwicklungsmodus von
Parity.

#### Beispiel

Anbei ein Beispiel für ```DefaultSettings.json``` für eine frisch aufgesetzte Blockchain.

```{.json .numberLines caption="DefaultSettings.json" label=li_defaultSettings_before }
{
  "connectionAddress": "http://jurijnas.myqnapcloud.com:8545/",
  "resetInterval": 10,
  "defaultTxLimit": 5,
  "defaultGasLimit": 50000000,
  "defaultRevokeTime": 10,
  "certifierAddress": null,
  "nameRegistryAddress": "0x0000000000000000000000000000000000001337",
  "timestampLastReset": null
  
}
```
Unter \ref{li_defaultSettings_before} ist die Datei ```DefaultSettings.json```
abgebildet. So sieht die Datei aus, bevor der Transaktionsmanager den Certifier
deployed hat. 

```{.json .numberLines caption="DefaultSettings.json" label=li_defaultSettings_after }
{
  "connectionAddress": "http://jurijnas.myqnapcloud.com:8545/",
  "resetInterval": 10,
  "defaultTxLimit": 5,
  "defaultGasLimit": 50000000,
  "defaultRevokeTime": 10,
  "certifierAddress": "0xee35211c4d9126d520bbfeaf3cfee5fe7b86f221",
  "nameRegistryAddress": "0x0000000000000000000000000000000000001337",
  "timestampLastReset": "Mar 5, 2020 1:53:50 AM"
  
}
```

Listing \ref{li_defaultSettings_after} zeigt die Datei
```DefaultSettings.json``` nach dem der Certifier deployed wurde. Dessen Adresse
ist nun eingetragen. Weiter ist ein Zeitstempel gesetzt. 


