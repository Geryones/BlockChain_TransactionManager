
### Initialisierung \label{sec_prac_init}

Wenn die Blockchain frisch aufgesetzt wird, sind initial keine gratis
Transaktionen möglich. Der dafür nötige Certifier ist weder deployed noch
bei der Name Registry registriert.\
Mit der Klasse ```Init``` wird die Blockchain für den
Betrieb vorbereitet. Folgende Schritte werden dabei ausgeführt:

1. Instanziierung der Name Registry\
   Mit der Wrapperklasse für die Name Registry und deren Adresse auf der
   Blockchain wird ein Objekt für die Interaktion mit dem eigentlichen Smart
   Contract erzeugt. 
2. Deployment des Certifiers\
   Die Wrapperklasse für den Certifier wird instanziiert und auf die Blockchain
   deployed. 
3. Registrierung des Certifiers bei der Name Registry\
   Die Adresse des Certifiers wird bei der Name Registry registriert.
4. Zertifizierung von Account für Transaktionsmanager\
   Der Account des Transaktionsmanagers wird für gratis Transaktionen
   berechtigt. 

Siehe \ref{sec_prac_deployment} für mehr Informationen zu Wrapperklassen,
Deployment und Registrierung von Accounts.

Die Adresse der Name Registry wird aus der Konfigurationsdatei gelesen, siehe
\ref{sec_prac_conf}. Hier muss beachtet werden, dass diese mit der Adresse in
der Blockchainspezifkation, siehe \ref{sec_prac_spec}, übereinstimmen muss.\
Sobald der Certifier deployed ist, wird dessen Adresse in die
Konfigurationsdatei geschrieben. Sobald die Überwachung der Blockchain gestartet
wird, wird die Adresse ausgelesen und der Certifier instanziiert.\
Der Account für den Transaktionsmanger wird in der Blockchainspezifikation
definiert, siehe \ref{sec_prac_spec}. Dieser Account wird verwendet um
Änderungen an der Whitelist vorzunehmen. Aus Sicherheitsgründen wird der private
Schlüssel von diesem Account nicht in den Quellcode des Transaktionsmanagers
geschrieben. Er wird beim Start der Applikation aus einer eigenen Datei gelesen.
Hier muss beachtet werden, dass diese Datei bei der Verwendung von einer
Versionierungssoftware nicht inkludiert wird.


### Run

Mit der Klasse ```Run``` wird der Transaktionsmanger für den regulären Betrieb
gestartet. Voraussetzung ist, dass der Certifier deployed und registriert ist,
siehe \ref{sec_prac_init}.\
Beim Aufruf der Klasse ```Run``` werden folgende Schritte ausgeführt:

1. Laden der DefaultSettings\
   Die Datei ```DefaultSettings.json``` wird ausgelesen und das Objekt
   ```JsonDefaultSettings``` damit befüllt. 
2. Laden der Accountliste\
   Die Datei ```AccountList.json``` wird ausgelesen. Die Accounts werden mit den
   konifgurierten Parameter instanziiert. 
3. Instanziierung von Name Registry und Certifier\
   Mit der jeweiligen Adresse, wird die Name Registry und der Certifier instanziiert. 
4. Die Klasse ```ChainInteractions``` wird instanziiert. 
5. Zertifizierung aller geladenen Accounts\
   Alle geladenen Accounts werden geprüft. Sollte ein Account über einen
   Zeitstempel verfügen, wird geprüft ob er suspendiert werden muss. Ansonsten
   werden alle Accounts zertifiziert. 
6. Instanziierung der Klasse ```SubscriptionTX```\
   Eine Subscription, die eigentliche Überwachung der Blockchain, wird
   gestartet. Das Command ```ResetAccountsCommand``` fügt sich rekursiv in die
   Priority Queue ein. 

Sobald der Transaktionsmanager mit einer Kommandozeile gestartet wurde, wird der
Benutzer über aktuellen Vorgänge mit Lognachrichten informiert. 
