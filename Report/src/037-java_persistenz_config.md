
### Persistenz \label{prac_persistenz}

Um die Datenpersistenz zu gewährleisten, wird die Whitelist des
Transaktionsmanagers regelmässig in einer JSON-Datei gespeichert. 

Dafür wird die Datei ```AccountList.json``` verwendet. Diese muss im selben
Verzeichnis wie die ```.jar``` Datei des Transaktionsmanagers liegen.


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

remainingTransactions 
:     Mit diesem Feld wird bestimmt, über wie viele gratis
Transatkionen ein Account noch verfügt. Dieser Wert wird vom Transaktionsmanager
gepflegt und sollte nicht erfasst oder geändert werden. 

gasLimit
:    Definiert die maximale Anzahl gratis Gas, die ein Account während eines 
Reset-Intervalls verbrauchen darf. 

remainingGas 
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
der Datei ```AccountList.json``` mit dem Parameter ```deleteMe``` gemacht werden.



Mehr zur Konfigurationsdatei und Beispiele sind im nachfolgenden Abschnitt,
\ref{sec_prac_conf}, zu finden.\

#### Beispiele

Erfasst werden 3 Accounts. Vor Programmstart könnte die Datei so aussehen:

```{.json .numberLines caption="AccountList.json für die Erfassung von 4 Accounts. Datei vor Programmstart" label=li_accountList_before }
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

Unter \ref{li_accountList_before} ist die Erfassung von 4 Accounts gezeigt. Der
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

```{.json .numberLines caption="AccountList.json mit 4 Accounts. Datei nach Programmstart" label=li_accountList_after }
[
  {
    "address": "0xaf02DcCdEf3418F8a12f41CB4ed49FaAa8FD366b",
    "remainingTransactions": 8,
    "txLimit": 8,
    "revokeTime": 15,
    "gasLimit": 60000000,
    "remainingGas": 60000000,
    "deleteMe": false,
    "timeStamp": null
  },
  {
    "address": "0xf13264C4bD595AEbb966E089E99435641082ff24",
    "remainingTransactions": 5,
    "txLimit": null,
    "revokeTime": null,
    "gasLimit": null,
    "remainingGas": 50000000,
    "deleteMe": false,
    "timeStamp": null
  },
  {
    "address": "0x00a329c0648769A73afAc7F9381E08FB43dBEA72",
    "remainingTransactions": 5,
    "txLimit": null,
    "revokeTime": 25,
    "gasLimit": 999999999999999,
    "remainingGas": 999999999999999,
    "deleteMe": false,
    "timeStamp": null
  },
    {
    "address": "0xf1326lasdfaösLDFJDLSNd23nlDD35641082ff24",
    "transactionCounter": 5,
    "txLimit": null,
    "revokeTime": 2,
    "gasLimit": null,
    "remainingGas": 50000000,
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
konfiguriert werden.  Diese muss im selben
Verzeichnis wie die ```.jar``` Datei des Transaktionsmanagers liegen.


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
:      Der Standardwert für die Dauer der Suspendierung von
der Whitelist bei einem Vergehen.

certifierAddress 
:      Die Adresse des Certifiers. Er wird automatisch beim
Deployment des Certifiers gesetzt. Dieser Parameter sollte nicht bearbeitet
werden.

nameRegistryAddress 
:      Die Adresse der Name Registry. Hier muss dieselbe
Adresse wie in der Blockchainspezifikation verwendet werden. Siehe
\ref{sec_prac_spec}.

timestampLastReset 
:      Hier wird der Zeitpunkt des letzen Reset-Intervalls
vermerkt. Dieser Wert wird vom Transaktionsmanager gepflegt und sollte nicht
bearbeitet werden.


Eine weitere, sehr zentrale Konfiguration ist der Account des
Transaktionsmanagers. Dieser wird für jede Interaktion mit der Blockchain
verwendet. Um zu verhindern, dass dieser fix im Code eingetragen werden muss,
wird er ebenfalls aus einer Datei geladen. Hier wird die Datei
```TransaktionsManagerAccount.json``` verwendet. Diese muss im selben
Verzeichnis wie die ```.jar``` Datei des Transaktionsmanagers liegen.\

Die Datei hat nur einen einzigen Parameter:

```{.json .numberLines caption="TransaktionsManagerAccount.json mit einem privaten Schlüssel"  label=li_masterKey}
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

