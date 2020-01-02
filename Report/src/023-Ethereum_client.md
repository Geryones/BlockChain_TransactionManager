## Ethereum Client

Für die Betreibung von einem Ethereum Node ist ein Client nötig. Dieser muss das Ethereum Protokoll[@github_ethereum_protcol] implementieren. Das Protokoll definiert die minimal Anforderungen an den Clienten. Das erlaubt, dass der Client in verschiedenen Sprachen, von verschiedenen Teams, realisiert werden kann. 
Nebst der verwendeten Programmiersprache, unterscheiden sich die Clienten bei implementierten Zusatzfunktionen, die im Protokoll nicht spezifiziert sind. 
Die populärsten Clients sind Go Ethereum (GETH)[@geth], Parity[@parity], Aleth[@aleth] und Trinity[@trinity]. Die Clients wurden auf die Zusatzfunktionalität untersucht, für eine definierte Gruppe von Accounts gratis Transaktionen zu ermöglichen. 

### Parity

Geschrieben in Rust[@rust], ist es der zweit populärste Client nach Geth[@geth]. Verfügbar ist Parity für Windows, macOS und Linux. Die Entwicklung ist noch nicht abgeschlossen und es wird regelmässig eine neue Version vorgestellt. 
Konfiguriert wird das Programm mittels Konfigurationsdateien. Interaktion zur Laufzeit ist über die Kommandozeile möglich. 

#### Whitelist \label{sec_whitelist}

Parity verfügt über eine Whitelist Funktionalität. Die Liste ist als Smart Contract geschrieben. Im Genesisblock[@wiki_genesis_block] wird der Bytecode des Smart Contracts an der gewünschten Adresse hinterlegt. In der Liste können Accounts hinterlegt werden. Diese geniessen das Privileg, gratis Transaktionen tätigen zu dürfen. Dabei wird nur geprüft, ob der Sender einer Transaktion mit einem Gas Price von Null, sich in der Whitelist befindet. Ist er das, wird die Transaktion vom Node akzeptiert. Befindet sich der Account nicht in der Whitelist, wird die Transaktion vom Node abgelehnt. Das heisst, dass die eine abgelehnte Transaktion verworfen wird, bevor sie auf das Netzwerk der Blockchain gelangt. 
Die Whitelist wird initial von der FHNW mit Accounts befüllt. Die FHNW verfügt über einen Account, der berechtigt ist die Liste notfalls anzupassen. Idealerweise benutzt die FHNW diesen Account ausschliesslich zur Befüllung der Liste. 
Ein weiterer Account, der die Liste anpassen kann, wird vom entwickelten Schutzmechanismus kontrolliert. So kann bei einer Bedrohung, der bösartige Account von der Liste entfernt werden. 

### Geprüfte Alternativen

Die Clients Geth, Aleth und Trinity sind ebenfalls evaluiert worden. Bei diesen Clients ist keine Möglichkeit gefunden worden, bestimmte Accounts für gratis Transaktionen zu priviligieren. Daher sind sie zu diesem Zeitpunkt nicht für die FHNW geeignet.
