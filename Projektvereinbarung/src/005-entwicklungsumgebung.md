# Entwicklungsumgebung

In diesem Abschnitt wird die geplante Testumgebung und deren Verwendung beschrieben. 


## Blockchain

Um das erworbene Wissen auch testen zu können, wird eine Test-Blockchain aufgesetzt. Zu Beginn bietet die Testumgebung eine Möglichkeit, das Gelernte anzuwenden und so das Verständnis für das Thema zu vertiefen. Später im Projekt wird die Umgebung benötigt, um ausgearbeitete Ansätze zu testen und analysieren. 

Als Blockchain wird Ethereum[@ethereum] verwendet. 
In den nachfolgenden Absätzen werden mögliche Tools besprochen, die für den Aufbau von einer Testumgebung genutzt werden können. 

### Client

In der Arbeit wird evaluiert ob Geth[@geth] als Client den Ansprüchen genügzt oder ein anderer Client (z.B. Parity, Aleth, Ethereum J, etc.) zum Einsatz kommt.


#### Ganache und Truffle

Ganache[@ganache] wird verwendet, um eine Test-Blockchain aufzusetzen. So können [Smart Contracts] und verteilte Applikationen vor dem eigentlichen Deployment testen zu können. 

## Wallet

Für die Verwaltung von Identitäten und Transaktionen auf einer Blockchain werden sogenannte Wallets verwendet. Diese Verwaltung ist auch auf einer Lernumgebung nötig, daher muss geprüft werden, ob vorhandene Wallets, wie zum Beispiel uPort[@uport], unseren Ansprüchen genügen oder ob diese im Rahmen von diesem Projekt entwickelt werden müssen. 

## Smart Contracts
 //TODO
Sobald eigene Smart Contracts entwickelt werden, kann die Testumgebung genutzt werden, um diese zu testen.


### Programmiersprache

Für die Entwicklung von Smart Contracts werden folgende Sprachen evaluiert: 
- Solidity[@solidity]
- Vyper
- LLL
- Bamboo
- eWASM

