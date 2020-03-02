
### Docker \label{sec_prac_docker}

Um eine möglichst realitätsnahe Entwicklungsumgebung zu erhalten, wird Docker[@docker] für die Betreibung 
der Blockchain verwendet. Mehr Details zur Verwendung von Docker sind im Anhang unter \ref{app_docker} vorhanden.

### Name Registry

Die Name Registry wird standardmässig in Parity verwendet. Die zur Verfügung gestellte Implementation der 
Name Registry ist SimpleRegistry genannt. Der vollständige Code ist im Anhang unter \ref{app_parity_code} verlinkt. 


### Certifier

Parity stellt eine Implementation des Certifiers zu Verfügung, den
SimpleCertifier. Der vollständige Code ist im Anhang unter \ref{app_parity_code}
verlinkt. 

Sobald der Certifier bei der Name Registry registriert ist, können Accounts
definiert werden, die gratis Transaktionen tätigen können. 

#### Deployment und Registrierung \label{sec_prac_deployment}

Für eine Erfolgreiche Verwendung des Certifiers, die Name Registry in der
Blockchainspezifikation definiert sein. Sobald Parity gestartet ist, kann mit
dem Deplyoment des Certifiers begonnen werden. Hierfür wird Java und die
Bibliothek Web3j[@web3j] verwendet.  

Um in Java mit Smart Contracts auf der Blockchain interagieren zu können, wird
eine Wrapperklasse des Smart Contracts benötigt. Für dessen Generierung wird das
Web3j Command Line Tool (web3j-cli)[@web3j_cml] und der Solidity Compiler
(solc)[@solc] verwendet. Die Wrapper für die SimplyRegistry und den
SimpleCertifier sind im Anhang unter \ref{sec_app_java_code} verlinkt. 

Um einen Smart Contract auszurollen wird eine Instanz der generierten
Wrapperklasse genutzt. Es wird die Methode ```deploy``` der Wrapperklasse
genutzt. 

```{caption="Deplyoment des Certifiers" label=li_certifier_deployment .java .numberLines}
private Web3j web3j = Web3j.build(new HttpService("http://jurijnas.myqnapcloud.com:8545/"));
private TransactionManager transactionManager = new RawTransactionManager(web3j, Credentials.create(privateKey));

private SimpleCertifier simpleCertifier;
try {
	simpleCertifier = SimpleCertifier.deploy(web3j, transactionManager, new DefaultGasProvider()).send();
} catch (Exception e) {
    e.printStackTrace(); 
}

String simpleCertifierAddress = simpleCertifier.getContractAddress();
```
Die Verbindung zu einem Node wird mit einer Instanz von ```Web3j``` auf Zeile 1
definiert. Auf der zweiten Zeile wird ein ```TransactionManager``` instanziert.
Dieser definiert, wie und mit welchem Account auf die Ethereumblockchain
verbunden wird.\
Auf Zeile 6 findet das eigentliche Deployment statt. Nebst dem ```Web3j``` und
dem ```Transactionmanager``` wird ein ```ContractGasProvider``` benötigt. Dieser
definiert den Gas Price und die Gas Limite. Mit dem ```DefaultGasProvicer```
werden Standardwerte verwendet. Durch das Deployment erhalten wir eine Instanz
des ```SimpleCertifiers```. Diese kann nun verwendet werden um weitere Aktionen
auf der Blockchain auszuführen.\
Auf Zeile 11 wird die Adresse des Smart Contracts in eine Variable gespeichert.  

Um den Certifier bei der Name Registry registrieren zu können, muss von der Name
Registry ebenfalls eine Instanz erstellt werden. Auch hier wird die
Wrapperklasse verwendet.

```{caption="Erstellen der Name Registry - Instanz" label=li_registration_cert .java .numberLines}
private Web3j web3j = Web3j.build(new HttpService("http://jurijnas.myqnapcloud.com:8545/"));
private TransactionManager transactionManager = new RawTransactionManager(web3j, Credentials.create(privateKey));

private SimpleRegistry simpleRegistry;
try {
	simpleRegistry = SimpleRegistry.load(simpleRegistryAddress, web3j, transactionManager,new DefaultGasProvider());
} catch (Exception e) {
    e.printStackTrace(); 
}
```
Um eine Instanz von einem bereits platzierten Smart Contract zu erhalten, wird
die Methode ```load``` verwendet. Als erster Argument wird die Adresse der Name
Registry mitgegeben. Analog zum vorherigem Beispiel wird die Verbindung zur
Blockchain mit  ```Web3j```, einem ```Transactionmanager``` und einem
```DefaultGasProvider``` definiert. Der Rückgabewert ist eine Instanz der
```SimpleRegistry```. 

Mit den zur Verfügung stehenden Instanzen, kann die Registrierung des Certifiers
bei der Name Registry gemacht werden. 

```{caption="Reservierung und anschliessende Registrierung bei der Name Registry" label=li_reservation_and_registration .java .numberLines}
private static BigInteger REGISTRATION_FEE = BigInteger.valueOf(1000000000000000000L);

String str_hash = "6d3815e6a4f3c7fcec92b83d73dda2754a69c601f07723ec5a2274bd6e81e155";
private byte[] hash = new BigInteger(str_hash, 16).toByteArray();

try {
	simpleRegistry.reserve(hash, REGISTRATION_FEE).send();
	simpleRegistry.setAddress(hash, "A", simpleCertifier.getContractAddress()).send();
} catch (Exception e) {
    e.printStackTrace(); 
}
``` 
Für die Registrierung wird eine Gebühr von einem Ether erhoben. Dafür wird auf
Zeile 1 eine Variabel vom Typ ```BigInteger``` instanziert.\
Der Auf Zeile 3 definierte String ```str_hash``` ist der sha3-Hash für den
String ```service_transaction_checker```. Dieser wird auf Zeile 4 in ein
Byte-Array umgewandelt. Diese Variabel hält den Namen, unter welchem der
Certifier bei der Name Registry registriert wird. Die Verwendung des Strings
```service_transaction_checker``` und sein Umwandlung sind in Parity hart
kodiert und können nicht angepasst werden.\
Auf Zeile 7 wird die Reservierung bei der Name Registry vorgenommen. Hier wird
der Name und die anfallende Gebühr von einem Ether gesendet.\
Auf Zeile 8 wird die Registrierung abgeschlossen. In der Name Registry wird die
Bindung zwischen Namen und Adresse erstellt. Als erster Parameter wird der Name
übergeben. Das zweite Argument ist der Zugriffsschlüssel in der Map. Auch dieser
ist von Parity vorgegeben, es muss zwingend ```"A"``` übergeben werden. Das
dritte Argument ist die Adresse des Certifiers. Diese wird von dessen Instanz
abgerufen. 


### Interaktionsübersicht auf einem Parity Node \label{prac_nameRegistry_Certifier}

In diesem Abschnitt sind die Interaktionen zwischen Name Registry und Certifier
aufgeführt. 

![Interaktion zwischen Name Registry und Certifier  \label{img_interactions_reg_cert}](images/parity_node.png "Interaktionen zwischen Name Registry und Certifier")

Auf dem Diagramm \ref{img_interactions_reg_cert} ist links der Benutzer XY in blau
dargestellt. Der Parity Node ist in grün dargestellt. Der Benutzer sendet eine
Transaktion mit einem Gas Preis von null an den Parity Node.\
Als erstes wird in Parity geprüft, ob eine Name Registry vorhanden ist. Deren
Deployment ist unter \ref{sec_prac_spec} beschrieben. Der Eintrag
```registrar``` hat als Wert die Adresse der Name Registry hinterlegt.\
In der Name Registry wird das Mapping ```entries``` untersucht. Der Certifier
muss unter dem richtigen Namen hinterlegt sein. Der Name ist ein SHA3-Hash des
Strings "service_transaction_checker". Der Hash ist der Zugriffsschlüssel im
Mapping ```entries```. Der korrespondierende Wert ist ein ```Entry``` für den
Certifiers. Im Struct ```Entry``` ist ```data```, ein weiteres Mapping,
vorhanden. In ```data``` muss unter dem Zugriffsschlüssel "A" die Adresse des
Certifiers abgelegt sein. Das ist keine Konfiguration, sondern hart kodiert in
Parity. Dieser Vorgang ist unter \ref{sec_prac_deployment} ausführlich
beschrieben.\
Mit der so ermittelten Adresse des Certifiers, kann dieser aufgerufen werden.
Im Certifier wird geprüft, ob der Sender der gratis Transaktion, also Account
"XX" zertifiert ist.\
Wenn einer dieser Schritte fehl schlägt, erhält der Benutzer
einen Error, da er einen ungültigen Gas Preis verwendet.\
Konnten alle Schritte erfolgreich durchgeführt werden und der Account ist
zertifiziert, wird die Transaktion in die Blockchain aufgenommen.  
