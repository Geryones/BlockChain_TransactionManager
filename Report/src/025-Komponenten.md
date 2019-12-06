## Komponenten

Die folgenden Abschnitte behandeln die gemachten Literaturrecherchen. Für jedes Thema sind die gewonnen Erkenntnisse aufgeführt. Dabei ist nebst einem grundsätzlichen Verständnis für die Materie immer der Schutz vor einer Denial of Servie (DOS) Attacke im Fokus.  

### Ethereum Blockchain \label{sec_blockchain}

Eine Blockchain ist eine kontinuierlich erweiterbare Liste von Datensätzen, „Blöcke“ genannt, die mittels kryptographischer Verfahren miteinander verkettet sind. Jeder Block enthält dabei typischerweise einen kryptographisch sicheren Hash (Streuwert) des vorhergehenden Blocks, einen Zeitstempel und Transaktionsdaten.[@wiki_blockchain] 

Blockchains sind auf einem peer-to-peer (P2P) Netzwerk[@wiki_p2p] aufgebaut. Ein Computer der Teil von diesem Netzwerk ist, wird Node genannt. Jeder Node hat eine identische Kopie der Historie aller Transaktionen. Es gibt keinen zentralen Server der angegriffen werden kann. Das erhöht die Sicherheit der Blockchain. 
Es muss davon ausgegangen werden, dass es Nodes gibt, die Versuchen die Daten der Blockchain zu verfälschen. Dem wird mit der Verwendung von diversen Consenus Algorithmen[@consensus_alg] entgegen gewirkt. Die Consensus Algorithemen stellen sicher, dass die Transaktionen auf der Blockchain valide und authentisch sind.

Im Gegensatz zur Bitcoin[@wiki_bitcoin] kann bei Ethereum[@ethereum] auch Code in der Chain gespeichert werden, sogenannte Smart Contracts, siehe \ref{sec_smartContracts}. 
Ethereum verfügt über eine eigene Kryptowährung, den Ether (ETH). 

### Smart Contracts \label{sec_smartContracts}

Der Begriff Smart Contract, wurde von Nick Szabo[@wiki_nick_szabo] in den frühen 1990 Jahren zum erten Mal verwendet. Es handelt sich um ein Stück Code, das auf der Blockchain liegt. Es können Vertragsbedingungen als Code geschrieben werden. Sobald die Bedingungen erfüllt sind, führt sich der Smart Contract selbst aus.
Der Code kann von allen Teilnehmern der Blockchain inspiziert werden. Da er dezentral auf der Blockchain gespeichert ist, kann er auch nicht nachträglich manipuliert werden. Das schafft Sicherheit für die beteiligten Parteien.

![Ein traditioneller Vertag[@smart_contracts_alpiq] \label{img_tradContract}](images/traditional_contract.PNG "Traditional smart contract") 

![Ein Smart Contract[@smart_contracts_alpiq] \label{img_smartContract}](images/smart_contract.PNG "smart contract")

Der grosse Vorteil von Smart Contracts ist, dass keine third parties benötigt werden, das ist auf den Bildern \ref{img_tradContract} und \ref{img_smartContract} dargestellt. Der Code kontrolliert die Transaktionen, welche Nachverfolgbar und irreversibel sind. Bei einem traditionellen Vertrag werden diese durch third parties kontrolliert und meistens auch ausgeführt. 

Sobald ein Smart Contract auf Ethereum deployed ist, verfügt er über eine Adresse, siehe Abschnitt \ref{sec_address}. Mit dieser, kann auf die Funktionen des Smart Contracts zugegriffen werden. 


#### Decentralized application (DApp) \label{sec_dapp}

Eine DApp ist ist eine Applikation (App), deren backend Code dezentral auf einem peer-to-peer Netzwerk läuft, zum Beispiel die Ethereum Blockchain. Der frontend Code kann in einer beliebigen Sprache geschrieben werden, sofern Aufrufe an das Backend möglich sind. 
Das prominenteste Beispiel einer DApp ist CryptoKitties[@cryptokitties], beider die Benutzer digitale Katzen handeln und züchten können. 

### Transaktionen \label{sec_transaktionen}

Um mit der Blockchain zu interagieren, werden Transaktionen benötigt. Sie erlauben es Daten in der Blockchain zu erstellen oder anzupassen. Eine Transaktion verfügt über folgende Felder:

From
:   Der Sender der Transaktion. Wird mit einer 20 Byte langen Adresse, siehe Abschnitt \ref{sec_address}, dargestellt. 

To
:   Der Empfänger der Transaktion. Wird ebenfalls mit einer 20 Byte langen Adresse dargestellt. Falls es sich um ein Deployment von einem Smart Contract handelt, wird dieses Feld leer gelassen. 

Value
:   Mit diesem Feld wird angegeben, wieviel Wei[@wei] übertragen werden soll. Der Betrag wird von "From" nach "To" übertragen. 

Data/Input
:   Dieses Feld wird hauptsächlich für die Interaktion mit Smart Contracts, siehe Abschnitt \ref{sec_smartContracts}, verwendet. Wenn ein Smart Contract deployed werden soll, wir in diesem Feld der dessen Bytecode[@bytecode] übertragen. Bei Funktionsaufrufen auf einen Smart Contract wird die Funktionssignatur und die codierten Parameter mitgegeben. Bei reinen Kontoübertragungen wird das Feld leer gelassen.

Gas Price
:   Gibt an, welcher Preis pro Einheit Gas man gwillt ist zu zahlen. Mehr dazu im Abschnitt \ref{sec_gas}

Gas Limit
:   Definiert die maximale Anzahl Gas Einheiten, die für diese Transaktion verwendet werden können, siehe Abschnitt \ref{sec_gas}



### Gas \label{sec_gas}

Mit Gas[@gasprice] ist in der Ethereum Blockchain eine spezielle Währung gemeint. Mit ihr werden Transaktionskosten gezahlt. Jede Aktion in der Blockchain kostet eine bestimmte Menge an Gas (Gas Cost). Somit ist die benötigte Menge an Gas proportional zur benötigten Rechenleistung. So wird sichergestellt, dass die anfallenden Kosten einer Interaktion gerecht verrechnet werden. 
Die anfallenden Gas Kosten werden in Ether gezahlt. Für die Berchnung der Transaktionskosten wird der Preis pro Einheit Gas (Gas Price) verwendet. Dieser kann vom Sender selbst bestimmt werden. Ein zu tief gewählter Gas Price hat zur Folge, dass die Transaktion nicht in die Blockchain aufgenommen wird, da es sich für einen Miner, siehe Abschnitt \ref{sec_mining}, nicht lohnt, diese zu verarbeiten. Ein hoher Gas Price stellt zwar sicher, dass die Transaktion schnell verarbeitet wird, kann aber hohe Gebühren generieren. 

$TX = gas cost * gas price$

Die Transaktionskosten werden nicht direkt in Ether berechnet, da dieser starken Kursschwankungen unterworfen sein kann. Die Kosten für Rechenleistung, also Elektrizität, sind hingegen stabiler Natur. Daher sind Gas und Ether separiert.

Ein weiterer Parameter ist Gas Limit. Mit diesem Parameter wird bestimmt, was die maximale Gas Cost ist, die man für eine Transaktion bereitstellen möchte. Es wird aber nur so viel verrechnet, wie auch wirklich benötigt wird, der Rest wird einem wieder gutgeschrieben. Falls die Transaktionskosten höher als das gesetzte Gas Limit ausfallen, wird die Ausführung der Transaktion abgebrochen. Alle gemachten Änderungen auf der Chain werden rückgängig gemacht. Die Transaktion wird als "fehlgeschlagene Transaktion" in die Blockchain aufgenommen. Das Gas wird nicht zurück erstattet, da die Miner bereits Rechenleistung erbracht haben. 

### Identitäten \label{sec_identitaet}

Um mit Ethereum interagieren zu können, wird eine Identität benötigt. Diese besteht aus einem öffentlichen und einem geheimen Schlüssel. 

#### Geheimer Schlüssel



#### Öffentlicher Schlüssel


#### Adresse \label{sec_address}



### Wallets und Smart Wallets \label{sec_wallets}





### Mining \label{sec_mining}


### Denial of Service (DOS) Attacken \label{sec_dos}

### Algorithmen \label{sec_algo}


