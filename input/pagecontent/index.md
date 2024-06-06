>## NB! 
>
>This is a development build and should be considered as “work in progress”. The content changes on a daily basis. This is not an official product release yet.>

This implementation guide describes the medication scheme maintained by Health and Welfare Information Systems Centre. Main content is provided in English, more detailed specifications and names of local value sets and code systems may occasionally be available only in Estonian.

Käesolev juhis kirjeldab ravimiskeemi, mida haldab Tervise ja Heaolu Infosüsteemide Keskus. Juhis on kirjutatud eesti ja inglise keeles, kusjuures eestikeelne tekst on kohati põhjalikum ja detailsem, olles suunatud kohalikule arendajale.

## About | Juhendist


  <table border="0">
  <tr><td><b>In English</b></td><td><b>Eesti keeles</b></td></tr>
  <tr>
  <td>
<p>Medication scheme is part of practitioner's new software (TJT) where he/she can easily get an accurate and up-to-date overview of patient's medication. Practitioner can add or remove medications and issue prescriptions. Currently patient may have several duplicating prescriptions and it is difficult for a healthcare proffessional to have a proper overview of patient's medication. .</p>
<hr>
<p>Implementation Guide contains:</p>
<ul>
  <li>Profiles, extensions, value sets and code systems used for medication scheme</li>
  <li>Guidance how to implement medication scheme</li>
  <li>Operations descriptions</li>
  <li>Logical models</li>
  <li>Usage guidance, including basic querying</li>
</ul>
<p></p>
</td>
<td>
<p>Ravimiskeem on osa tervishoiutöötajate uuest tarkvarast Tervise juhtimise töölaud (TJT), kus tervishoiutöötaja saab ajakohase ülevaate patsiendi ravimitest. Seal saab lisada või eemaldada ravimiskeemi ridu ning retsepte väljakirjutada. Praegusel hetkel võib patisendil olla mitmeid duplitseerivaid ning mitte-ajakohaseid retsepte, mis teevad ravimitest korraliku ülevaate saamise keeruliseks. </p>
<hr>
<p>Juhend sisaldab:</p>
<ul>
  <li>Ravimiskeemi jaoks kasutatavad profiilid, laiendid, loendid ja koodiloendid</li>
  <li>Juhised ravimiskeemi juurutamiseks</li>
  <li>Operatsioonide kirjeldused</li>
  <li>Loogilised mudelid</li>
  <li>Kasutusjuhised, sh peamised päringud</li>
</ul>
</td>
</tr></table>

### In scope:

-	MedicationStatement
-	MedicationRequest
-	MedicationDispensation
-   ClinicalUseDefinition
-   List
-   Task

### Out of scope:

-	MedicationAdministration (will be part of hospital medication IG in near future)
-	Coverage – reinbursement of patient’s medication is arranged from Estonian Health Insurance Fund side and not relevant in practitioner’s software view.

## Background

First phase of development is tightly connected with Estonian Medical Prescription Center so Medication Overview is a copy of legacy prescribing system gradually moving towards new generation health data exchange.

## TJT

TJT – Tervisejuhtimise töölaud - is a new software currently under developement for healthcare proffessionals. TJT is going to be developed module by module Medication Overview being the first module. TJT is a central tool aiming to bring health care proffessionald in common space in order to add, display and exchange health data with each other.


## References

This IG was initially a Simplifier project: https://simplifier.net/ee-tis 
