---
title: "IP6: Blockchain Transactionmanager"
subtitle: "Projektvereinbarung"
author: "Faustina Bruno & Jurij Maïkoff"
date: "2019-10-01"
subject: "Machine Learning"
lang: "de"

bibliography: "biblio.bib"

titlepage: true
titlepage-color: "06386e"
titlepage-text-color: "FFFFFF"
titlepage-rule-color: "FFFFFF"
titlepage-rule-height: 1
...
\newpage

|   |   |   
|:--------|:---------|
|**Betreuer:** |          Markus Knecht|
|              |         Daniel Kröni |                   
|**Auftraggeber:**|       Markus Knecht|
|                 |      Daniel Kröni|
|**Projektende:**  |      20.03.2020|

# Aufgabenstellung

Blockchains verfügen über verschiedene Mechanismen um sich gegen Attacken abzusichern. Eine davon ist eine Gebühr auf jeder Transaktion, die sogenannte Gas Fee. Dadruch können Denail of Service (DoS) Attacken, bei denen das Netzwerk mit unzähligen Transaktionen geflutet wird, effizient bekämpft werden. Dem Angreifer kann die Attacke nit aufrecht erhalten, da ihm die finanziellen Mittel ausgehen. 

Obwohl dieser Schutzmechanismus auf einer öffentlichen Blockchain sehr effizient und elegant ist, eignet er sich nicht für eine Lernumgebung. Hier sollen Anwender die Möglichkeit haben, Transaktionen ohne anfallende Gebühren ausführen zu können. Dadurch wird die Blockchain anfällig für DoS Attacken. 

Die Projektaufgabe besteht darin, eine Lösung zu finden, bei der die Sicherheit der Blockchain auch ohne eine Transaktionsgebühr gewährleistet werden kann. 

## Ziele

Das Ziel der Arbeit ist es zuerst eine Konzeptionelle Erarbeitung eines Testnetzwerkes welches:

- nicht permanent ist (Reboot möglich)
- kostenlose Transaktionen ermöglicht 
- Anonymität gewährleistet
- Sicherheit gewährleistet

und in einem zweiten Schritt die Umsetzung/Realisierung dieses Netzwerkes. 

Um diese Ziele zu erriechen sind folgende Fragestellungen von Bedeutung:

- Der Zustand in der Blockchain soll synchornisiert werden können ohne von einem Teilnehmer manipulliert zu werden
- wie kann die Gebühr einer Transaktion auf null gesetzt werden und gewährleistet werden, dass nicht zu viele Transaktionen (zB Attacken) getätigt werden
- Supportet Uport unsere gewünschten Anfroderungen einer SmartWallet oder müssen wir selber eine SmartWallet programmieren
- Wie kann man Attacken vermeiden (zB algorithmisch: nur eine Anzahl Transaktionen pro Monat möglich)

## Risiken

|  Risiko | Auftreten  | Impact  | Risk level  |  Gegenmassnahme |
|:--------------------|------|-----|-----|:--------------------------------------|
| Teammitglied bricht Projekt ab  |  1 | 3  |  3 | Gute Kommunikation unter den Teammitgliedern   |
| Unterschätzen des Projektumfanges  | 2  | 2  |  4 | Sorgfältige Planung und regelmässig Rücksprache mit den Betreuern  |
| Ausfall von einem Teammitglied (mehr als 2 Wochen)  | 2  | 2  |  4 | Sofortiges Informieren von Betreuern. Planung überarbeiten und Ausfall berücksichtigen |

