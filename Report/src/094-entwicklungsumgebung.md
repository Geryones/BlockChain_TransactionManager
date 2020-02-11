## Entwicklungsumgebung

In diesem Abschnitt wird die geplante Testumgebung und deren Verwendung beschrieben. 


### Blockchain

Es wird eine Test-Blockchain aufgesetzt. Diese wird benötigt, um geschriebenen Code zu testen und analysieren. 

Als Blockchain wird Ethereum[@ethereum] verwendet. 
In den nachfolgenden Absätzen werden mögliche Tools besprochen, die für den Aufbau von einer Testumgebung genutzt werden können. 

#### Client

In der Arbeit wird evaluiert ob Geth[@geth] als Client den Ansprüchen genügt oder ob ein anderer Client (z.B. Parity[@parity], Aleth[@aleth], etc.) zum Einsatz kommt.


##### Trufflesuite

Trufflesuite[@trufflesuite] wird verwendet, um eine simulierte Blockchain aufzusetzen. Diese kann für die Einarbeitung in die Materie genutzt werden.

### Wallet

Wallets werden für die Verwaltung von Benutzerkonten und deren Transaktionen benötigt. 
Zu den möglichen Wallets gehören z.B.:

- uPort[@uport]
- Metamask[@metamask]
- Atomic Wallet [@atomicWallet]
- Exodus[@exodus]

Es wird davon ausgegangen, dass keine Wallet alle Bedürfnisse abdecken kann, daher wird die gewählte Wallet im Zuge dieses Projekts erweitert. Für Ethereum existiert ein offizieller Service um eine eigene Wallet zu ertellen: MyEtherWallet[@myEtherWallet]

### Smart Contracts

Smart Contracts werden benötigt, um zu bestimmen, wer auf einer Blockchain gratis Transaktionen ausführen kann. 
Sobald eigene Smart Contracts entwickelt werden, kann die Testumgebung genutzt werden, um diese zu testen.


##### Programmiersprache

Für die Entwicklung von Smart Contracts werden folgende zwei Sprachen evaluiert: 

- Solidity[@solidity]
- Vyper[@vyper]


