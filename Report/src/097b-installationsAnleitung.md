# Betriebsanleitung
In diesem Kapitel wird dem Benutzer erklärt wie er den BlockChain Transactionmanager in Betrieb nimmt.
Für die Inbetriebnahme muss Docker auf dem Rechner installiert sein.
## Hochfahren der Parity Instanz
- Die Konfiguration der Blockchain wird über die config.toml Datei gemacht. Wie sie aufgesetzt wird, wird im Kapitel "3.1.1.1 Config.toml" im Bericht aufgezeigt. Die Bedeutung jedes Parameters wird dort erläutert.  Die Datei muss in folgendem Ordner "%AppData%\Parity\Ethereum\config.toml" abgelegt werden.
- Die  Blockchainspezifikation wird durch die instant_seal.json Datei definiert. Sie wird in folgendem Ordner "/home/parity/.local/share/io.parity.ethereum/genesis/instant_seal.json" gespeichert. Im Kapitel "3.1.1.2 Blockchainspezifikation
" ist der Aufbau beschrieben. 
Um die Parity Instanz zu starten muss auf folgenden Ordner "???" navigiert werden und dann folgende zwei Befehle ausgefühert werden:

```docker run -ti -p 8545:8545 -p 8546:8546 -p 30303:30303 -p 30303:30303/udp -v ~/.local/share/io.parity.ethereum/docker/:/home/parity/.local/share/io.parity.ethereum/ parity/parity:stable --config /home/parity/.local/share/io.parity.ethereum/docker.toml --jsonrpc-interface all ```

```docker volume create --driver=local --opt o=uid=1000 --opt type=tmpfs --opt device=tmpfs paritydb ```

## Konfigurieren und Deployement des Programms
Vor dem Deployement müssen folgende Dateien im Projekt wie gewünscht konfiguriert sein.
- AccountList.json
- DefaultSettings.json
- TransaktionsManagerAccount.json

Eine Anleitung wie diese Json Dateien konfiguriert werden, sind im Bericht im Kapitel "3.2.4 Persistenz" und Kapitel "3.2.5 Konfiguration" erläutert.


Sobald die Konfigurationsdateien wie gewünscht ausgefüllt sind, wird aus dem Projekt eine deploybare .jar Datei gebaut.
Für diesen Schritt, muss folgender Befehl in Porjekt Ordner über die Console ausgeführt werden:

```mvn clean package```

Falls das Erstellen des Deployable erfolgreich war, folgt das Deployement. Hierfür wird folgender Befehl in der Console ausgeführt:

```mvn deploy ???```
 
## Starten der Blockchain Überwachung mit dem Blockchain Transactionmanager
Um das Programm das erste Mal nach dem aufsetzten der Parity Instanz laufen zu lassen, muss folgender Befehl auf der Console ausgeführt werden:

```java -jar BTMChainObserver init```

Danach wird nurnoch dieser Befehl genutzt, um das Überwachungsprogramm zu starten:

```java -jar BTMChainObserver run```

