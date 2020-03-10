## Ethereum Client

Für die Betreibung von einem Ethereum Node ist ein Client nötig. Dieser muss das
Ethereum Protokoll[@github_ethereum_protcol] implementieren. Das Protokoll
definiert die minimalen Anforderungen an den Client. Das erlaubt, dass der
Client in verschiedenen Sprachen, von verschiedenen Teams, realisiert werden
kann. Nebst der verwendeten Programmiersprache unterscheiden sich die Clients
bei implementierten Zusatzfunktionen, die im Protokoll nicht spezifiziert sind.
Die populärsten Clients sind Go Ethereum (GETH)[@geth], Parity[@parity],
Aleth[@aleth] und Trinity[@trinity]. Die Clients wurden auf die
Zusatzfunktionalität untersucht, für eine definierte Gruppe von Accounts gratis
Transaktionen zu ermöglichen. 

### Parity \label{sec_whitelist}

Geschrieben in Rust[@rust], ist es der zweit populärste Client nach Geth[@geth].
Verfügbar ist Parity für Windows, macOS und Linux. Die Entwicklung ist noch
nicht abgeschlossen und es wird regelmässig eine neue Version vorgestellt.\
Konfiguriert wird das Programm mittels Konfigurationsdateien. Interaktion zur
Laufzeit ist über die Kommandozeile möglich. 

Parity ist der einzige Client, der es erlaubt, einer definierten Gruppe von
Benutzern gratis Transaktionen zu erlauben.\
Die Verwaltung der priviligierten Accounts geschieht mittels eines Smart
Contracts. Die Accounts sind in einer Liste, der sogenannten Whitelist,
gespeichert.   

Für die Verwendung der Whitelist sind zwei Smart Contracts nötig, die Name
Registry[@parity_nameRegistry] und der Service Transaction
Checker[@parity_service_transaction_checker]. Diese sind in den folgenden
Abschnitten erklärt.

#### Name Registry \label{sec_simpleRegistry}

In Parity wir die Name Registry verwendet, um eine Accountaddresse in eine
lesbare Form zu übersetzen.\
Smart Contracts können für eine Gebühr von einem Ether registriert werden. Dabei
wird die Adresse des Smart Contracts zusammen mit dem gewählten Namen
registriert. Das erlaubt das Referenzieren von Smart Contracts, ohne dass hart
kodierte Adressen verwendet werden müssen. Dieses System ist analog zu einem DNS
Lookup[@wiki_dns].

Die Name Registry ist in Parity standardmässig immer unter derselben Addresse
zu finden. Um eine Whitelist verwenden zu können, muss der zuständige Smart
Contract, siehe \ref{sec_simpleCertifier}, bei der Name Registry registriert
werden.\
Nachfolgenden sind die involvierten Methoden und Modifier[@wiki_modifier] der
Name Registry aufgeführt und erklärt. Der vollständige Code ist im Anhang unter
\ref{app_parity_code} verlinkt. 

```{caption="Eintrag bei der Name Registry" label=li_entry_nameRegistry  .sol .numberLines}
struct Entry {
	address owner;
	address reverse;
	bool deleted;
	mapping (string => bytes32) data;
}
mapping (bytes32 => Entry) entries;
```
Im Codeausschnitt \ref{li_entry_nameRegistry} ist die Map ```entries```
aufgeführt. Sie enthält alle registrierten Accounts in Form eines ```Entry```.
Pro Eintrag wird der Besitzer (```owner```), die Adresse (```address```), ein
Flag ob der Eintrag gelöscht ist (```deleted```) und dessen Daten (```data```)
gespeichert.\
Die Map ```entries``` ist die zentrale Datenstruktur der Name Registry.
Änderungn daran sind daher durch Modifiers eingeschränkt.

```{caption="Modifier whenUnreserved" label=li_whenUnreserved .sol .numberLines}
modifier whenUnreserved(bytes32 _name) {
	require(!entries[_name].deleted && entries[_name].owner == 0);
	_;
}
```
Der unter \ref{li_whenUnreserved} gezeigte Code, stellt sicher, dass ein Eintrag
zu einem Namen (```_name```) nicht bereits existiert oder zu einem früheren
Zeitpunkt gelöscht worden ist. Es wird also geprüft, ob die gewünschte Position
in der Map ```entries``` noch frei ist und somit reserviert werden kann.


```{caption="Modifier onlyOwnerOf" label=li_onlyOwnerOf .sol .numberLines}
modifier onlyOwnerOf(bytes32 _name) {
    require(entries[_name].owner == msg.sender);
    _;
}
```
Unter \ref{li_onlyOwnerOf} wird der Sender einer Nachricht mit dem Besitzer
eines Eintrags unter dem Namen ```_name``` in ```entries``` verglichen. Nur wenn
dieser identisch ist, dürfen Änderungen an einem existierenden Eintrag
vorgenommen werden. 


```{caption="Modifier whenEntryRaw" label=li_whenEntryRaw .sol .numberLines}
modifier whenEntryRaw(bytes32 _name) {
	require(
		!entries[_name].deleted &&
		entries[_name].owner != address(0)
	);
	_;
}
```
Der unter \ref{li_whenEntryRaw} aufgeführte Modifier prüft, ob der Eintrag für
den Namen ```_name``` nicht gelöscht ist und über einen gültigen Besitzer
verfügt. Mit ```!= address(0)``` wird der geprüft ob sich um mehr als einen
uninitialisierten Account handelt. 


```{caption="Gebühr (Fee) und Modifier whenFeePaid" label=li_fee .sol .numberLines}
uint public fee = 1 ether;

modifier whenFeePaid {
	require(msg.value >= fee);
	_;
}
```
Im Codeausschnitt \ref{li_fee} ist auf Zeile 1 die Höhe der Gebühr (```fee```)
definiert. Ab Zeile 3 folgt ein Modifier. Dieser überprüft, ob der Betrag in der
Transaktion gross genug ist, um die Gebühr von Zeile 1 zu bezahlen. 


```{caption="Methode Reserve" label=li_reserve .sol .numberLines}
function reserve(bytes32 _name)
	external
	payable
	whenUnreserved(_name)
	whenFeePaid
	returns (bool success)
{
	entries[_name].owner = msg.sender;
	emit Reserved(_name, msg.sender);
	return true;
}
```
Unter \ref{li_reserve} wird gezeigt, wie mit der Methode ```reserve``` ein
Eintrag in der Liste ```entries``` für den Namen ```_name``` reserviert wird.
Durch die Verwendung von ```external``` auf Zeile 2, kann die Methode von
anderen Accounts aufgerufen werden.\
Der Modifier ```payable``` erlaubt es, Ether an die Methode zu senden. Auf Zeile
4 wird überprüft, ob der Eintrag in ```entries``` noch frei ist. Schliesslich
wird geprüft ob der Transaktion genügend Ether mitgegeben wird um die Gebühr zu
begleichen.\
Wenn alle Prüfungen erfolgreich sind, wird in ```entries``` ein neuer Eintrag
erstellt. Als Besitzer des Eintrags wird der Sender der Transaktion gesetzt. Auf
Zeile 9 wird die erfolgreiche Reservierung ans Netzwerk gesendet.

```{caption="Methode setAddress" label=li_setAddress .sol .numberLines}
function setAddress(bytes32 _name, string _key, address _value)
	external
	whenEntryRaw(_name)
	onlyOwnerOf(_name)
	returns (bool success)
{
	entries[_name].data[_key] = bytes32(_value);
	emit DataChanged(_name, _key, _key);
	return true;
}
```
Mit Methode ```setAddress``` unter \ref{li_setAddress}, wird ein reservierter
Eintrag in ```entries``` befüllt. Als erster Parameter wird der Name des Eintags
(```_name```) übergeben. Dieser muss identisch zum verwendeten Namen in der
Methode ```reserve``` sein. Mit dem Parameter ```_key``` wird der Zugriff auf
die innere Map ```data``` verwaltet. Mit ```_value``` wird die zu registrierende
Adresse übergeben.\
Auch diese Methode muss von Aussen aufgerufen werden können, daher
```external``` auf zeile 2. Wenn die Bedingungen von ```whenEntryRaw``` und
```onlyOwnerOf``` auf Zeile 3 und 4 erfüllt sind, wird die eigentliche
Registrierung vorgenommen.\
In der Map ```data``` wird die Adresse (```_value```) an der Position ```_key```
gespeichert.\
Die Änderung der Daten wird auf Zeile 9 ans Netzwerk gesendet.  

#### Certifier \label{sec_simpleCertifier}

Als Standard werden alle Transaktionen mit einem Gas Price von 0 verworfen. Das
heisst, diese Transaktionen werden bereits beim Node zurückgewiesen und
erreichen nie die Blockchain. Dieses Verhalten kann geändert werden. Mit der
Registrierung des Certifiers bei der Name Registry. Beim Start von Parity wird
geprüft ob der Eintrag in ```entries``` vorhanden ist. Sofern vorhanden, werden
Transaktionen mit einem Gas Price von 0 nicht mehr direkt abgewiesen, sondern es
wird geprüft ob der Absender zertifiziert ist. Transaktionen von zertifizierten
Accounts werden selbst mit einem Gas Price von 0 in die Blockchain aufgenommen.
Gratis Transaktionen von unzertifiziereten Benutzern werden weiterhin
abgewiesen. 

In diesem Abschnitt sind besonders wichtige Abschnitte des SimpleCertifiers
aufgeführt und erklärt. Der gesamte Code ist im Anhang unter
\ref{app_parity_code} verlinkt. 

```{caption="Die Whitelist im Certifier" label=li_whitelist .sol .numberLines}
struct Certification {
	bool active;
}
mapping (address => Certification) certs;
```

Das ```mapping``` unter \ref{li_whitelist} ist die zentrale Datenstruktur des
Certifiers, die Whitelist. In der Liste ```certs``` sind zertifizierte Accounts
gespeichert. 


```{caption="Modifier onlyDelegate" label=li_onlyDelegate .sol .numberLines}
address public delegate = msg.sender;

modifier onlyDelegate {
	require(msg.sender == delegate);
	_;
}
```
Auf Zeile 1 des Listings \ref{li_onlyDelegate}, wird der Besitzer
(```msg.sender```) des Smart Contracts gespeichert und der Variabel
```delegate``` zugewiesen. Mit dem Modifier wird geprüft ob es sich beim
Absender der aktuellen Anfrage um den Besitzer des Smart Contracts handelt. 

```{caption="Methode certify" label=li_certify .sol .numberLines}
function certify(address _who)
	external
	onlyDelegate
{
	certs[_who].active = true;
	emit Confirmed(_who);
}
```
Mit der unter \ref{li_certify} aufgeführten Methode, wird ein Account
registriert. Als Paramater wird die zu registrierende Adresse (```_who```)
angegeben. Mit ```external``` auf Zeile 2 ist die Methode von Aussen aufrufbar.\
Zeile 3 stellt sicher, dass nur der Besitzer des Certifiers einen Account
registrieren kann. Ist diese Prüfung erfolgreich, wird der Account ```_who```
der Liste ```certs``` hinzugefügt. Der Account ist nun für gratis Transaktionen
berechtigt.\
Der Event wird auf Zeile 6 an das Netzwerk gesendet.

```{caption="Methode certified" label=li_certified .sol .numberLines}
function certified(address _who)
	external
	view
	returns (bool)
{
	return certs[_who].active;
}
```
Mit der Methode ```certified```, unter \ref{li_certified}, kann jederzeit überprüft werden, ob ein Account
(```_who```) zertifierziert ist. Mit ```view``` auf Zeile 3 ist deklariert, dass
es sich um eine Abfrage ohne weitere Komputationskosten handelt. Solche Abfragen
sind daher mit keinen Transaktionskosten verbunden. 


```{caption="Methode revoke" label=li_revoke .sol .numberLines}
function revoke(address _who)
    external
    onlyDelegate
    onlyCertified(_who)
{
    certs[_who].active = false;
    emit Revoked(_who);
}
```
Die Methode ```revoke``` entfernt einen zertifizierten Account (```_who```) von
der Whitelist. Auf Zeile 3 wird wiederum sichergestellt, dass nur der Besitzer
des Certifiers Änderungen vornehmen kann. Weiter wird auf Zeile 4 verifiziert,
dass der Account ```_who``` in der Whitelist ```certs``` registriert ist.\
Sind alle Bedingungen erfüllt, wird der Account von der Whitelist entfernt. Der
Event wird auf Zeile 7 an die Blockchain gesendet. 

### Geprüfte Alternativen

Bei der Auswahl des Ethereumclienten sind die populärsten[@stack_clientList] berücksichtigt worden. Nebst Parity sind daher noch Geth, Aleth und Trinity evaluiert worden. Bei diesen
Clients ist keine Möglichkeit vorhanden, bestimmte Accounts für gratis
Transaktionen zu priviligieren. Daher sind sie zu diesem Zeitpunkt nicht für die
FHNW geeignet.
