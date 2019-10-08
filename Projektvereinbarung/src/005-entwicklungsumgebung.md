# Entwicklungsumgebung

In diesem Abschnitt wird die geplante Testumgebung und deren Verwendung beschrieben. 


## Blockchain

Es wird eine Test-Blockchain aufgesetzt. Diese wird benötigt, um geschriebenen Code zu testen und analysieren. 

Als Blockchain wird Ethereum[@ethereum] verwendet. 
In den nachfolgenden Absätzen werden mögliche Tools besprochen, die für den Aufbau von einer Testumgebung genutzt werden können. 

### Client

In der Arbeit wird evaluiert ob Geth[@geth] als Client den Ansprüchen genügt oder ob ein anderer Client (z.B. Parity, Aleth, Ethereum J, etc.) zum Einsatz kommt.


#### Ganache und Truffle

Ganache[@ganache] wird verwendet, um eine simulierte Blockchain aufzusetzen. Diese kann für die Einarbeitung in die Materie genutzt werden.

## Wallet

Für die Verwaltung von Identitäten und Transaktionen auf einer Blockchain werden sogenannte Wallets verwendet. Es werden verschiedene Wallets auf ihre Funktionalität untersucht. Es wird davon ausgegangen, dass keine Wallet alle Bedürfnisse abdecken kann, daher wird die gewählte Wallet im Zuge dieses Projekts erweitert. 
Zu den möglichen Wallets gehören z.B.:
- uPort[@uport]
- Nano X [@nanoX]
- Nano S [@nanoS]
- Trezor [@trezor]
- Atomic Wallet [@atomicWallet]
- und weitere

## Smart Contracts

Ein Smart Contract ist ein Stück Code auf der Blockchain. Es ist ein Vertrag zwischen zwei oder mehr Parteien. Die Vertragsbedingungen sind im Code definiert. Sobald diese  erfüllt sind, wird der Vertrag automatisch ausgeführt. Es werden keine zentralen Authoritäten mehr benötigt[@smartContractDef]. 
Smart Contracts werden benötigt, um zu bestimmen, wer auf einer Blockchain gratis Transaktionen ausführen kann. 
Sobald eigene Smart Contracts entwickelt werden, kann die Testumgebung genutzt werden, um diese zu testen.


### Programmiersprache

Für die Entwicklung von Smart Contracts werden folgende Sprachen evaluiert: 
- Solidity[@solidity]
- Vyper[@vyper]
- LLL[@lll]
- Bamboo[@bamboo]
- eWASM[@ewasm]

