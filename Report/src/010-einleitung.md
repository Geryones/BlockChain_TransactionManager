# Einleitung

Dieses Kapitel liefert eine ausführliche Zusammenfassung der Bachelorthesis. Weiter ist
eine Übersicht über die Strukturierung des Berichts gegeben. 

## Problemstellung und Ziel

Die Fachhochschule Nordwest Schweiz[@fhnw] (FHNW) möchte für die Studierenden und Mitarbeiter
eine Blockchain zur Verfügung stellen. Ihnen sollen so eine Möglichkeit
geboten werden, erste Erfahrungen und Wissen im Umgang mit einer Blockchain zu
gewinnen.\
Der beste Schutz einer Blockchain gegen eine DoS Attacke, sind die anfallenden
Kosten für den Angreifer. Auf jede Transaktion wird eine Gebühr erhoben. Bei
Ethereum werden zusätzlich anfallender Aufwand auf der Blockchain
berücksichtigt. Die benötigte Rechenleistung wird mit Gas beziffert. Je komplexer
der Task, desto mehr Gas wird benötigt. Es existiert ein Maximum an Gas, dass
durch eine Transaktion verbraucht werden kann. Wird dieses Maximum erreicht
bevor die Berechnungen fertig sind, werden diese Abgebrochen. Das ist ebenfalls
ein Schutzmechanismus gegen DoS Attacken. Ohne diesen Schutz, könnten zum
Beispiel Schleifen ohne Abbruchbedingung für einen Angriff verwendet werden.\
Um die Kosten einer Transaktion zu berechnen, wird das verbrauchte Gas mit dem
Gas Preis[@gasprice] multipliziert. Diese Kosten werden vom Sender einer
Transaktion an den Node gezahlt, der die Transaktion verarbeitet hat.\
Für eine Lernumgebung sind anfallende Kosten nicht praktikabel. Daher soll ein Weg
gefunden werden, um einer definierten Benutzergruppe gratis Transaktionen zu
ermöglichen, ohne die Blockchain anfällig gegen DoS Attacken zu machen.



## Blockchain-Transaktionsmanager

Es wurde eine Ethereumblockchain[@ethereum][@wiki_blockchain] aufgesetzt, die es einer
spezifischen Benutzergruppe erlaubt, gratis Transaktionen zu tätigen. Diese
Transaktionen werden durch den Blockchaintransaktionmanager überwacht. Der
entwickelte Transaktionsmanager stellt sicher, dass gratis Transaktionen
nicht für eine Denial of Service (DoS) Attacke[@wiki_dos] genutzt werden können.

![Interaktion von Benutzer, Blockchain und Transaktionsmanager \label{img_intro_overview}](images/overview_blockchain_txmanager.png "Übersicht")

Auf der Grafik \ref{img_intro_overview} sind die Interaktionen zwischen einem
Benutzer, dem Blockchainnetzwerk und dem Transaktionmanager ersichtlich.\
Ein Benutzer sendet mit seinem Account eine gratis Transaktion an einen Node der
Blockchain. Dieser prüft, ob der verwendete Account für gratis Transaktionen
berechtigt ist. Dafür wird eine Whitelist[@wiki_whitelisting] verwendet. Diese
befindet sich auf der Blockchain. Ist diese Prüfung erfolgreich, wird die
Transaktion in den nächsten Block aufgenommen.\
Der Transaktionmanager registriert, dass eine neue gratis Transaktion in die
Blockchain aufgenommen worden ist. Der Sender der Transaktion wird ermittelt.
Mit dem DoS Algorithmus wird geprüft, ob der verwendete Account mit dieser
Transaktion gegen eine Richtlinie verstösst. Sollte diese Prüfung ergeben, dass
ein Verstoss vorliegt, wird der Account von der Whitelist in der Blockchain
gelöscht. Im Transaktionsmanager wird vermerkt, dass sich dieser Account
momentan nicht mehr auf der Whitelist befindet. Das hat zur Folge, dass mit
diesem Account keine gratis Transaktionen mehr getätigt werden können.\
Der Transaktionsmanager kann den Account nach gewissen Regeln und in
Abhängigkeit der Zeit, wieder auf die Whitelist setzen. Der Benutzer kann den
Account somit wieder für gratis Transaktionen verwenden.

Der Transaktionsmanager kann durch die Betreiber konfiguriert werden. Die
Parameter für den DoS Algorithmus sind pro Account individuell definierbar.\
Wird die Whitelist im Transaktionsmanager mit weiteren Accounts ergänzt, werden
diese an das Blockchainentzwerk übermittelt und dort ebenfalls in die Whitelist
aufgenommen. Accounts können auch permanent von gratis Transaktionen
ausgeschlossen werden.  

## Resultat

Parity ist zur Zeit der einzige Ethereumclient, der über ein Benutzermanagement
für gratis Transaktionen verfügt. Durch die Verwendung von Smart
Contracts[@smartContractDef] ist eine Whitelist für gratis Transaktionen
möglich. Da die Whitelist auf der Blockchain gespeichert ist, kann sie von allen
Nodes verwendet werden.\
Sobald auf einem Node eine gratis Transaktion eingeht, wird geprüft, ob sich der
verwendete Account auf der Whitelist befindet. Nur dann wird die Transaktion
vom Node angenommen und weiterverarbeitet.\
Der Blockchaintransaktionsmanger ist als Java-Applikation realisiert worden.
Diese interagiert mit der Whitelist von Parity. Die Interaktion mit dem
Betreiber des Transaktionsmanagers findet über die Kommandozeile und
Konfigurationsdateien statt.\
Es wird der aktuelle Block der Blockchain aufgerufen und auf Transaktionen
untersucht. Bei gefundenen gratis Transaktionen wird das Verhalten des
Senderaccounts evaluiert. Anhand der Anzahl getätigten gratis Transaktionen und
dem dabei verbrauchtem Gas, wird bestimmt, ob die Transaktion Teil einer DoS
Attacke ist. Fällt diese Prüfung positiv aus, wird der Account für eine
bestimmte Dauer von der Whitelist entfernt. Das bedeutet, dass er keine gratis
Transaktionen mehr tätigen kann. Reguläre, also kostenpflichtige Transaktionen,
sind weiterhin möglich.\
Die verfügbaren gratis Transaktionen und Gas, sowie die Dauer einer
Suspendierung von der Whitelist können konfiguriert werden. Der Betreiber hat
die Möglichkeit, diese Parameter für jeden Account individuell zu definieren.\
Um eine individuelle Suspendierung von der Whitelist zu ermöglichen, wird eine
Priority-Queue und ein Command-Pattern verwendet. 


## Strukturierung des Berichts

 Der Bericht ist in einen theoretischen und praktischen Teil gegliedert.
 Geprüfte Tools, der aktuelle Stand der
 Ethereumblockchain, sowie die konzipierten Lösungsansätze und deren Evaluation
 werden im theoretischen Teil behandelt.\
 Im praktischen Teil wird beschrieben, wie das gewonnene Wissen umgesetzt wird.
 Es wird auf die implementierte Lösung und deren Vor- und Nachteile eingegangen.
 Geprüfte Alternativen und deren Argumente sind ebenfalls enthalten.\
 Das Fazit bildet den Abschluss des eigentlichen Berichts. Im Anhang ist eine
 Beschreibung der Entwicklungsumgebung, die Installationsanleitung und Links zum
 verwendeten Code zu finden. 

