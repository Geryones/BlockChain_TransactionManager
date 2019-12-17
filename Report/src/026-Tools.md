## Tools

In diesem Abschnitt wird näher auf die verwendeten Tools eingegangen. Ebenfalls werden geprüfte Alternativen aufgelistet. 

### Ethereum Client

Für die Betreibung von einem Ethereum Node ist ein Client nötig. Dieser muss das Ethereum Protokoll[@github_ethereum_protcol] implementieren. Das Protokoll definiert die minimal Anforderungen an den Clienten. Das erlaubt, dass der Client in verschiedenen Sprachen, von verschiedenen Teams, realisiert werden kann. 
Nebst der verwendeten Programmiersprache, unterscheiden sich die Clienten in implementierten Zusatzfunktionen, die im Protokoll nicht spezifiziert sind. 
Die populärsten Clients sind Go Ethereum (GETH)[@geth], Parity[@parity], Aleth[@aleth] und Trinity[@trinity]. Die Clients wurden auf die Zusatzfunktionalität untersucht, für eine definierte Gruppe von Accounts gratis Transaktionen zu ermöglichen. 




#### Whitelist von Parity \label{sec_whitelist}

Der Client Parity hat eine Whitelist Funktionalität. Die Liste ist als Smart Contract geschrieben. Im Genesisblock[@wiki_genesis_block] wird der Bytecode des Smart Contracts an der gewünschten Adresse hinterlegt. In der Liste können Accounts hinterlegt werden. Diese geniessen das Privileg, gratis Transaktionen tätigen zu dürfen. Dabei wird nur geprüft, ob der Sender einer Transaktion mit einem Gas Price von Null, sich in der Whitelist befindet. Ist er das, wird die Transaktion vom Node akzeptiert. Befindet sich der Account nicht in der Whitelist, wird die Transaktion vom Node abgelehnt. 
Die Whitelist wird initial von der FHNW mit Accounts befüllt. Die FHNW verfügt über einen Account, der berechtigt ist die Liste notfalls anzupassen. Idealerweise benutzt die FHNW diesen Account ausschliesslich zur Befüllung der Liste. 
Ein weiterer Account, der die Liste anpassen kann, wird vom entwickelten Schutzmechanismus kontrolliert. So kann bei einer Bedrohung, der bösartige Account von der Liste entfernt werden. 