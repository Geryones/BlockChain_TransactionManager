

### Konfiguration der Blockchain \label{sec_prac_bc_config}

Parity wird mit der Konsole gestartet. Der Benutzer hat hier die Möglichkeit,
gewisse Parameter an Parity zu übergeben. Eine einfache Konfiguration ist somit
möglich. Für kompliziertere Konfigurationen wird die Verwendung von einer
Konfigurationsdatei empfohlen, diese ist im nächsten Abschnitt
\ref{sec_prac_config_toml} beschrieben.

Die hier gezeigte Konfiguration ist für die Entwicklung verwendet worden.
Hierbei ist es wichtig, dass Aktionen möglichst schnell auf der Blockchain
sichtbar sind. Aus diesem Grund ist eine Single Node Development Chain verwendet
worden. Ein Mining-Algorithmus ist daher nicht nötig.\
Für einen produktiven Betrieb sollte die Konfiguration auf die eigenen
Bedürfnisse geprüft und gegebenenfalls angepasst werden. 

#### Config.toml \label{sec_prac_config_toml}

Für die Konfiguration der Blockchain wird eine Konfigurationsdatei verwendet.
Diese hat das Dateiformat ".toml"[@wiki_toml]. Die hier aufgeführten
Code-Ausschnitte gehören zusammen. Um die Leserlichkeit zu erhöhen, werden sie
jedoch separiert aufgeführt.

```{caption="Konfigurationsdatei für Parity" label=li_toml1 .numberLines}
[parity]
chain = "/home/parity/.local/share/io.parity.ethereum/genesis/instant_seal.json"
base_path = "/home/parity/"
```
##### Parity

Der Code-Ausschnitt \ref{li_toml1} zeigt wie die grundlegenden Eigenschaften der Blockchain definiert sind.
Dazu gehören Genesisblock und der Speicherort. 

Zeile 2
:     Der zu verwendende Genesisblock. Es wird der Pfad zu der entsprechenden 
JSON Datei[@wiki_json] angegeben. Der gezeigte Pfad ist relativ zum Docker-Home. 

Zeile 3
:    Mit "base_path" wird angegeben, wo die Blockchain abgespeichert werden 
soll. Hier wird das gewünschte Verzeichnis angegeben. Der gezeigte Pfad ist relativ zum Docker-Home.


```{caption="Konfigurationsdatei für Parity" label=li_toml2 .numberLines}
[rpc]
cors = ["all"]
apis = ["net", "private", "parity", "personal", "web3", "eth"]
```

##### RPC

Diese Sektion, \ref{li_toml2}, definiert, wie die Blockchain erreichbar ist.

Zeile 2
:    "cors" steht für Cross-Origin Requests. Dieser Parameter wird benötigt, 
um die Interaktion von Remix[@remix] oder Metamask[@metamask] mit der Blochchain 
zu ermöglichen. 

Zeile 3
:    Hier sind die API's definiert, welche über HTTP zur Verfügung gestellt werden.


```{caption="Konfigurationsdatei für Parity" label=li_toml3 .numberLines}
[mining]
min_gas_price = 1000000000
refuse_service_transactions = false
tx_queue_no_unfamiliar_locals = true
reseal_on_txs = "all"
reseal_min_period = 0
reseal_max_period = 6000
```

##### Mining \label{sec_mining}

Die unter \ref{li_toml3} aufgeführte Sektion regelt das Verhalten beim Mining von Blocks.

Zeile 2
:    Der minimale Gas-Preis der gezahlt werden muss, damit eine Transaktion in 
einen Block aufgenommen wird. Der Preis ist in WEI angegeben. Um sicherstellen, 
dass nur die definierte Benutzergruppe gratis Transaktionen tätigen kann, muss 
dieser Wert grösser als null sein. 

Zeile 3
:    Service Transaktionen haben einen Gas-Preis von null. Wird hier "true" 
gesetzt, können keine gratis Transaktionen getätigt werden, unabhängig davon, 
ob eine Whitelist vorhanden ist oder nicht.

Zeile 4
:    Dieser Parameter wird benötigt, dass Transaktionen die mittels RPC an 
Parity übermittelt werden, nicht als lokal betracht werden. Das ist sehr 
wichtig, da lokale Transaktionen standarmässig auch über einen Gas-Preis 
von null verfügen dürfen. So wird sichergestellt, dass nur die definierte 
Benutzergruppe gratis Transaktionen tätigen darf. 

Zeile 5
:    Durch die Einstellung "tx_queue_no_unfamiliar_locals = true" werden alle 
eingehenden Transaktionen behandelt, als ob fremd, also nicht lokal, behandelt. 
Standardmässig, werden aber nur lokale Transaktionen verarbeitet. Daher muss 
hier explizit definiert werden, dass alle Transaktionen verarbeitet werden.

Zeile 6
:    Gibt an, wieviele Milisekunden im Minimum zwischen der Kreation von 
Blöcken liegen müssen.

Zeile 7
:    Defniert die maximale Zeitspanne in Millisekunden zwischen der Kreation 
von Blöcken. Nach Ablauf dieser Zeit wird automatisch ein Block generiert. Dieser 
kann leer sein.

```{caption="Konfigurationsdatei für Parity" label=li_toml4 .numberLines}
[misc]
unsafe_expose = true
```

##### Misc

In dieser Sektion, siehe \ref{li_toml4} sind Parameter, die sonst nirgends reinpassen. 

Zeile 18
:    Wird für die Interaktion mit Remix und Metamask benötigt.

#### Blockchainspezifikation \label{sec_prac_spec}

Mit dieser Datei wird die Blockchain definiert. Sie enthält nebst der
Spezifikation den Genesis Block. Weiter können Benutzeraccounts und Smart
Contracts definiert werden. Diese können verwendet werden, sobald die Blockchain
gestartet ist.\
Die hier aufgeführten Code-Ausschnitte bilden zusammen Blockchainspezifikation. Um die Leserlichkeit zu
erhöhen, werden sie jedoch separiert aufgeführt.

```{.json caption="Blockchainspezifikation mit Genesisblock" label=li_blockchainSpec1  .numberLines}
{
	"name": "BachelorBlockChain",
	"engine": {
		"instantSeal": {
			"params": {}
		}
	},
```
Code-Ausschnitt \ref{li_blockchainSpec1}:

Zeile 2
:     Name der Blockchain

Zeile 3 - 7
:     Der Abschnitt ```engine``` definiert, wie die Blöcke verarbeitet werden. 

Zeile: 4
:     Mit ```instantSeal``` wird angegeben, dass kein Miningalgorithmus verwendet 
wird. Die Blöcke, sofern valide, werden sofort in die Blockchain aufgenommen. 

Zeile 5
:     Die Engine InstantSeal braucht keine weiteren Parameter. Falls ein anderer 
Algorithmus verwendet wird, kann dieser hier konfiguriert werden. 


```{.json caption="Blockchainspezifikation mit Genesisblock" label=li_blockchainSpec2  .numberLines}
	"params": {
		"networkID" : "0x11",
		"registrar" : "0x0000000000000000000000000000000000001337",
		"maxCodeSize": 24576,
		"maximumExtraDataSize": "0x20",
		"minGasLimit": "0x1388",
		"gasLimitBoundDivisor": "0x0400"
	},
```
Code-Ausschnitt \ref{li_blockchainSpec2}:

Zeile 1 - 8
:     Im Abschnitt ```params``` sind die generellen Parameter für die Blockchain aufgeführt.

Zeile 2
:     Die verwendete Netzwerk ID. Die grossen Netzwerke haben eine definierte ID. 
Falls einem bestehenden Netzwerk beigetreten werden soll, muss diese korrekt gewählt 
werden. Der Wert ```11``` ist keinem Netzwerk zugeordnet, daher kann dieser für ein 
privates Netzwerk genutzt werden.

Zeile 3
:     Der ```registrar``` hat als Wert die Adresse der Name Registry, siehe \ref{sec_simpleRegistry}. 
Da bereits beim ersten Start von Parity die Adresse der Name Registry hinterlegt werden muss, 
findet das Deployment direkt in der Blockchainspezifikation statt. 

Zeile 4
:     Die maximale Grösse eines Smart Contracts welcher in mit einer Transaktion deployed wird. 

Zeile 5
:     Spezifiziert die maximale Anzahl Bytes, welche im Feld ```extra_data``` des 
Headers eines Blockes mitgegeben werden kann. 

Zeile 6
:      Definiert den minimalen Gasbetrag, der bei einer Transaktion mitgegeben werden muss.

Zeile 7
:      Schränkt die Schwankungen der Gas Limite zwischen Blöcken ein. 


```{.json caption="Blockchainspezifikation mit Genesisblock" label=li_blockchainSpec1  .numberLines}
	"genesis": {
		"seal": {
			"generic": "0x0"
		},
		"difficulty": "0x20000",
		"gasLimit": "0x7A1200"
	},
```

Code-Ausschnitt \ref{li_blockchainSpec3}:

Zeile 1 - 7
:      Mit dem Abschnitt ```genesis``` ist der Genesis Block, also der erste Block, 
der Blockchain definiert. 

Zeile 2 - 4
:      Hier kann weiter definiert werden, wie Blöcke verarbeitet werden sollen. Da für 
dieses Projekt valide Blöcke sofort in die Blockchain eingefügt werden, sind keine weiteren 
Einstellungen nötig. 

Zeile 5
:      Gibt die Schwierigkeit des Genesis Blocks an. Da als Engine InstantSeal verwendet wird, 
hat dieser Parameter keinen Einfluss. 

Zeile 6
:      Gibt an, was die Gaslimite des Genesis Blockes ist. Da die Gaslimite für Blöcke dynamisch 
berechnet wird, hat dieser Wert einen Einfluss auf zukünftige Gaslimiten. 


```{.json caption="Blockchainspezifikation mit Genesisblock" label=li_blockchainSpec4  .numberLines}
	"accounts": {
		"0000000000000000000000000000000000001337": { "balance": "1", "constructor": "Platzhalter für Bytecode von SimpleRegistry" },
		"00a329c0648769a73afac7f9381e08fb43dbea72": { "balance": "1606938044258990275541962092341162602522202993782792835301376" }
	}
}

```

Code-Ausschnitt \ref{li_blockchainSpec4}:

Zeile 1 - 4    
:      Dieser Abschnitt erlaubtes, Accounts zu definieren. Diese können für Benutzer oder 
Smart Contracts sein. Jeder Account wird mit einer Adresse und einem Guthaben initialisiert. 
Bei einem Account für einen Smart Contract, wird zusätzlich dessen Bytecode angegeben.

Zeile 2
:      Hier ist die SimpleRegistry, siehe Abschnitt \ref{sec_whitelist} und \ref{sec_simpleRegistry}, 
definiert. Der erste Parameter ist die Adresse, unter welcher der Smart Contract erreichbar sein soll. 
Das Guthaben wir mit einem Ether initalisiert. Der Wert für ```constructor``` ist der Bytecode des 
kompilierten Smart Contracts. Dieser ist aufgrund seiner Grösse durch einen Platzhalter ersetzt worden.

Zeile 3
:      Definition von einem Benutzeraccount. Der erste Parameter ist die Adresse. Dem Account kann ein 
beliebiges Guthaben zugewiesen werden. 

