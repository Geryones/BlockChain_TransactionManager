## Abnahme Tests Report

### Abnahme Test 1

**AK Nr.:**   #1    
**Titel:**  Bezahlte Transaktionen für alle  
**Testart:**  Manuell  
**Tester:**  Faustina Bruno  
**Datum:**  15.3.2020
**Status:**  ???
**Vorbedingung:**
1. MetaMask installiert 
2. 2 Accounts in MetaMask eingerichtet (1. Add: PK: 2. egal) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist

**Ablauf:** 
1. MetaMask starten 
2. Zum Account mit der Adresse "" wechseln
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. 2. Account wählen 
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 2 eingeben 
6. WEITER und BESTÄTIGEN wählen 
7.Warten bis die Transaktion durchlaufen ist        
**Erwünschtes Resultat:** Eine durchlaufene Transaktion      
**Tatsächliches Resultat:** ????

### Abnahme Test 2

**AK Nr. :**   #2    
**Titel:**  Gratis Transaktionen nur für Accounts in Whitelist
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. MetaMask installiert 
2. 2 Accounts in MetaMask eingerichtet (1. Add: PK: 2. ein Account welcher nicht in der Whitelist ist) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist

**Ablauf:**
1. MetaMask starten
2. Zertifizierten Account wählen
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. 2. Account wählen
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
- Erste Transaktion erfolgreicher Durchlauf
- Zweite Transaktion abgebrochen
**Tatsächliches Resultat:** ????
 

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
**AK Nr.:**   #5    
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
**Ablauf:** 
1. MetaMask starten
2. Account wählen
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Account wählen
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Dies einmal mehr als die Transaktionslimite dieses Account ist durchführen
**Erwünschtes Resultat:**   
- Die letzte Transaktion wird abgebrochen
- Der Account hat in der JSON Datei einen Timestamp eingetragen
- Der Account hat in der JSON Datei keine übrigen Transaktionen
      
**Tatsächliches Resultat:** ????

### Abnahme Test 6

**AK Nr.:**   #6    
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
**Ablauf:**
1. MetaMask starten
2. Account wählen
3. auf SENDEN dann ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Account wählen
5. In das Betrag Feld 100 ETH eingeben und in das Transaktionsgebühr Feld 0 eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Dies einmal mehr als die Gaslimite dieses Account ist, durchführen
**Erwünschtes Resultat:**   
- Die letzte Transaktion wird abgebrochen
- Der Account hat in der JSON Datei einen Timestamp eingetragen
- Der Account hat in der JSON Datei keine übriges Gas mehr
      
**Tatsächliches Resultat:** ????

### Abnahme Test 7
**AK Nr.:**   #7   
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
4. Account wählen
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
4. Account wählen
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
4. Account wählen
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
4. Account wählen
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

**AK Nr.:**   #   
**Titel:**  
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
**Ablauf:** 
1. 
2. 
3. 
4. 
5. 
6.  
7.         
**Erwünschtes Resultat:**   
      
**Tatsächliches Resultat:** ????

### Abnahme Test 12

**AK Nr.:**   #   
**Titel:**  
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
**Ablauf:** 
1. 
2. 
3. 
4. 
5. 
6.  
7.         
**Erwünschtes Resultat:**   
      
**Tatsächliches Resultat:** ????

### Abnahme Test 13

**AK Nr.:**   #   
**Titel:**  
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
**Ablauf:** 
1. 
2. 
3. 
4. 
5. 
6.  
7.         
**Erwünschtes Resultat:**   
      
**Tatsächliches Resultat:** ????

### Abnahme Test 14

**AK Nr.:**   #   
**Titel:**  
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
**Ablauf:** 
1. 
2. 
3. 
4. 
5. 
6.  
7.         
**Erwünschtes Resultat:**   
      
**Tatsächliches Resultat:** ????

### Abnahme Test 15

**AK Nr.:**   #   
**Titel:**  
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
**Ablauf:** 
1. 
2. 
3. 
4. 
5. 
6.  
7.         
**Erwünschtes Resultat:**   
      
**Tatsächliches Resultat:** ????
### Abnahme Test 13

**AK Nr.:**   #   
**Titel:**  
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
**Ablauf:** 
1. 
2. 
3. 
4. 
5. 
6.  
7.         
**Erwünschtes Resultat:**   
      
**Tatsächliches Resultat:** ????

### Abnahme Test 

**AK Nr.:**   #   
**Titel:**  
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
**Ablauf:** 
1. 
2. 
3. 
4. 
5. 
6.  
7.         
**Erwünschtes Resultat:**   
      
**Tatsächliches Resultat:** ????

### Abnahme Test 

**AK Nr.:**   #   
**Titel:**  
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
**Ablauf:** 
1. 
2. 
3. 
4. 
5. 
6.  
7.         
**Erwünschtes Resultat:**   
      
**Tatsächliches Resultat:** ????
### Abnahme Test 

**AK Nr.:**   #   
**Titel:**  
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
**Ablauf:** 
1. 
2. 
3. 
4. 
5. 
6.  
7.         
**Erwünschtes Resultat:**   
      
**Tatsächliches Resultat:** ????

### Abnahme Test 

**AK Nr.:**   #   
**Titel:**  
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020
**Status:**  ???
**Vorbedingung:**
1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Add: PK: ) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account ist zertifiziert/ in der Whitelist
**Ablauf:** 
1. 
2. 
3. 
4. 
5. 
6.  
7.         
**Erwünschtes Resultat:**   
      
**Tatsächliches Resultat:** ????
