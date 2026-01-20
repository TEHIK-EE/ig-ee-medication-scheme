# MedIN Andmemudel
{% include fsh-link-references.md %}

## Andmeobjektide kirjeldused
Ravimiskeemi infomudelid ja nende FHIR vasted: Infomudelid vs FHIR
Ravimiskeemi FHIR ressurside ülevaade (IG link): https://build.fhir.org/ig/TEHIK-EE/ig-ee-medication-scheme/artifacts.html 

## Ressursside äriline kasutus
Järgnevalt on kirjeldatud FHIR ressursside kasutust MedIN teenuse väljundis. Loetavuse huvides on andmestik kirjeldatud kahes erinevas jaos. 

### Kinnitatud ravimiskeemi andmestik
Alltoodud skeem illustreerib tehniliste ressursside ärilist kasutust Kinnitatud ravimiskeemi pärimisel:

<div>
<img src="ravimiskeemifhirressursid.svg"  alt="Ravimiskeemi FHIR ressursid" width="95%">
<p>Skeem 1. Ravimiskeemi FHIR ressursid</p>
<p></p>
</div>

Andmete lisamine, muutmine ja eemaldamine on kõik läbi [Ravimiskeemi andmete kinnitamine](OperationDefinition-MedicationStatement-confirm.html) operatsiooni. All on lühidalt kirjeldatud andemete tekkimise järjekorda:

1. Patsiendi ravimiskeemi lisatakse ravimiskeemi rida, tekivad ressursid MedicationStatement ja sellega seotud Medication A
    - ühtlasi lisatakse taustal Retseptikeskusesse retseptid ning salvestatakse nende numbrid MedicationStatement juurde
2. Patsiendi ravimiskeemi pärimisel leitakse FHIR andmetest MedicationStatement ja sellega seotud Medication A
    - täiendavalt päritakse retseptikeskusest numbrite alusel retseptid ning konverteeritakse need MedicationRequest ressurssideks, mis on samuti seotud eelnevalt MedicationStatement'ga seotud Medication A-ga. 
    - juhul kui retsepte on väljastatud, tekib iga retsepti väljastamisel MedicationDispense - siin on aga eripäraks iga väljastusega eraldi kaasa tulev Medication ressurss (joonisel nt MedicationDispenseA1 ja Medication A1). Põhjus seisneb selles, et Patsiendile väljastatava ravimi osas langetab lõpliku otsuse kohapeal olev apteeker.
    - Täiendavalt päritakse retseptikeskusest andmed retseptide kohta, mis on loodud Ravimiskeemi väliselt, need läbivad Grupeerimise loogika ravimiskeemis ning kattuvuste puhul seotakse ravimiskeemi reaga läbi eraldi extension-i ( ExtensionEETISGroupedItems )
3. Andmete muutmisel tekivad FHIR ressurssidest uued versioonid
4. Ravimiskeemis andmete kustutamist kui sellist ei eksisteeri, on vaid ravimiskeemi ridade aktiivsest vaatest eemaldamine ehk nendele MedicationStatement.effective.end kuupäeva määramine kinnitamisel, mis välistab need Kinnitatud ravimiskeemi pärimine operatsiooni väljundist.   

### Ravimiskeemi kinnitamise andmestik

<div>
<img src="ravimiskeemikinnitamine.svg"  alt="Ravimiskeemi kinnitamise andmestik" width="95%">
<p>Skeem 2. Ravimiskeemi kinnitamise andmestik</p>
<p></p>
</div>

1. Ravimiskeemi kinnitamisel tekkiv andmestik on järgmine
    * Ravimiskeemi kinnitamise fakt ehk List [EETISMedicationList] sisaldab nn contained ressursina ravimiskeemi kinnitanud kasutaja infot
    * kogu kinnitaja info on PractitionerRole ressursis [EETISPractitionerRole], mille sisu asub List.contained atribuudis ja sellele viitab atribuut List.source
    * Selgitus: kuna PractitionerRole siin asub contained atribuudi sees, ei ole tegemist eraldiseisva, salvestatud ja päritava ressursiga ning see on joonisel eristatud
2. Ravimiskeemi kinnitatud nimekiri koos infoga selle kohta, mida selle kinnitamise käigus mingi ravimiskeemi reaga tehti:
    * List.entry kollektsioonis on kirjete või nn "Entry"-dena ravimiskeemi rea viited
    * iga Entry juures on ka ära toodud Entry.flag, mille atribuut ütleb, mida kinnitamise käigus selle konkreetse ravimiskeemi reaga tehti:
       * prescribed - uued Ravimiskeemi read, mis lisati selle kinnitamisega esmakordselt ravimiskeemi
       * unchanged - muutmata ravimiskeemi read, ehk ravimiskeemi read, mis eelmisest kinnitamisest muutmata kujul alles jäid
       * ceased - Eemaldatud või peatatud ravimiskeemi read ehk ravimiskeemi read, mis selle kinnitamisega peatati
       * changed - Muudetud ravimiskeemi read, ehk ravimiskeemi read, mis selle kinnitamisega muudeti või pikendati
       * consolidated - Kinnitamisel leitud ravimiskeemi read, mis on kokku grupeeritud käesolevaga ning kinnitamisel automaatselt konsolideeriti.
       * generated - kinnitatud ravimiskeemi pärimisel leiti FHIR andmetest hilisemad Retseptikeskuse andmed ning nendega kirjutati väljundis FHIR andmed üle ehk saadud seis on nn "genereeritud"
        - NB! seda väärtust saab ainult Kinnitatud ravimiskeemi pärimine väljundis näha
        - kinnitatud ravimiskeemi pärimisel rakendatakse Grupeerimise loogika ravimiskeemis ning teatud olukordades on vajalik FHIR ressurssidesse peegeldada Retseptikeskuse andmeid 
    * Entry.item sisaldab viidet konkreetsele ravimiskeemi reale
    * Selgitus: kuna Entry ise ei ole eraldiseisev ressurss vaid kollektsioon List ressursi all, on ta joonisel eristatud
3. Ühe Ravimiskeemi rea kinnitamiste ja kinnitaja andmestik
    * Igal andmeid tekitaval või muutval kinnitamisel tekib MedicationStatment.extension kollektsiooni juurde üks [EETISVerification] kirje, kus on kirjas kinnitamise aeg ja MEDRE koodi näol viide kinnitajale (Identifier)
    * Ravimiskeemi rea viimase kinnitaja andmed lähevad PractitionerRole ressurssi [EETISPractitionerRole], mille sisu asub MedicationStatement.contained atribuudis ja sellele viitab atribuut MedicationStatement.informationSource
    * Selgitus: kuna PractitionerRole siin asub contained atribuudi sees, ei ole tegemist eraldiseisva, salvestatud ja päritava ressursiga ning see on joonisel eristatud