## Ethereum Client

Für die Betreibung von einem Ethereum Node ist ein Client nötig. Dieser muss das Ethereum Protokoll[@github_ethereum_protcol] implementieren. Das Protokoll definiert die minimal Anforderungen an den Clienten. Das erlaubt, dass der Client in verschiedenen Sprachen, von verschiedenen Teams, realisiert werden kann. 
Nebst der verwendeten Programmiersprache, unterscheiden sich die Clienten bei implementierten Zusatzfunktionen, die im Protokoll nicht spezifiziert sind. 
Die populärsten Clients sind Go Ethereum (GETH)[@geth], Parity[@parity], Aleth[@aleth] und Trinity[@trinity]. Die Clients wurden auf die Zusatzfunktionalität untersucht, für eine definierte Gruppe von Accounts gratis Transaktionen zu ermöglichen. 

### Parity \label{sec_whitelist}

Geschrieben in Rust[@rust], ist es der zweit populärste Client nach Geth[@geth]. Verfügbar ist Parity für Windows, macOS und Linux. Die Entwicklung ist noch nicht abgeschlossen und es wird regelmässig eine neue Version vorgestellt. 
Konfiguriert wird das Programm mittels Konfigurationsdateien. Interaktion zur Laufzeit ist über die Kommandozeile möglich. 

Parity ist der einzige Client, der es erlaubt, einer definierten Gruppe von Benutzern gratis Transaktionen zu erlauben. 
Die Verwaltung der priviligierten Accounts geschieht mittels eines Smart Contracts. Die Accounts sind in einer Liste, der sogenannten Whitelist, gespeichert.   

Für die Verwendung der Whitelist sind zwei Smart Contracts nötig, die Name Registry[@parity_nameRegistry] und der Service Transaction Checker[@parity_service_transaction_checker]. Diese sind in den folgenden Abschnitten erklärt.

#### Name Registry \label{sec_simpleRegistry}

In diesem Abschnitt sind besonders wichtige Codeausschnitte der Name Registry aufgeführt und erklärt. Der gesammte Code ist im Anhang unter \ref{app_registry} zu finden. 

In Parity wir die Name Registry verwendet, um eine Accountaddresse in eine lesbare Form zu übersetzen. Smart Contracts können gegen eine Gebühr von einem Ether registriert werden. Dabei wird die Adresse des Smart Contracts zusammen mit dem gewählten Namen registriert. Das erlaubt das Referenzieren von Smart Contracts, ohne dass hart kodierte Adressen verwendet werden müssen. 
Dieses System ist analog zu einem DNS Lookup[@wiki_dns].

Die Name Registry ist in Parity standardmässig unter der Addresse ```0x0000000000000000000000000000000000001337``` zu finden. Um eine Whitelist verwenden zu können, muss der zuständige Smart Contract, siehe \ref{sec_simpleCertifier}, bei der Name Registry registriert werden. 
Nachfolgenden sind die involvierten Methoden der Name Registry für diese Registrierung aufgeführt und erklärt.

```{ .sol .numberLines}

```


#### Certifier \label{sec_ssimpleCertifier}

In diesem Abschnitt sind besonders wichtige Abschnitte des SimpleCertifiers aufgeführt und erklärt. Der gesammte Code ist im Anhang unter \ref{app_certifier} zu finden. 

### Geprüfte Alternativen

Die Clients Geth, Aleth und Trinity sind ebenfalls evaluiert worden. Bei diesen Clients ist keine Möglichkeit gefunden worden, bestimmte Accounts für gratis Transaktionen zu priviligieren. Daher sind sie zu diesem Zeitpunkt nicht für die FHNW geeignet.
