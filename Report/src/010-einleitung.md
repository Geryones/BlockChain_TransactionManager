# Einleitung

Dieses Kapitel liefert eine ausführliche Zusammenfassung der Bachelorthesis. Es
ist die Problemstellung, das Ziel der Arbeit und die Methodik aufgeführt. Weiter
ist eine Übersicht über die Strukturierung des Berichts gegeben. 

## Problemstellung
Die Aufgabe beinhaltet ein Blockchain Netzwerk [@wiki_blockchain] für die
Fachhochschule Nordwest Schweiz[@fhnw] (FHNW) zur Verfügung zu stellen, welches
von den Studierenden zu Testzwecken genutzt werden kann.\
Blockchains verfügen über verschiedene Mechanismen, um sich gegen Attacken
abzusichern. Eine davon ist eine Gebühr auf jeder Transaktion, der sogenannte
Gas Price \ref{sec_gas} [@gasprice]. Dadurch können Denial of Service (DoS)
Attacken \ref{sec_dos} [@wiki_dos], bei denen das Netzwerk mit unzähligen
Transaktionen geflutet wird, effizient bekämpft werden. Der Angreifer kann die
Attacke nicht aufrecht erhalten, da ihm die finanziellen Mittel ausgehen.\
Obwohl dieser Schutzmechanismus auf einer öffentlichen Blockchain sehr effizient
und elegant ist, eignet er sich nicht für eine Lernumgebung. Hier sollen
Anwender die Möglichkeit haben, Transaktionen ohne anfallende Gebühren ausführen
zu können. Dadurch wird jedoch die Blockchain anfällig für DoS Attacken. 

## Ziel
Das Ziel der Arbeit ist es ein Test Blockchain Netzwerk aufzubauen, welches für
eine definierte Gruppe von Benutzern gratis Transaktionen erlaubt und trotzdem
über einen Schutzmechanismus gegen DoS Attacken verfügt.

## Methodik
 
Zu Beginn wurde ein provisorischer Projekt Plan mit möglichen Arbeitspaketen und
Meilensteine definiert. Da die Thematik komplett unbekannt war, ist auf ein
agiles Vorgehen gesetzt worden. So können neue Erkentnisse in die Planung
einfliessen. Nach der Einlese- und Probierphase, wurden Lösungskonzepte
konzipiert, evaluiert und an der Zwischenpräsentation dem Expertenund den
Betreuern präsentiert. Hier wurde das weitere Vorgehen besprochen und die neuen
Meilensteine definiert. Die Arbeitspakete werden alle zwei Wochen definiert.

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

