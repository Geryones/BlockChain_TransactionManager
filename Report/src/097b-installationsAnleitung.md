# Betriebsanleitung
In diesem Kapitel wird dem Benutzer erklärt wie er den BlockChain Transactionmanager in Betrieb nimmt.
Für die in Betriebnahme muss Docker auf dem Rechner installiert sein.
## Hochfahren der Parity Instanz
Die toml Datei wird wie im Bericht im Kapitel ??? aufgesetzt. Bedeutung jedes Parameters wird dort erläutert. Die Daeti muss in folgendem Ordner abgelegt werden.
Die json Datei sieht folgendermasen aus und wird in den Ordner "???" gespeichert. 
Um die Parity Instanz zu starten muss auf folgenden Ordner navigiert werden und dann folgenden Befehl ausgefühert werden.

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

