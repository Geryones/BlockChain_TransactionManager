# Praktischer Teil

Dieses Kapitel beschreibt, wie die gewonnen theoretischen Grundlagen umgesetzt sind. Die realisierte Lösung wird kritisch hinterfragt und anderen Lösungsansätzen gegenübergestellt. 

## Parity

In diesem Abschnitt ist beschrieben, wie die Blockchain konfiguriert ist. Als Client wird die stable Version[@parity_releases] von Parity verwendet. 

### Konfiguration der Blockchain

Parity wird mit der Konsole gestartet. Der Benutzer hat hier die Möglichkeit, gewisse Parameter an Parity zu übergeben. Eine einfache Konfiguration ist somit möglich. Für kompliziertere Konfigurationen, wird die Verwendung von einer Konfigurationsdatei empfohlen. 

#### Config.toml

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
:     Hier wird der zu verwendende Genesisblock definiert. Es wird der Pfad zu der entsprechenden JSON Datei[@wiki_json] angegeben. 

Zeile 3
:    Mit "base_path" wird angegeben, wo die Blockchain abgespeichert werden soll. Hier wird das gewünschte Verzeichnis angegeben.

##### RPC

Hier wird definiert, wie und von die Blockchain erreichbar ist.

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

#### Genesis Block

```{#genesisBlock .json .numberLines}
{
	"name": "BachelorBlockChain",
	"engine": {
		"instantSeal": {
			"params": {}
		}
	},
	"params": {
		"gasLimitBoundDivisor": "0x0400",
		"accountStartNonce": "0x0",
		"maximumExtraDataSize": "0x20",
		"minGasLimit": "0x1388",
		"networkID" : "0x11",
		"registrar" : "0x0000000000000000000000000000000000001337",
		"eip150Transition": "0x0",
		"eip160Transition": "0x0",
		"eip161abcTransition": "0x0",
		"eip161dTransition": "0x0",
		"eip155Transition": "0x0",
		"eip98Transition": "0x7fffffffffffff",
		"maxCodeSize": 24576,
		"maxCodeSizeTransition": "0x0",
		"eip140Transition": "0x0",
		"eip211Transition": "0x0",
		"eip214Transition": "0x0",
		"eip658Transition": "0x0",
		"eip145Transition": "0x0",
		"eip1014Transition": "0x0",
		"eip1052Transition": "0x0",
		"wasmActivationTransition": "0x0"
	},
	"genesis": {
		"seal": {
			"generic": "0x0"
		},
		"difficulty": "0x20000",
		"author": "00a329c0648769a73afac7f9381e08fb43dbea72",
		"timestamp": "0x00",
		"parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
		"extraData": "0x",
		"gasLimit": "0x7A1200"
	},
	"accounts": {
		"0000000000000000000000000000000000000001": { "balance": "1", "builtin": { "name": "ecrecover", "pricing": { "linear": { "base": 3000, "word": 0 } } } },
		"0000000000000000000000000000000000000002": { "balance": "1", "builtin": { "name": "sha256", "pricing": { "linear": { "base": 60, "word": 12 } } } },
		"0000000000000000000000000000000000000003": { "balance": "1", "builtin": { "name": "ripemd160", "pricing": { "linear": { "base": 600, "word": 120 } } } },
		"0000000000000000000000000000000000000004": { "balance": "1", "builtin": { "name": "identity", "pricing": { "linear": { "base": 15, "word": 3 } } } },
		"0000000000000000000000000000000000000005": { "balance": "1", "builtin": { "name": "modexp", "activate_at": 0, "pricing": { "modexp": { "divisor": 20 } } } },
		"0000000000000000000000000000000000000006": {
			"balance": "1",
			"builtin": {
				"name": "alt_bn128_add",
				"pricing": {
					"0": {
						"price": { "alt_bn128_const_operations": { "price": 500 }}
					},
					"0x7fffffffffffff": {
						"info": "EIP 1108 transition",
						"price": { "alt_bn128_const_operations": { "price": 150 }}
					}
				}
			}
		},
		"0000000000000000000000000000000000000007": {
			"balance": "1",
			"builtin": {
				"name": "alt_bn128_mul",
				"pricing": {
					"0": {
						"price": { "alt_bn128_const_operations": { "price": 40000 }}
					},
					"0x7fffffffffffff": {
						"info": "EIP 1108 transition",
						"price": { "alt_bn128_const_operations": { "price": 6000 }}
					}
				}
			}
		},
		"0000000000000000000000000000000000000008": {
			"balance": "1",
			"builtin": {
				"name": "alt_bn128_pairing",
				"pricing": {
					"0": {
						"price": { "alt_bn128_pairing": { "base": 100000, "pair": 80000 }}
					},
					"0x7fffffffffffff": {
						"info": "EIP 1108 transition",
						"price": { "alt_bn128_pairing": { "base": 45000, "pair": 34000 }}
					}
				}
			}
		},
		"0000000000000000000000000000000000001337": { "balance": "1", "constructor": "Platzhalter für Bytecode": { "balance": "1606938044258990275541962092341162602522202993782792835301376" }
	}
}


```

#### Docker

### Whitelist

#### SimpleRegistry

#### SimpleCertifier

## Schutz vor DoS Attacken

