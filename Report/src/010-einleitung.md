# Einleitung

Dieses Kapitel liefert eine ausführliche Zusammenfassung der Bachelorthesis. . Weiter ist
eine Übersicht über die Strukturierung des Berichts gegeben. 

## Blockchaintransaktionmanager

Es ist eine private Ethereumblockchain aufgesetzt worden, die es einer
spezifischen Benutzergruppe erlaubt, gratis Transaktionen zu tätigen. Diese
Transaktionen werden durch den Blockchaintransaktionmanager überwacht. Der
entwickelte Transaktionsmanager stellt sicher, dass die gratis Transaktionen
nicht für eine Denial of Service (DoS) Attacke[@wiki_dos] genutzt werden können.

## Problemstellung und Ziel

//TODO , keine Verweise

Die Aufgabe beinhaltet ein Blockchain Netzwerk [@wiki_blockchain] für die
Fachhochschule Nordwest Schweiz[@fhnw] (FHNW) zur Verfügung zu stellen, welches
von den Studierenden zu Testzwecken genutzt werden kann.\
Blockchains verfügen über verschiedene Mechanismen, um sich gegen Attacken
abzusichern. Eine davon ist eine Gebühr auf jeder Transaktion, der sogenannte
Gas Preis[@gasprice]. Dadurch können DoS Attacken, bei denen das Netzwerk mit unzähligen
Transaktionen geflutet wird, effizient bekämpft werden. Der Angreifer kann die
Attacke nicht aufrecht erhalten, da ihm die finanziellen Mittel ausgehen.\
Obwohl dieser Schutzmechanismus auf einer öffentlichen Blockchain sehr effizient
und elegant ist, eignet er sich nicht für eine Lernumgebung. Hier sollen
Anwender die Möglichkeit haben, Transaktionen ohne anfallende Gebühren ausführen
zu können. Dadurch wird jedoch die Blockchain anfällig für DoS Attacken. 

Das Ziel der Arbeit ist es ein Test Blockchain Netzwerk aufzubauen, welches für
eine definierte Gruppe von Benutzern gratis Transaktionen erlaubt und trotzdem
über einen Schutzmechanismus gegen DoS Attacken verfügt.

## Methodik
 
Zu Beginn ist ein provisorischer Projekt Plan mit möglichen Arbeitspaketen und
Meilensteine definiert worden. Da die Thematik komplett unbekannt ist, wird auf ein
agiles Vorgehen gesetzt. So können neue Erkentnisse in die Planung
einfliessen. Nach der Einlese- und Probierphase, sind Lösungskonzepte
konzipiert, evaluiert und an der Zwischenpräsentation dem Experten und den
Betreuern präsentiert worden. Das weitere Vorgehen ist besprochen und neue
Meilensteine definiert worden. Die Arbeitspakete werden alle zwei Wochen definiert.

## Strukturierung des Berichts

 Der Bericht ist in einen theoretischen und praktischen Teil gegliedert.
 Gemachte Literaturstudiuen, geprüfte Tools, der aktuelle Stand der Ethereum
 Blockchain, sowie die konzipierten Lösungsansätze und derern Evaluation werden
 im theoretischen Teil behandelt.\
 Im praktischen Teil wird beschrieben, wie das gewonnene Wissen umgesetzt wird.
 Es wird auf die implementierte Lösung und deren Vor- und Nachteile eingegangen.
 Geprüfte Alternativen und deren Argumente sind ebenfalls enthalten.\
 Das Fazit bildet den Abschluss des eigentlichen Berichts. Im Anhang ist eine
 Beschreibung der Entwicklungsumgebung, die Installationsanleitung und
 verwendeter Code zu finden. 

