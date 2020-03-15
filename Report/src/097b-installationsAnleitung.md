# Betriebsanleitung
In diesem Kapitel wird dem Benutzer erklärt wie er den BlockChain Transactionmanager in Betrieb nimmt.
Für die in Betriebnahme muss Docker auf dem Rechner installiert sein.
## Hochfahren der Parity Instanz
- Die config.toml Datei wird wie im Bericht im Kapitel "3.1.1.1 Config.toml" aufgesetzt. Bedeutung jedes Parameters wird dort erläutert.  Die Datei muss in folgendem Ordner "%AppData%\Parity\Ethereum\config.toml" abgelegt werden.
- Die  Blockchainspezifikation wird durch die instant_seal.json Datei definiert. Sie wird in folgendem Ordner "/home/parity/.local/share/io.parity.ethereum/genesis/instant_seal.json" gespeichert. Im Kapitel "3.1.1.2 Blockchainspezifikation
" ist der Aufbau beschrieben. 
Um die Parity Instanz zu starten muss auf folgenden Ordner navigiert werden und dann folgenden Befehl ausgefühert werden.

docker run -ti -p 8545:8545 -p 8546:8546 -p 30303:30303 -p 30303:30303/udp -v ~/.local/share/io.parity.ethereum/docker/:/home/parity/.local/share/io.parity.ethereum/ parity/parity:stable --config /home/parity/.local/share/io.parity.ethereum/docker.toml --jsonrpc-interface all

docker volume create --driver=local --opt o=uid=1000 --opt type=tmpfs --opt device=tmpfs paritydb

## Konfigurieren und Deployement des Blockchain TransactionManager
Vor dem Deployement müssen folgende Dateien im Projekt wie gewünscht eingerichtet sein. Eine Anleitung wie diese Json Dateien konfiguriert werden, finden Sie im Bericht im Kapitel "????"
- AccountList.json
- DefaultSettings.json
- TransaktionsManagerAccount.json

Sobald die Konfigurationsdateien wie gewünscht ausgefüllt sind, wird das Projekt zu einer .jar Datei ???
Für diesen Schritt, muss folgender Befehl ausgeführt werden:
cd ????
mvn clean package
 Falls das Erstellen des Deployable erfolgreich war, folgt das Deployement. Hierfür wird ???
 
## Starten der Blockchain Überwachung mit dem Blockchain Transactionmanager
Um das Programm das erste Mal nach dem aufsetzten der Parity Instanz laufen zu lassen, muss folgender Befehl auf der Console ausgeführt werden:

### init

Danach wird nurnoch dieser Befehl genutzt, um das Überwachungsprogramm zu starten:
### run

