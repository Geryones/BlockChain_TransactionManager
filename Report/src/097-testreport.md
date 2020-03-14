## Abnahme Tests Report

### Abnahme Test 1

**AK Nr.:**   #1    
**Titel:**  Bezahlte Transaktionen für alle  
**Testart:**  Manuell  
**Tester:**  Faustina Bruno  
**Datum:**  15.3.2020  
**Status:**  ERFOLGREICH  
**Vorbedingung:**  
1. MetaMask installiert 
2. 2 Accounts in MetaMask eingerichtet: (1.Account Add: 0xdb3cc88CA30407c079deCBcfF9c34E4a23Aaa669 PK: 080BACEA441C50059857889AFD35D22E91C5F27C1639BE441C8E456DF678B28D 2. egal) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist

**Ablauf:** 

1. MetaMask starten 
2. Zum Account mit der Adresse "0xdb3cc88CA30407c079deCBcfF9c34E4a23Aaa669" wechseln
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. zweiten Account wählen 
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 2 eingeben 
6. WEITER und BESTÄTIGEN wählen
7.Warten bis die Transaktion durchlaufen ist 

**Erwünschtes Resultat:** 
Eine bestätigte Transaktion      
**Tatsächliches Resultat:**
Die Transaktion ist erfolgreich durchgeführt worden

### Abnahme Test 2

**AK Nr. :**   #2    
**Titel:**  Gratis Transaktionen nur für Accounts in Whitelist
**Testart:**   Manuell    
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020  
**Status:**  ERFOLGREICH 
**Vorbedingung:**  
1. MetaMask installiert 
2. 2 Accounts in MetaMask eingerichtet (1. Add: 0x3e7Beee9585bA4526e8a7E41715D93B2bE014B34 PK: FD825395E5B421CE6DDCEDBE4205FAB1F916E73E56721D5FD4D49C540BA2DB94 2. ein Account welcher nicht in der Whitelist ist) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist

**Ablauf:**
1. MetaMask starten
2. Zertifizierten Account wählen
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. zweiten Account wählen
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Auf den 2. Account wechseln
9. Kontrollieren ob der Betrag überwiesen wurde
10. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
11. Zertifizierten Account wählen
12. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben
13. WEITER und BESTÄTIGEN wählen 
14. Warten bis die Transaktion durchlaufen ist
**Erwünschtes Resultat: **  
- Erste Transaktion erfolgreicher durchlaufen
- Zweite Transaktion abgebrochen
**Tatsächliches Resultat:**  
- Erste Transaktion ist erfolgreich durchlaufen
- Die zweite Transaktion wurde abgebrochen
 

### Abnahme Test 3

AK Nr.:   #3    
Titel:  Account aus Liste für Whitelist zertifizieren
Testart:   Manuell  
Tester:   Faustina Bruno  
Datum:   15.3.2020
Status:  ???
Vorbedingung:
1. Metamask installiert 
2. Alle Accounts aus der Account Liste sind in MetaMask eingerichtet 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist  

**Ablauf:** 
:Für jeden Account wird der gleiche Ablauf durchgeführt
1. MetaMask starten
2. Zertifizierten Account wählen
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
Erwünschtes Resultat:    
- Erste Transaktion erfolgreicher Durchlauf
- Zweite Transaktion abgebrochen
Tatsächliches Resultat: ????
### Abnahme Test 4

**AK Nr.:**   # 4   
**Titel:**  Account aus Liste und Whitelist entfernen
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. 1 Account aus der Liste der gelöscht wird in Metamask eingerichtet (1. Add: PK: 2. egal) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist  
**Ablauf:** 
1. MetaMask starten
2. Account wählen
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Algorithmus stoppen
9. Account der gelöscht werden soll in Account Liste JSON Datei als solcher kennzeichnen
10. DoS Algorithmus starten (run-Befehl)
11. MetaMask starten
12. Account wählen
13. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
14. Beliebigen Account wählen
15. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
16. WEITER und BESTÄTIGEN wählen 
17. Warten bis die Transaktion durchlaufen ist
18. Account Liste Datei kontrollieren
**Erwünschtes Resultat:**   
- Erste Transaktion erfolgreicher Durchlauf
- Zweite Transaktion abgebrochen
- Account ist nicht mehr in der JSON Datei
**Tatsächliches Resultat:** ????

### Abnahme Test 5
**AK Nr.:**   #5  & #11
**Titel:**  Account nach Transaktionen sperren
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist  
5. Account hat in dr JSON Datei die Transaktionslimite auf 5 gesetzt
**Ablauf:** 
1. MetaMask starten
2. Account wählen
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Dies 6 Mal durchführen
**Erwünschtes Resultat:**   
- Die letzte Transaktion wird abgebrochen
- Der Account hat in der JSON Datei einen Timestamp eingetragen
- Der Account hat in der JSON Datei keine übrigen Transaktionen
      
**Tatsächliches Resultat:** ????

### Abnahme Test 6

**AK Nr.:**   #6     & #11
**Titel:**  Account nach GasUsed sperren
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
5. Account hat in der JSON Datei die gasUsed Limite auf 42000 gesetzt
**Ablauf:**
1. MetaMask starten
2. Account wählen
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Dies 3 Mal durchführen.
**Erwünschtes Resultat:**   
- Die letzte Transaktion wird abgebrochen
- Der Account hat in der JSON Datei einen Timestamp eingetragen
- Der Account hat in der JSON Datei keine übriges Gas mehr
      
**Tatsächliches Resultat:** ????

### Abnahme Test 7
**AK Nr.:**   #7   & 10
**Titel:**  Gesperrte Account entsperren A
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
5. Account Revoke Time auf JSON Datei auf 2' setzten
**Ablauf:** 
1. MetaMask starten
2. Account wählen
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Dies so oft durchführen, bis der Account geperrt ist.
9. Dannach 2' warten
10. Erneut eine gratis Transaktion durchführen
**Erwünschtes Resultat:**   
Dass eine gratis Transaktion wieder durchführbar ist, nahdem der Account gesperrt wurde und 2' gewartet wurde      
**Tatsächliches Resultat:** ????

### Abnahme Test 8
**AK Nr.:**   #7   
**Titel:**  Gesperrte Account entsperren B
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
5. Account Revoke Time auf JSON Datei auf 2' setzten
**Ablauf:** 
1. MetaMask starten
2. Account wählen
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Dies so oft durchführen, bis der Account geperrt ist.
9. DoS Algorithmus stoppen
10. 4' warten
11. DoS Algorithmus wieder starten
12. Erneut eine gratis Transaktion durchführen
**Erwünschtes Resultat:**   
Dass eine gratis Transaktion wieder durchführbar ist, nahdem der Account gesperrt , das Programm kurzzeitig gestoppt und wieder gestartet wurde.   
**Tatsächliches Resultat:** ????

### Abnahme Test 9

**AK Nr.:**   #8   
**Titel:** Reset Zeitintervall setzten 
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
5. Intervall Zeit auf 2' in der DefaultSettings JSON Datei setzten
**Ablauf:** 
1. MetaMask starten
2. Account wählen
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Schauen ob der Transaktionscounter in der JSON Datei um 1 runter ist
9. 2' warten        
**Erwünschtes Resultat:**   
Alle Counter sind wieder auf die max Limite zurückgesetzt      
**Tatsächliches Resultat:** ????

### Abnahme Test 10
**AK Nr.:**   #9    
**Titel:**  Speicherung des Zeitintervalls
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
5. Intervall Zeit auf 5' in der DefaultSettings JSON Datei setzten
**Ablauf:** 
1. MetaMask starten
2. Warten bis der erste Intervall gestartet hat
3. Kontrollieren ob ein neuer Timestamp in die DefaultSettings JSON Datei geschrieben wurde und sich diesen merken 
4. Beliebigen Account wählen
5. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
6. anderen Account wählen
7. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
8. WEITER und BESTÄTIGEN wählen 
9. Warten bis die Transaktion durchlaufen ist
10. Schauen ob der Transaktionscounter in der JSON Datei um 1 runter ist
11. DoS Algorithmus für 2' pausieren und wieder starten
12. Warten ob der Intervall bei der vorgemerkten Zeit neu startet

**Erwünschtes Resultat:**
-Alle Counter sind wieder auf die max Limite zurückgesetzt 
-Intervall wird trotz der Pause zum richtigen Zeitpunkt neu gestartet
**Tatsächliches Resultat:** ????

### Abnahme Test 11

**AK Nr.:**   #10 A   
**Titel:** Sperrzeit 
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
5. Account hat keine Revoke zeit eingestellt
6. In den Default Settings ist die Default Revoke Time auf 2 min und der resetIntervall auf 5 min gesetzt
**Ablauf:** 
1. MetaMask starten
2. Account wählen
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Dies so oft durchführen, bis der Account geperrt ist.
9. Dannach 2' warten
10. Erneut eine gratis Transaktion durchführen       
**Erwünschtes Resultat:**   
Account ist nach der Default Revoke Zeit wieder entsperrt     
**Tatsächliches Resultat:** ????

### Abnahme Test 12

**AK Nr.:**   #13  
**Titel:**  Default Werte für Limiten A
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account ist ohne Transaktionslimite in JSON Datei eingetragen & Default Transaktionslimite ist auf 3 gesetzt
3. Account in MetaMask eingerichtet (1. Add: PK: ) 
4. Blockchain ist aufgesetzt und läuft 
5. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
**Ablauf:** 
1. MetaMask starten
2. Account wählen
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Dies 4 Mal durchführen
**Erwünschtes Resultat:**   
- Die letzte Transaktion wird abgebrochen
- Der Account hat in der JSON Datei einen Timestamp eingetragen
- Der Account hat in der JSON Datei keine übrigen Transaktionen              
**Tatsächliches Resultat:** ????

### Abnahme Test 13

**AK Nr.:**   #13 B   
**Titel:**  Default Werte für Limiten
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account ist ohne Gaslimite in JSON Datei eingetragen & Default Gaslimite ist auf 63000 gesetzt
3. Account in MetaMask eingerichtet (1. Add: PK: ) 
4. Blockchain ist aufgesetzt und läuft 
5. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
**Ablauf:** 
1. MetaMask starten
2. Account wählen
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Dies 4 Mal durchführen       
**Erwünschtes Resultat:**   
- Die letzte Transaktion wird abgebrochen
- Der Account hat in der JSON Datei einen Timestamp eingetragen
- Der Account hat in der JSON Datei kein übriges Gas         
**Tatsächliches Resultat:** ????

### Abnahme Test 14

**AK Nr.:**   #16   
**Titel:**  Transaktions Manager Account kann nicht gesperrt werden
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account hat die Transaktionslimite 3
3. Account in MetaMask eingerichtet (1. Add: PK: ) 
4. Blockchain ist aufgesetzt und läuft 
5. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
**Ablauf:** 
1. MetaMask starten
2. Account wählen
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Dies 4 Mal durchführen
**Erwünschtes Resultat:**   
Account wird nicht gesperrt und kann weiterhin Transaktionen durchführen      
**Tatsächliches Resultat:** ????

