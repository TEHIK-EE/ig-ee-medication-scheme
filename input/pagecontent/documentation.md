# Dokumentatsioon
{% include fsh-link-references.md %}
## Ressursside äriline kasutus
Alltoodud skeem illustreerib tehniliste ressursside ärilist kasutust:
<div>
<img src="ravimiskeemifhirressursid.svg"  alt="Ravimiskeemi FHIR ressursid" width="95%">
<p>Skeem 1. Ravimiskeemi FHIR ressursid</p>
<p></p>
</div>

Andmete lisamine, muutmine ja eemaldamine on kõik läbi [Ravimiskeemi andmete kinnitamine](OperationDefinition-MedicationStatement-confirm.html) operatsiooni. All on lühidalt kirjeldatud andemete tekkimise järjekorda:

* Patsiendi ravimiskeemi lisatakse ravimiskeemi rida, tekivad ressursid MedicationStatement ja sellega seotud Medication A 
    * ühtlasi lisatakse taustal Retseptikeskusesse retseptid ning salvestatakse nende numbrid MedicationStatement juurde
* Patsiendi ravimiskeemi pärimisel leitakse FHIR andmetest MedicationStatement ja sellega seotud Medication A
    * täiendavalt päritakse retseptikeskusest numbrite alusel retseptid ning konverteeritakse need MedicationRequest ressurssideks, mis on samuti seotud eelnevalt MedicationStatement'ga seotud Medication A-ga. 
    * juhul kui retsepte on väljastatud, tekib iga retsepti väljastamisel MedicationDispense - siin on aga eripäraks iga väljastusega eraldi kaasa tulev Medication ressurss (joonisel nt MedicationDispense 1 ja Medication B). Põhjus seisneb selles, et Patsiendile väljastatava ravimi osas langetab lõpliku otsuse kohapeal olev apteeker.
* Andmete muutmisel tekivad FHIR ressurssidest uued versioonid
* Ravimiskeemis andmete kustutamist kui sellist ei eksisteeri, on vaid ravimiskeemi ridade aktiivsest vaatest eemaldamine ehk nendele effective.end kuupäeva määramine kinnitamisel, mis välistab need [Kinnitatud ravimiskeemi pärimine](OperationDefinition-MedicationStatement-confirmed-medication-scheme.html) operatsiooni väljundist.

## Ravimiskeemi kinnitamise andmestik

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
    * Entry.item sisaldab viidet konkreetsele ravimiskeemi reale
    * Selgitus: kuna Entry ise ei ole eraldiseisev ressurss vaid kollektsioon List ressursi all, on ta joonisel eristatud
3. Ühe Ravimiskeemi rea kinnitamiste ja kinnitaja andmestik
    * Igal andmeid tekitaval või muutval kinnitamisel tekib MedicationStatment.extension kollektsiooni juurde üks [EETISVerification] kirje, kus on kirjas kinnitamise aeg ja MEDRE koodi näol viide kinnitajale (Identifier)
    * Ravimiskeemi (esialgse?) rea kinnitaja andmed lähevad PractitionerRole ressurssi [EETISPractitionerRole], mille sisu asub MedicationStatement.contained atribuudis ja sellele viitab atribuut MedicationStatement.informationSource
    * Selgitus: kuna PractitionerRole siin asub contained atribuudi sees, ei ole tegemist eraldiseisva, salvestatud ja päritava ressursiga ning see on joonisel eristatud