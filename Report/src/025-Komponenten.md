## Komponenten

//TODO Spellcheck

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
:     Der Sender der Transaktion. Wird mit einer 20 Byte langen Adresse, siehe Abschnitt \ref{sec_address}, dargestellt. 

To
:     Der Empfänger der Transaktion. Wird ebenfalls mit einer 20 Byte langen Adresse dargestellt. Falls es sich um ein Deployment von einem Smart Contract handelt, wird dieses Feld leer gelassen. 

Value
:     Mit diesem Feld wird angegeben, wieviel Wei[@wei] übertragen werden soll. Der Betrag wird von "From" nach "To" übertragen. 

Data/Input
:     Dieses Feld wird hauptsächlich für die Interaktion mit Smart Contracts, siehe Abschnitt \ref{sec_smartContracts}, verwendet. Wenn ein Smart Contract deployed werden soll, wir in diesem Feld der dessen Bytecode[@bytecode] übertragen. Bei Funktionsaufrufen auf einen Smart Contract wird die Funktionssignatur und die codierten Parameter mitgegeben. Bei reinen Kontoübertragungen wird das Feld leer gelassen.

Gas Price
:     Gibt an, welcher Preis pro Einheit Gas man gwillt ist zu zahlen. Mehr dazu im Abschnitt \ref{sec_gas}

Gas Limit
:     Definiert die maximale Anzahl Gas Einheiten, die für diese Transaktion verwendet werden können, siehe Abschnitt \ref{sec_gas} [@transactions]

Damit eine Transaktion in die Blockchain aufgenommen werden kann, muss sie signiert[@signing_transaction] sein. Dies kann offline beim Benutzer gemacht werden. Die signierte Transaktion wird dann an die Blockchain übermittelt. 

### Gas \label{sec_gas}

Mit Gas[@gasprice] ist in der Ethereum Blockchain eine spezielle Währung gemeint. Mit ihr werden Transaktionskosten gezahlt. Jede Aktion in der Blockchain kostet eine bestimmte Menge an Gas (Gas Cost). Somit ist die benötigte Menge an Gas proportional zur benötigten Rechenleistung. So wird sichergestellt, dass die anfallenden Kosten einer Interaktion gerecht verrechnet werden. 
Die anfallenden Gas Kosten werden in Ether gezahlt. Für die Berchnung der Transaktionskosten wird der Preis pro Einheit Gas (Gas Price) verwendet. Dieser kann vom Sender selbst bestimmt werden. Ein zu tief gewählter Gas Price hat zur Folge, dass die Transaktion nicht in die Blockchain aufgenommen wird, da es sich für einen Miner, siehe Abschnitt \ref{sec_mining}, nicht lohnt, diese zu verarbeiten. Ein hoher Gas Price stellt zwar sicher, dass die Transaktion schnell verarbeitet wird, kann aber hohe Gebühren generieren. 

$TX = gasCost * gasPrice$

Die Transaktionskosten werden nicht direkt in Ether berechnet, da dieser starken Kursschwankungen unterworfen sein kann. Die Kosten für Rechenleistung, also Elektrizität, sind hingegen stabiler Natur. Daher sind Gas und Ether separiert.

Ein weiterer Parameter ist Gas Limit. Mit diesem Parameter wird bestimmt, was die maximale Gas Cost ist, die man für eine Transaktion bereitstellen möchte. Es wird aber nur so viel verrechnet, wie auch wirklich benötigt wird, der Rest wird einem wieder gutgeschrieben. Falls die Transaktionskosten höher als das gesetzte Gas Limit ausfallen, wird die Ausführung der Transaktion abgebrochen. Alle gemachten Änderungen auf der Chain werden rückgängig gemacht. Die Transaktion wird als "fehlgeschlagene Transaktion" in die Blockchain aufgenommen. Das Gas wird nicht zurück erstattet, da die Miner bereits Rechenleistung erbracht haben. 

### Account \label{sec_account}

Um mit Ethereum interagieren zu können, wird ein Account benötigt. Dieser besteht aus einer Adresse, einem öffentlichen und einem geheimen Schlüssel. Es gibt zwei Arten von Accounts, solche von Benutzern und jene von Smart Contracts. Ein Account ermöglicht es einem Benutzer oder Smart Contract, Ether zu empfangen und zu senden. 


#### Geheimer Schlüssel \label{sec_private_key}

Der geheime Schlüssel ist ein 256 Bit lange zufällig generierte Zahl. Er definiert einen Account und wird verwendet um Transaktionen zu signieren. Daher ist es von grösster Wichtigkeit, dass ein geheimer Schlüssel sicher gelagert wird. Wenn er verloren geht, gibt es keine Möglichkeit mehr auf diesen Account zuzugreifen. 


#### Öffentlicher Schlüssel \label{sec_public_key}

Der öffentliche Schlüssel wird aus dem geheimen Schlüssel abgeleitet. Für die Generierung wird Keccak[@keccak] verwendet, ein "Elliptical Curve Digital Signature Algorithm"[@wiki_ecdsa]. Der öffentliche Schlüssel wird verwendet um die Signatur einer Transaktion zu verifizieren. 


#### Adresse \label{sec_address}

Die Adresse wird aus dem öffentlichen Schlüssel abgeleitet. Es wird SHA3[@wiki_sha3] verwendet um einen 32 Byte langen String zu bilden. Von diesem bilden die letzten 20 Bytes, also 40 Zeichen, die Adresse von einem Account. 
Die Adresse wird bei Transaktionen oder Interaktionen mit einem Smart Contract verwendet. 

### Blockchain Wallet \label{sec_wallet}

Eine Blockchain Wallet, kurz Wallet, ist ein digitales Portmonaie. Der Benutzer hinterlegt in der Wallet seinen geheimen Schlüssel, siehe \ref{sec_private_key}. Dadurch erhält er eine grafische Oberfläche für die Verwaltung seines Accounts. Nebst dem aktuellen Kontostand, wird meistens noch die Transaktionshistorie angezeigt. 
In der Wallet können mehrere Accounts verwaltet werden. So muss sich der Benutzer nicht selbst um die sichere Aufbewahrung der geheimen Schlüssel kümmern. Bei den meisten Wallets ist es möglich verschiedene Währungen zu verwalten. 
Es existieren zwei unterschiedliche Arten von Wallets, Hot und Cold Wallets: 

Hot Wallet
:     Ein Stück Software, welches die geheimen Schlüssel verwaltet. 
:     Es existieren drei unterschiedliche Typen, Destkop, Web und Mobile Wallets.

Cold Wallet
:     Der geheime Schlüssel wird in einem Stück Hardware gespeichert. Dadurch können die geheimen Schlüssel offline gelagert werden. Das erhöht die Sicherheit der Wallet, da Angriffe aus dem Internet ausgeschlossen werden können. [@wallet_general], [@wallet_general_2], [@wallet_cold_vs_hot]

#### Smart Wallet

Smart Wallets basieren auf Smart Contracts. Der Benutzer ist der Besitzer der Smart Contracts und somit der Wallet. Die Verwendung von Smart Contract bei der implementierung der Wallet ermöglicht mehr Benutzerfreundlichkeit ohne die Sicherheit zu kompromittieren. [@smart_wallet_argent], [@smart_wallet_gnosis], [@smart_wallet_dapper]
//TODO .. 

### Denial of Service (DoS) Attacken \label{sec_dos}

Bei einer DoS Attacke versucht der Angreifer einen Service mit Anfragen zu überlasten. Die Überlastung schränkt die Verfügbarkeit stark ein oder macht den Service sogar gänzlich unverfügbar für legitime Anfragen.

Zur Zeit sind Blockchains noch relativ langsam bei der Verarbeitung von Transaktionen. Ethereum kann ungefähr 15 Transaktionen pro Sekunde abarbeiten.[@interview_vitalik_buterin] Dadurch ist ein möglicher Angriffsvektor, die Blockchain mit Transaktionen zu fluten. Das würde dazu führen, dass Benutzer sehr lange auf auf die Ausführung ihrer Transaktionen warten müssen. 
Blockchains schützen sich vor diesem Angriff mit einer Transaktionsgebühr. Diese werden durch Angebot und Nachfrage bestimmt. Das heisst, wenn es viele Transaktionen gibt, steigt der Bedarf an deren Verarbeitung und es kann davon ausgegangen werden, dass auch die Transaktionsgebühren steigen. 
Das bedeutet, dass bei einer DoS Attacke die Transaktionsgebühren tedentiell steigen. Um sicherzustellen, dass seine Transaktionen weiterhin zuverlässig in die Blockchain aufgenommen werden, muss der Angfreifer seinen Gas Price kontinuierlich erhöhen. 
Ein DoS Angriff auf eine Blockchain wird dadurch zu einem sehr kostspieligen Unterfagen. Die hohen Kosten schrecken die meisten Angreifer ab und sind somit ein sehr effizienter Schutzmechanismus.[@investigation_dos_ethereum]



### Algorithmen \label{sec_algo}


