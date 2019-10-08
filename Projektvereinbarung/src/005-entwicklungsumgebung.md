# Entwicklungsumgebung

In diesem Abschnitt wird die geplante Testumgebung und deren Verwendung beschrieben. 


## Blockchain

Um das erworbene Wissen auch testen zu können, wird eine Test-Blockchain aufgesetzt. Zu Beginn bietet die Testumgebung eine Möglichkeit, das Gelernte anzuwenden und so das Verständnis für das Thema zu vertiefen. Später im Projekt wird die Umgebung benötigt, um ausgearbeitete Ansätze zu testen und analysieren. 

Als Blockchain wird Ethereum[@ethereum] verwendet. 
In den nachfolgenden Absätzen werden mögliche Tools besprochen, die für den Aufbau von einer Testumgebung genutzt werden können. 

### Client

In der Arbeit wird evaluiert ob Geth[@geth] als Client den Ansprüchen genügt oder ein anderer Client (z.B. Parity, Aleth, Ethereum J, etc.) zum Einsatz kommt.


#### Ganache und Truffle

Ganache[@ganache] wird verwendet, um eine simulierte Blockchain aufzusetzen. Anhand dieser Simulation kann ins Thema eingearbeitet werden.

## Wallet

Für die Verwaltung von Identitäten und Transaktionen auf einer Blockchain werden sogenannte Wallets verwendet. Diese Verwaltung ist auch auf einer Lernumgebung nötig, daher muss geprüft werden, welche Wallets den Ansprüchen genügen, diese so weiterentwickeln zu können, dass die Aufgabenskriterien erfüllt werden können (z.B. die gratis Transaktionen). 
Zu den möglichen Wallets gehören z.B.:
- uPort[@uport]
- Nano X [@nanoX]
- Nano S [@nanoS]
- Trezor ["trezor]
- Atomic Wallet [@atomicWallet]
- unt weitere

## Smart Contracts
 //TODO
Sobald eigene Smart Contracts entwickelt werden, kann die Testumgebung genutzt werden, um diese zu testen.


### Programmiersprache

Für die Entwicklung von Smart Contracts werden folgende Sprachen evaluiert: 
- Solidity[@solidity]
- Vyper[@vyper]
- LLL[@lll]
- Bamboo[@bamboo]
- eWASM[@ewasm]

