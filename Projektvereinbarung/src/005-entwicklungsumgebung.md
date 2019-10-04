# Entwicklungsumgebung

In diesem Abschnitt wird die geplante Testumgebung und deren Verwendung beschrieben. 

## Betriebssystem

Beide Teammitglieder verwenden Windows 10 als Betriebssystem. 

## Blockchain

Um das erworbene Wissen auch testen zu können, wird eine Test-Blockchain aufgesetzt. Zu Beginn bietet die Testumgebung eine Möglichkeit, das Gelernte anzuwenden und so das Verständnis für das Thema zu vertiefen. Später im Projekt wird die Umgebung benötigt um ausgearbeitete Ansätze zu testen und analysieren. 

Als Blockchain wird Ethereum[@ethereum] verwendet. 
In den nachfolgenden Absätzen werden mögliche Tools besprochen, die für den Aufbau von einer Testumgebung genutzt werden können. 

### Geth

Geth[@geth] ist der meist verwendete Client für die Etherum Blockchain. Es wurde in der Sprache GO[@go] implementiert und ist Open Source[@opensource]. Geth ermöglicht dem Benutzer die Kontrolle über einen Ethereumknoten mittels einer Kommandozeile. 
Einige der Kernaufgaben von Geth sind:

- Mining[@mining] von Ehterumblöcke
- Erstellen und verwalten von Benutzerkonten
- Transaktionen zwischen Benutzerkonten
- Erstellen von [Smart Contracts]

Da Geth ein Open Source und das am verbreitetste Programm für ein Interaktion mit Ethereum ist, ist es ein idealer Kandidat für dieses Projekt. 

### Ganache und Truffle

Ganache[@ganache] wird verwendet um eine Test-Blockchain aufzusetzen. So können [Smart Contracts] und verteilte Applikationen vor dem eigentlichen Deployment testen zu können. 

## Wallet

Für die Verwaltung von Identitäten und Transaktionen auf einer Blockchain werden sogenannte Wallets verwendet. Diese Verwaltung ist auch auf einer Lernumgebung nötig, daher muss geprüft werden, ob vorhandene Wallets, wie zum Beispiel uPort[@uport], unseren Ansprüchen genügen oder ob diese im Rahmen von diesem Projekt entwickelt werden müssen. 

## Smart Contracts

Für die Entwicklung von Smart Contracts wird die Sprache Solidity[@solidity] verwendet. Auch hier wird die Testumgebung genutzt, um Gelerntes anweden zu können. Sobald eigene Smart Contracts entwickelt werden, kann die Testumgebung genutzt werden, um diese zu testen.
