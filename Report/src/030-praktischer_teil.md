# Praktischer Teil

Dieses Kapitel beschreibt, wie die gewonnen theoretischen Grundlagen umgesetzt sind. Die realisierte Lösung wird kritisch hinterfragt und anderen Lösungsansätzen gegenübergestellt. 

## Parity \label{sec_prac_parity}

In diesem Abschnitt ist beschrieben, wie die Blockchain konfiguriert ist. Als Client wird die stable Version[@parity_releases] von Parity verwendet. 

### Konfiguration der Blockchain \label{sec_prac_bc_config}

Parity wird mit der Konsole gestartet. Der Benutzer hat hier die Möglichkeit, gewisse Parameter an Parity zu übergeben. Eine einfache Konfiguration ist somit möglich. Für kompliziertere Konfigurationen, wird die Verwendung von einer Konfigurationsdatei empfohlen. 

#### Config.toml \label{sec_prac_config_toml}

Für die Konfiguration der Blockchain wird eine Konfigurationsdatei verwendet. Diese hat das Dateiformat .toml[@wiki_toml]. 

``` {#tomlFile .numberLines}
[parity]
chain = "/home/parity/.local/share/io.parity.ethereum/genesis/instant_seal.json"
base_path = "/home/parity/"

[rpc]
cors = ["all"]
apis = ["net", "private", "parity", "personal", "web3", "eth"]

[mining]
min_gas_price = 1000000000
refuse_service_transactions = false
tx_queue_no_unfamiliar_locals = true
reseal_on_txs = "all"
reseal_min_period = 0
reseal_max_period = 6000

[misc]
unsafe_expose = true
```

Der oben aufgeführte Codeblock ist in Sektionen gegliedert. Diese sind durch einen Namen in eckigen Klammern definiert. Innerhalb einer Sektion existieren bestimmte Schlüssel mit einem Wert. Jede Sektion ist in den folgenden Abschnitten erklärt. 

##### Parity

In dieser Sektion sind die grundlegenden Eigenschaften der Blockchain definiert. Dazu gehören Genesisblock und der Speicherort. 

Zeile 2
:     Der zu verwendende Genesisblock. Es wird der Pfad zu der entsprechenden JSON Datei[@wiki_json] angegeben. 

Zeile 3
:    Mit "base_path" wird angegeben, wo die Blockchain abgespeichert werden soll. Hier wird das gewünschte Verzeichnis angegeben.

##### RPC

Diese Sektion definiert, wie die Blockchain erreichbar ist.

Zeile 6
:    "cors" steht für Cross-Origin Requests. Dieser Parameter wird benötigt, um die Interaktion von Remix[@remix] oder Metamask[@metamask] mit der Blochchain zu ermöglichen. 

Zeile 7
:    Hier sind die API's definiert, welche über HTTP zur Verfügung gestellt werden.

##### Mining

Diese Sektion regelt das Verhalten beim Mining von Blocks.

Zeile 10
:    Der minimale Gas-Preis der gezahlt werden muss, damit eine Transaktion in einen Block aufgenommen wird. Der Preis ist in WEI angegeben. Um sicherstellen, dass nur die definierte Benutzergruppe gratis Transaktionen tätigen kann, muss dieser Wert grösser als Null sein. 

Zeile 11
:    Service Transaktionen haben einen Gas-Presi von Null. Wird hier "true" gesetzt, können keine gratis Transaktionen getätigt werden, unabhängig davon, ob eine Whitelist vorhanden ist oder nicht.

Zeile 12
:    Dieser Parameter wird benötigt, dass Transaktionen die mittels RPC an Parity übermittelt werden, nicht als lokal betracht werden. Das ist sehr wichtig, da lokale Transaktionen standarmässig auch über einen Gas-Preis von Null verfügen dürfen. So wird sichergestellt, dass nur die definierte Benutzergruppe gratis Transaktionen tätigen darf. 

Zeile 13
:    Durch die Einstellung "tx_queue_no_unfamiliar_locals = true" werden alle eingehenden Transaktionen behandelt, als ob fremd, also nicht lokal, behandelt. Standardmässig, werden aber nur lokale Transaktionen verarbeitet. Daher muss hier explizit definiert werden, dass alle Transaktionen verarbeitet werden.

Zeile 14
:    Gibt an, wieviele Milisekunden im Minimum zwischen der Kreation von Blöcken liegen müssen.

Zeile 15
:    Defniert die maximale Zeitspanne in Millisekunden zwischen der Kreation von Blöcken. Nach Ablauf dieser Zeit wird automatisch ein Block generiert. Dieser kann leer sein.

##### Misc

In dieser Sektion sind Parameter, die sonst nirgends reinpassen. 

Zeile 18
:    Wird für die Interaktion mit Remix und Metamask benötigt.

#### Blockchainspezifikation 

Mit dieser Datei wird die Blockchain definiert. Sie enthält nebst der Spezifikation den Genesis Block. Der Genesis Block ist der erste Block in einer Blockchain. 

```{#Blockchainspezifikation .json .numberLines}
{
	"name": "BachelorBlockChain",
	"engine": {
		"instantSeal": {
			"params": {}
		}
	},
	"params": {
		"networkID" : "0x11",
		"registrar" : "0x0000000000000000000000000000000000001337",
		"maxCodeSize": 24576,
		"maximumExtraDataSize": "0x20",
		"minGasLimit": "0x1388",
		"gasLimitBoundDivisor": "0x0400"
	},
	"genesis": {
		"seal": {
			"generic": "0x0"
		},
		"difficulty": "0x20000",
		"gasLimit": "0x7A1200"
	},
	"accounts": {
		"0000000000000000000000000000000000001337": { "balance": "1", "constructor": "Platzhalter für Bytecode von SimpleRegistry" },
		"00a329c0648769a73afac7f9381e08fb43dbea72": { "balance": "1606938044258990275541962092341162602522202993782792835301376" }
	}
}

```

Oben aufgeführt ist die Blockchainspezifikation. Im folgenden Abschnitt ist diese Zeilenweise erläutert. 

Zeile 2
:     Name der Blockchain

Zeile 3 - 7
:     Der Abschnitt ```engine``` definiert, wie die Blöcke verarbeitet werden. 

Zeile: 4
:     Mit ```instantSeal``` wird angegeben, dass kein Miningalgorithmus verwendet wird. Die Blöcke, sofern valide, werden sofort in die Blockchain aufgenommen. 

Zeile 5
:     Die Engine InstantSeal braucht keine weiteren Parameter. Falls ein anderer Algorithmus verwendet wird, kann dieser hier konfiguriert werden. 

Zeile 8 - 15
:     Im Abschnitt ```params``` sind die generellen Parameter für die Blockchain aufgeführt.

Zeile 9
:     Die verwendete Netzwerk ID. Die grossen Netzwerke haben eine definierte ID. Falls einem bestehenden Netzwerk beigetreten werden soll, muss diese korrekt gewählt werden. Der Wert ```11``` ist keinem Netzwerk zugeordnet, daher kann dieser für ein privates Netzwerk genutzt werden.

Zeile 10
:     Der ```registrar``` hat als Wert die Adresse der ```SimpleRegistry```. Dieser Parameter und der dazugehörende Smart Contract halten und verwalten die Whitelist in Parity. Sobald eine Transaktion ohne Gas Preis auf dem Node eintrifft, wird der Smart Contract an dieser Adresse verwendet, um zu prüfen ob eine gratis Transaktion erlaubt ist oder nicht.

Zeile 11
:     Die maximale Grösse eines Smart Contracts welcher in mit einer Transaktion deployed wird. 

Zeile 12
:     Spezifiziert die maximale Anzahl Bytes, welche im Feld ```extra_data``` des Headers eines Blockes mitgegeben werden kann. 

Zeile 13
:      Definiert den minimalen Gasbetrag, der bei einer Transaktion mitgegeben werden muss.

Zeile 14
:      Schränkt die Schwankungen der Gas Limite zwischen Blöcken ein. 

Zeile 16 - 22
:      Mit dem Abschnitt ```genesis``` ist der Genesis Block, also der erste Block, der Blockchain definiert. 

Zeile 17 - 19
:      Hier kann weiter definiert werden, wie Blöcke verarbeitet werden sollen. Da für dieses Projekt valide Blöcke sofort in die Blockchain eingefügt werden, sind keine weiteren Einstellungen nötig. 

Zeile 20
:      Gibt die Schwierigkeit des Genesis Blocks an. Da als Engine InstantSeal verwendet wird, hat dieser Parameter keinen Einfluss. 

Zeile 21
:      Gibt an, was die Gaslimite des Genesis Blockes ist. Da die Gaslimite für Blöcke dynamisch berechnet wird, hat dieser Wert einen Einfluss auf zukünftige Gaslimiten. 

Zeile 23 - 26    
:      Dieser Abschnitt erlaubt es, Accounts zu definieren. Diese können für Benutzer oder Smart Contracts sein. Jeder Account wird mit einer Adresse und einem Guthaben initialisiert. Bei einem Account für einen Smart Contract, wird zusätzlich dessen Bytecode angegeben.

Zeile 24
:      Hier ist die SimpleRegistry, siehe Abschnitt \ref{sec_prac_simpleRegistry}, definiert. Der erste Parameter ist die Adresse, unter welcher der Smart Contract erreichbar sein soll. Das Guthaben wir mit einem Ether initalisiert. Der Wert für ```constructor``` ist der Bytecode des Smart Contracts. Dieser ist hier durch einen Platzhalter ersetzt worden.  

Zeile 25
:      Definition von einem Benutzeraccount. Der erste Parameter ist die Adresse. Dem Account kann ein beliebiges Guthaben zugewiesen werden. 

#### Docker \label{sec_prac_docker}

Um eine möglichst realitätsnahe Entwicklungsumgebung zu erhalten, wird Docker[@docker] für die Betreibung der Blockchain verwendet. Mehr Details zur Verwendung von Docker sind im Anhang unter \ref{app_docker} vorhanden.

### Whitelist \label{sec_prac_whitelist}

#### SimpleRegistry \label{sec_prac_simpleRegistry}

#### SimpleCertifier \label{sec_prac_simpleCertifier}



