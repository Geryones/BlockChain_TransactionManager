## Report der Abnahmetests \label{sec_prac_abnahmeprotokoll}

Der Report zu den durchgeführten Abnahmetests. Jeder Test deckt mindestens ein Abnahmekriterium (AK) ab.


### Abnahmetest 1

**AK Nr.:**   #1    
**Titel:**  Bezahlte Transaktionen für alle  
**Testart:**  Manuell  
**Tester:**  Faustina Bruno  
**Datum:**  15.3.2020  
**Status:**  ERFOLGREICH  
**Vorbedingung:**  

1. MetaMask installiert 
2. Zwei Accounts in MetaMask eingerichtet: (1.Account Add:
   0xdb3cc88CA30407c079deCBcfF9c34E4a23Aaa669 PK:
   080BACEA441C50059857889AFD35D22E91C5F27C1639BE441C8E456DF678B28D 2. Account beliebig) 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft und der Account 1. ist zertifiziert

**Ablauf:** 

1. MetaMask starten 
2. Zum Account mit der Adresse "0xdb3cc88CA30407c079deCBcfF9c34E4a23Aaa669"
   wechseln
3. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. zweiten Account wählen 
5. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 2
   eingeben 
6. WEITER und BESTÄTIGEN wählen
7. Warten bis die Transaktion durchlaufen ist 

**Erwünschtes Resultat:** 

- Eine bestätigte Transaktion   

**Tatsächliches Resultat:**

- Die Transaktion ist erfolgreich durchgeführt worden

### Abnahmetest 2

**AK Nr. :**   #2    
**Titel:**  Gratis Transaktionen nur für Accounts in Whitelist\
**Testart:** Manuell    
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020  
**Status:**  ERFOLGREICH  
**Vorbedingung:**  

1. MetaMask installiert 
2. Zwei Accounts in MetaMask eingerichtet (1. Account Add:
   0x3e7Beee9585bA4526e8a7E41715D93B2bE014B34 PK:
   FD825395E5B421CE6DDCEDBE4205FAB1F916E73E56721D5FD4D49C540BA2DB94 2. ein
   Account welcher nicht in der Whitelist ist) 
3. Blockchain ist aufgesetzt und läuft 
4. Transaktionsmanager läuft und Account 1. ist zertifiziert

**Ablauf:**

1. MetaMask starten
2. Zertifizierten Account wählen
3. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Account 2. wählen
5. In das Feld "Betrag" 100 ETH eingeben und in das Feld Transaktionsgebühr 0
   eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Auf den 2. Account wechseln
9. Kontrollieren ob der Betrag überwiesen wurde
10. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
11. Account 1. wählen
12. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 0
    eingeben
13. WEITER und BESTÄTIGEN wählen 
14. Warten bis die Transaktion durchlaufen ist

**Erwünschtes Resultat:**   

- Erste Transaktion erfolgreicher durchlaufen
- Zweite Transaktion abgebrochen  

**Tatsächliches Resultat:**  

- Erste Transaktion ist erfolgreich durchlaufen
- Die zweite Transaktion wurde abgebrochen


### Abnahmetest 3

**AK Nr.:**   #3    
**Titel:**  Account aus Liste für Whitelist zertifizieren\
**Testart:**   Manuell
**Tester:**   Faustina Bruno   
**Datum:**   15.3.2020  
**Status:**  ERFOLGREICH  
**Vorbedingung:**   

1. MetaMask installiert 
2. Alle Accounts die in der Datei ```AccountList.json``` erfasst sind, sind in MetaMask eingerichtet 
3. Blockchain ist aufgesetzt und läuft 
4. DoS Algorithmus läuft 

**Ablauf:**  
Für jeden Account wird folgender Ablauf durchgeführt

1. MetaMask starten
2. Account wählen
3. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 0
   eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist

**Erwünschtes Resultat:**    

- Bei allen Accounts ein erfolgreicher Durchlauf der Transaktion   

**Tatsächliches Resultat:**  

- Bei allen Accounts ein erfolgreicher Durchlauf der Transaktion   


### Abnahmetest 4

**AK Nr.:**   #4   
**Titel:**  Account aus Liste und Whitelist entfernen  
**Testart:**   Manuell   
**Tester:**   Faustina Bruno   
**Datum:**   15.3.2020  
**Status:**  ERFOLGREICH  
**Vorbedingung:**  

1. MetaMask installiert
2. Zu löschender Account in ```AccountList.json``` erfasst
3. Zu löschender Account in MetaMask eingerichtet (1.
   Account Add: 0x3e7Beee9585bA4526e8a7E41715D93B2bE014B34 PK:
   FD825395E5B421CE6DDCEDBE4205FAB1F916E73E56721D5FD4D49C540BA2DB94 2. Account beliebig)
4. Parameter ```resetInterval``` in ```DefaultSettings.json``` ist auf 10 gesetzt
5. Blockchain ist aufgesetzt und läuft
6. Transaktionsmanager läuft und Account 1. ist zertifiziert

**Ablauf:**

1. MetaMask starten
2. Account 1. wählen
3. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 0
   eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Transaktionsmanager stoppen
9. In ```AccountList.json``` den Parameter ```deleteMe``` auf ```true``` setzen.
10. Transaktionsmanager starten
11. MetaMask starten
12. Account wählen
13. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
14. Beliebigen Account wählen
15. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 0
    eingeben 
16. WEITER und BESTÄTIGEN wählen 
17. Warten bis die Transaktion durchlaufen ist
18. Transaktionsmanager stoppen
19. Prüfen ob Account noch in ```AccountList.json``` vorhanden ist  

**Erwünschtes Resultat:**   

- Erste Transaktion erfolgreicher Durchlauf
- Zweite Transaktion abgebrochen
- Account ist nicht mehr in ```AccountList.json```

**Tatsächliches Resultat:** 

- Erste Transaktion ist erfolgreich durchgelaufen 
- Zweite Transaktion abgebrochen
- Account ist nicht mehr in ```AccountList.json```

### Abnahmetest 5
**AK Nr.:**   #5 & #11  
**Titel:**  Account nach Transaktionen sperren  
**Testart:**   Manuell   
**Tester:**   Faustina Bruno   
**Datum:**   15.3.2020  
**Status:**  ERFOLGREICH  
**Vorbedingung:**    

1. MetaMask installiert 
2. Account in MetaMask eingerichtet (1. Account Add:
   0x3e7Beee9585bA4526e8a7E41715D93B2bE014B34 PK:
   FD825395E5B421CE6DDCEDBE4205FAB1F916E73E56721D5FD4D49C540BA2DB94 2. Account
   beliebig ) 
3. Parameter ```resetInterval``` in ```DefaultSettings.json``` ist auf 10 gesetzt
4. Blockchain ist aufgesetzt und läuft 
5. Transaktionsmanager läuft und Account 1. ist zertifiziert
6. Account hat in ```AccountList.json``` die Transaktionslimite von 5 und Gaslimite von 126000

**Ablauf:** 

1. MetaMask starten
2. Account 1. wählen
3. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 0
   eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Schritte 2 bis 7 viermal wiederholen
9. Datei ```AccountList.json``` prüfen
10. Schritte 2 bis 7 nochmals wiederholen
11. Datei ```AccountList.json``` prüfen

**Erwünschtes Resultat:**  

- Nach 5 Transaktionen ist beim Account der Parameter ```remainingTransactions``` gleich 0
- Die letzte Transaktion wird abgebrochen
- Nach der 6. Transaktion ist beim Account der Parameter ```timeStamp``` gesetzt

**Tatsächliches Resultat:** 

- Nach 5 Transaktionen ist beim Account der Parameter ```remainingTransactions``` gleich 0
- Die letzte Transaktion wird abgebrochen
- Nach der 6. Transaktion ist beim Account der Parameter ```timeStamp``` gesetzt

### Abnahmetest 6

**AK Nr.:**   #6  & #11  & #12
**Titel:**  Account nach GasUsed sperren  
**Testart:**   Manuell   
**Tester:**   Faustina Bruno   
**Datum:**   15.3.2020  
**Status:**  ERFOLGREICH   
**Vorbedingung:**  

1. MetaMask installiert 
2. Account in MetaMask eingerichtet (1. Account Add:
   0x3e7Beee9585bA4526e8a7E41715D93B2bE014B34, 2. Account beliebig ) 
3. Parameter ```resetInterval``` in ```DefaultSettings.json``` ist auf 10 gesetzt
4. Blockchain ist aufgesetzt und läuft 
5. Transaktionsmanager läuft und Account 1. ist zertifiziert
6. Account hat in ```AccountList.json``` den Parameter ```gasLimit``` auf 42000 gesetzt und ```transactionLimit``` auf 5

**Ablauf:**

1. MetaMask starten
2. Account 1. wählen
3. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 0
   eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Schritte 2 bis 7 wiederholen
9. ```AccountList.json``` prüfen
10. Schritte 2 bis 7 wiederholen

**Erwünschtes Resultat:**   

- Der Account hat in ```AccountList.json``` einen Timestamp eingetragen
- Die letzte Transaktion wird abgebrochen
- Der Parameter ```remainingGas``` in ```AccountList.json``` ist beim Account auf 0

**Tatsächliches Resultat:** 

- Der Account hat in ```AccountList.json``` einen Timestamp eingetragen
- Die letzte Transaktion wird abgebrochen
- Der Parameter ```remainingGas``` in ```AccountList.json``` ist beim Account auf 0


### Abnahmetest 7
**AK Nr.:**   #7  & #10  
**Titel:**  Gesperrter Account entsperren  
**Testart:**   Manuell   
**Tester:**   Faustina Bruno   
**Datum:**   15.3.2020  
**Status:**  ERFOLGREICH  
**Vorbedingung:**

1. MetaMask installiert 
2. Blockchain ist aufgesetzt und läuft 
3. Account in MetaMask eingerichtet (1. Account Add:
   0x3e7Beee9585bA4526e8a7E41715D93B2bE014B34, 2. Account beliebig) 
4. Parameter ```resetInterval``` in ```DefaultSettings.json``` ist auf 10 gesetzt
5. Parameter ```revokeTime``` von Account 1. in  ```AccountList.json``` auf 2 gesetzt 
6. Parameter ```transactionLimit``` von Account 1. in  ```AccountList.json``` auf 1 gesetzt 
7. Transaktionsmanager läuft und Account 1. ist zertifiziert

**Ablauf:** 

1. MetaMask starten
2. Account 1. wählen
3. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 0
   eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Schritte 2 bis 7 zweimal wiederholen
9. 2 Minuten warten
10. Schritte 2 bis 7 wiederholen

**Erwünschtes Resultat:**    

- Dritte gratis Transaktion kann nicht durchgeführt werden
- Nach 2 Minuten kann wieder eine gratus Transaktion durchgeführt werden

**Tatsächliches Resultat:**  

- Dritte gratis Transaktion kann nicht durchgeführt werden
- Nach 2 Minuten kann wieder eine gratus Transaktion durchgeführt werden

### Abnahmetest 8
**AK Nr.:**   #7    
**Titel:**  Gesperrter Account entsperren 
**Testart:**   Manuell   
**Tester:**   Faustina Bruno   
**Datum:**   15.3.2020  
**Status:**  ERFOLGREICH  
**Vorbedingung:**  

1. MetaMask installiert 
2. Account in MetaMask eingerichtet (1. Account Add:
   0x3e7Beee9585bA4526e8a7E41715D93B2bE014B34, 2. Account beliebig)) 
3. Blockchain ist aufgesetzt und läuft 
4. Parameter ```resetInterval``` in ```DefaultSettings.json``` ist auf 10 gesetzt
5. Parameter ```revokeTime``` von Account 1. in  ```AccountList.json``` auf 2 gesetzt 
6. Parameter ```transactionLimit``` von Account 1. in  ```AccountList.json``` auf 1 gesetzt 
7. Transaktionsmanager läuft und Account 1. ist zertifiziert

**Ablauf:** 

1. MetaMask starten
2. Account 1. wählen
3. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 0
   eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Schritte 2 bis 7 zweimal wiederholen
9. Transaktionsmanager stoppen
10. 4' warten
11. Transaktionsmanager starten
12. Schritte 2 bis 7 wiederholen

**Erwünschtes Resultat:**   

- Dritte gratis Transaktion wird nicht ausgeführt
- Nach Start des Transaktionsmanagers kann der Account wieder gratis Transaktionen durchführen   

**Tatsächliches Resultat:** 

- Dritte gratis Transaktion wird nicht ausgeführt
- Nach Start des Transaktionsmanagers kann der Account wieder gratis Transaktionen durchführen  

### Abnahmetest 9
**AK Nr.:**   #7    
**Titel:**  Unterbruch mit gesperrtem Account
**Testart:**   Manuell   
**Tester:**   Faustina Bruno   
**Datum:**   15.3.2020  
**Status:**  ERFOLGREICH  
**Vorbedingung:**  

1. MetaMask installiert 
2. Account in MetaMask eingerichtet (1. Account Add:
   0x3e7Beee9585bA4526e8a7E41715D93B2bE014B34, 2. Account beliebig)) 
3. Blockchain ist aufgesetzt und läuft 
4. Parameter ```resetInterval``` in ```DefaultSettings.json``` ist auf 10 gesetzt
5. Parameter ```revokeTime``` von Account 1. in  ```AccountList.json``` auf 60 gesetzt 
6. Parameter ```transactionLimit``` von Account 1. in  ```AccountList.json``` auf 1 gesetzt 
7. Transaktionsmanager läuft und Account 1. ist zertifiziert

**Ablauf:** 

1. MetaMask starten
2. Account 1. wählen
3. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 0
   eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Schritte 2 bis 7 zweimal wiederholen
9. Transaktionsmanager stoppen
10. 4' warten
11. Transaktionsmanager starten
12. Schritte 2 bis 7 wiederholen

**Erwünschtes Resultat:**   

- Dritte gratis Transaktion wird nicht ausgeführt
- Nach Start des Transaktionsmanagers kann der Account immer noch keine gratis Transaktionen durchführen   

**Tatsächliches Resultat:** 

- Dritte gratis Transaktion wird nicht ausgeführt
- Nach Start des Transaktionsmanagers kann der Account immer noch keine gratis Transaktionen durchführen  





### Abnahmetest 10

**AK Nr.:**   #8   
**Titel:** Reset Zeitintervall setzten  
**Testart:**   Manuell   
**Tester:**   Faustina Bruno   
**Datum:**   15.3.2020  
**Status:**  ERFOLGREICH  
**Vorbedingung:**  

1. MetaMask installiert 
2. Account in MetaMask eingerichtet (1. Account Add:
   0x3e7Beee9585bA4526e8a7E41715D93B2bE014B34, 2. Account beliebig) 
3. Blockchain ist aufgesetzt und läuft 
4. Parameter ```resetInterval``` in ```DefaultSettings.json``` ist auf 2 gesetzt
5. Parameter ```transactionLimit``` von Account 1. in  ```AccountList.json``` auf 5 gesetzt 
6. Transaktionsmanager läuft und Account 1. ist zertifiziert

**Ablauf:** 

1. MetaMask starten
2. Account 1. wählen
3. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 0
   eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Parameter ```remainingTransactions``` in ```AccountList.json``` für Account 1. prüfen
9. 2' warten       
10. Parameter ```remainingTransactions``` in ```AccountList.json``` für Account 1. prüfen

**Erwünschtes Resultat:** 

- Parameter ```remainingTransactions``` in ```AccountList.json``` ist für Account 1. auf 4 gesetzt 
- Parameter ```remainingTransactions``` in ```AccountList.json``` ist für Account 1. wieder auf 5 gesetzt

**Tatsächliches Resultat:** 

- Parameter ```remainingTransactions``` in ```AccountList.json``` ist für Account 1. auf 4 gesetzt 
- Parameter ```remainingTransactions``` in ```AccountList.json``` ist für Account 1. wieder auf 5 gesetzt

### Abnahmetest 11
**AK Nr.:**   #9    
**Titel:**  Speicherung des Reset-Intervalls\
**Testart:**   Manuell  
**Tester:**   Faustina Bruno  
**Datum:**   15.3.2020\
**Status:**  ERFOLGREICH  
**Vorbedingung:** 

1. Metamask installiert 
2. Account in MetaMask eingerichtet (1. Account Add:
   0x3e7Beee9585bA4526e8a7E41715D93B2bE014B34, 2. Account beliebig) 
3. Blockchain ist aufgesetzt und läuft 
4. Parameter ```resetInterval``` in ```DefaultSettings.json``` ist auf 15 gesetzt
5. Account 1. ist in ```AccountList.json``` mit ```transactionLimit``` 5 erfasst

**Ablauf:** 

1. Transaktionsmanager starten
2. 1 Minute warten
3. Parameter ```timestampLastReset``` in ```DefaultSettings.json``` prüfen und notieren
4. MetaMask starten
5. Account 1. wählen
6. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
7. Beliebigen Account wählen
8. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 0
   eingeben 
9. WEITER und BESTÄTIGEN wählen 
10. Warten bis die Transaktion durchlaufen ist
11. Prüfen von ```remainingTransactions``` in ```AccountList.json``` für Account 1.
12. Transaktionsmanager stoppen
13. 2 Minuten warten
14. Transaktionsmanger starten
15. 1 Minute warten
16. Prüfen ob Parameter ```timestampLastReset``` in ```DefaultSettings.json``` identisch mit Schritt 3 ist
17. Prüfen von ```remainingTransactions``` in ```AccountList.json``` für Account 1.

**Erwünschtes Resultat:**  

-  ```remainingTransactions``` in ```AccountList.json``` für Account 1. ist bei 4
-  Parameter ```timestampLastReset``` in ```DefaultSettings.json``` ist identisch
- ```remainingTransactions``` in ```AccountList.json``` für Account 1. ist nach Programmstopp bei 4

**Tatsächliches Resultat:** 

- Alle Counter sind wieder auf die max. Limite zurückgesetzt 
- Intervall wird trotz der Pause zum richtigen Zeitpunkt neu gestartet

### Abnahmetest 12

**AK Nr.:**   #10     
**Titel:** Sperrzeit  
**Testart:**   Manuell   
**Tester:**   Faustina Bruno   
**Datum:**   15.3.2020  
**Status:**  ERFOLGREICH  
**Vorbedingung:**

1. MetaMask installiert 
2. Account in MetaMask eingerichtet (1. Account Add:
   0x3e7Beee9585bA4526e8a7E41715D93B2bE014B34, 2. Account beliebig)
3. Blockchain ist aufgesetzt und läuft 
4. Transaktionsmanager läuft und Account 1. ist zertifiziert
5. Account hat keine Revoke zeit eingestellt
6. In den Default Settings ist die Default Revoke Time auf 2 min und der
   resetIntervall auf 5 min gesetzt

**Ablauf:** 

1. MetaMask starten
2. Account wählen
3. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 0
   eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Dies so oft durchführen, bis der Account gesperrt ist.
9. Dannach 2' warten
10. Erneut eine gratis Transaktion durchführen       

**Erwünschtes Resultat:**   

- Account ist nach der Default Revoke Zeit wieder entsperrt     


**Tatsächliches Resultat:**  

- Account ist nach der Default Revoke Zeit wieder entsperrt 

### Abnahmetest 13

**AK Nr.:**   #13   
**Titel:**  Default Werte für Limiten A   
**Testart:**   Manuell   
**Tester:**   Faustina Bruno   
**Datum:**   15.3.2020 **Status:**  ERFOLGREICH **Vorbedingung:** 

1. MetaMask installiert 
2. Account ist ohne Transaktionslimite in JSON Datei eingetragen & Default
   Transaktionslimite ist auf 3 gesetzt
3. Account in MetaMask eingerichtet (1. Account Add:
   0x3e7Beee9585bA4526e8a7E41715D93B2bE014B34, 2. Account beliebig)
4. Blockchain ist aufgesetzt und läuft 
5. Transaktionsmanager läuft und Account 1. ist zertifiziert 

**Ablauf:** 

1. MetaMask starten
2. Account wählen
3. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 0
   eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Dies 4 Mal durchführen 

**Erwünschtes Resultat:**   

- Die letzte Transaktion wird abgebrochen
- Der Account hat in der JSON Datei einen Timestamp eingetragen
- Der Account hat in der JSON Datei keine übrigen Transaktionen 
- Limite wird nicht in Datei geschrieben

**Tatsächliches Resultat:** 

- Die letzte Transaktion wird abgebrochen
- Der Account hat in der JSON Datei einen Timestamp eingetragen
- Der Account hat in der JSON Datei keine übrigen Transaktionen 


### Abnahmetest 14

**AK Nr.:**   #13     
**Titel:**  Default Werte für Limiten  
**Testart:**   Manuell   
**Tester:**   Faustina Bruno   
**Datum:**   15.3.2020 **Status:**  ERFOLGREICH  
**Vorbedingung:** 

1. MetaMask installiert 
2. Account ist ohne Gaslimite in JSON Datei eingetragen & Default Gaslimite ist
   auf 63000 gesetzt
3. Account in MetaMask eingerichtet (1. Account Add:
   0x3e7Beee9585bA4526e8a7E41715D93B2bE014B34, 2. Account beliebig)
4. Blockchain ist aufgesetzt und läuft 
5. Transaktionsmanager läuft und Account 1. ist zertifiziert 

**Ablauf:** 

1. MetaMask starten
2. Account wählen
3. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 0
   eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Dies 4 Mal durchführen       

**Erwünschtes Resultat:**   

- Die letzte Transaktion wird abgebrochen
- Der Account hat in der JSON Datei einen Timestamp eingetragen
- Der Account hat in der JSON Datei kein übriges Gas
- Limite wird nicht in Datei geschrieben

**Tatsächliches Resultat:** 

- Die letzte Transaktion wird abgebrochen
- Der Account hat in der JSON Datei einen Timestamp eingetragen
- Der Account hat in der JSON Datei kein übriges Gas
- Limite wird nicht in Datei geschrieben

### Abnahmetest 15

**AK Nr.:**   #15    
**Titel:**  Transaktions Manager Account kann nicht gesperrt werden **Testart:**
Manuell   
**Tester:**   Faustina Bruno   
**Datum:**   15.3.2020 **Status:**  ERFOLGREICH **Vorbedingung:** 

1. Metamask installiert 
2. Account hat die Transaktionslimite 3
3. Account in MetaMask eingerichtet (1. Account Add:
   0x3e7Beee9585bA4526e8a7E41715D93B2bE014B34, 2. Account beliebig)
4. Blockchain ist aufgesetzt und läuft 
5. Transaktionsmanager läuft und Account 1. ist zertifiziert 

**Ablauf:** 

1. MetaMask starten
2. Account wählen
3. Auf SENDEN und anschliessend auf ZWISCHEN MEINEN KONTAKTEN TRANSFERIEN drücken
4. Beliebigen Account wählen
5. In das Feld "Betrag" 100 ETH eingeben und in das Feld "Transaktionsgebühr" 0
   eingeben 
6. WEITER und BESTÄTIGEN wählen 
7. Warten bis die Transaktion durchlaufen ist
8. Dies 5 Mal durchführen 

**Erwünschtes Resultat:**   

- Account wird nicht gesperrt und kann weiterhin Transaktionen durchführen 

**Tatsächliches Resultat:**  

- Account wird nicht gesperrt und kann weiterhin Transaktionen durchführen 
\newpage

