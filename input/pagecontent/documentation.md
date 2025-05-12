# Dokumentatsioon

## Ressursside äriline kasutus
Alltoodud skeem illustreerib tehniliste ressursside ärilist kasutust:

Andmete lisamine, muutmine ja eemaldamine on kõik läbi [Ravimiskeemi andmete kinnitamine](MedicationStatement-confirm) operatsiooni. All on lühidalt kirjeldatud andemete tekkimise järjekorda:

Patsiendi ravimiskeemi lisatakse ravimiskeemi rida, tekivad ressursid MedicationStatement ja sellega seotud Medication A
ühtlasi lisatakse taustal Retseptikeskusesse retseptid ning salvestatakse nende numbrid MedicationStatement juurde
Patsiendi ravimiskeemi pärimisel leitakse FHIR andmetest MedicationStatement ja sellega seotud Medication A
täiendavalt päritakse retseptikeskusest numbrite alusel retseptid ning konverteeritakse need MedicationRequest ressurssideks, mis on samuti seotud eelnevalt MedicationStatement'ga seotud Medication A-ga. 
juhul kui retsepte on väljastatud, tekib iga retsepti väljastamisel MedicationDispense - siin on aga eripäraks iga väljastusega eraldi kaasa tulev Medication ressurss (joonisel nt MedicationDispense 1 ja Medication B). 
Põhjus seisneb selles, et Patsiendile väljastatava ravimi osas langetab lõpliku otsuse kohapeal olev apteeker.
Andmete muutmisel tekivad FHIR ressurssidest uued versioonid
Ravimiskeemis andmete kustutamist kui sellist ei eksisteeri, on vaid ravimiskeemi ridade aktiivsest vaatest eemaldamine ehk nendele effective.end kuupäeva määramine kinnitamisel, mis välistab need [Kinnitatud ravimiskeemi pärimine](MedicationStatement-confirmed-medication-scheme) operatsiooni väljundist.  

## Ravimiskeemi kinnitamise andmestik
1. Ravimiskeemi kinnitamisel tekkiv andmestik on järgmine

    a. Ravimiskeemi kinnitamise fakt ehk List [EETISMedicationList]
sisaldab nn contained ressursina ravimiskeemi kinnitanud kasutaja infot
    b. kogu kinnitaja info on PractitionerRole ressursis [EETISPractitionerRole], mille sisu asub List.contained atribuudis ja sellele viitab atribuut List.source
    c. Selgitus: kuna PractitionerRole siin asub contained atribuudi sees, ei ole tegemist eraldiseisva, salvestatud ja päritava ressursiga ning see on joonisel eristatud
2. Ravimiskeemi kinnitatud nimekiri koos infoga selle kohta, mida selle kinnitamise käigus mingi ravimiskeemi reaga tehti:
    a. List.entry kollektsioonis on kirjete või nn "Entry"-dena ravimiskeemi rea viited
    b. iga Entry juures on ka ära toodud Entry.flag, mille atribuut ütleb, mida kinnitamise käigus selle konkreetse ravimiskeemi reaga tehti:
        i. prescribed - uued Ravimiskeemi read, mis lisati selle kinnitamisega esmakordselt ravimiskeemi
        ii. unchanged - muutmata ravimiskeemi read, ehk ravimiskeemi read, mis eelmisest kinnitamisest muutmata kujul alles jäid
        iii. ceased - Eemaldatud või peatatud ravimiskeemi read ehk ravimiskeemi read, mis selle kinnitamisega peatati
        iv. changed - Muudetud ravimiskeemi read, ehk ravimiskeemi read, mis selle kinnitamisega muudeti või pikendati
    c. Entry.item sisaldab viidet konkreetsele ravimiskeemi reale
    d. Selgitus: kuna Entry ise ei ole eraldiseisev ressurss vaid kollektsioon List ressursi all, on ta joonisel eristatud
3. Ühe Ravimiskeemi rea kinnitamiste ja kinnitaja andmestik
    a. Igal andmeid tekitaval või muutval kinnitamisel tekib MedicationStatment.extension kollektsiooni juurde üks [EETISVerification] kirje, kus on kirjas kinnitamise aeg ja MEDRE koodi näol viide kinnitajale (Identifier)
    b. Ravimiskeemi (esialgse?) rea kinnitaja andmed lähevad PractitionerRole ressurssi [EETISPractitionerRole], mille sisu asub MedicationStatement.contained atribuudis ja sellele viitab atribuut MedicationStatement.informationSource
    c. Selgitus: kuna PractitionerRole siin asub contained atribuudi sees, ei ole tegemist eraldiseisva, salvestatud ja päritava ressursiga ning see on joonisel eristatud