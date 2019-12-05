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

#### Decentralized application (DApp) \label{sec_dapp}

Eine DApp ist ist eine Applikation (App), deren backend Code dezentral auf einem peer-to-peer Netzwerk läuft, zum Beispiel die Ethereum Blockchain. Der frontend Code kann in einer beliebigen Sprache geschrieben werden, sofern Aufrufe an das Backend möglich sind.  

#### Gas \label{sec_gas}

### Identitäten \label{sec_identitaet}

Um mit Ethereum interagieren zu können, wird eine Identität benötigt. Diese besteht aus einem öffentlichen und einem geheimen Schlüssel. 

#### Geheimer Schlüssel



#### Öffentlicher Schlüssel


#### Adresse



### Wallets und Smart Wallets \label{sec_wallets}



### Transaktionen \label{sec_transaktionen}

### Mining


### Denial of Service (DOS) Attacken \label{sec_dos}

### Algorithmen \label{sec_algo}


