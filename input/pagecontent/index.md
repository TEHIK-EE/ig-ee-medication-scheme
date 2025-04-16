># NB! 
>
>**This is a development build and should be considered as “work in progress”. The content changes on a daily basis. This is not an official product release yet.**
>
>**Juhendit täiendatakse igapäevaselt. Kõik liidestumiseks vajalik materjal pole veel juhendisse lisatud, tegu on MUSTANDIGA!**
>


This implementation guide describes the medication scheme maintained by Health and Welfare Information Systems Centre. Main content is provided in English, more detailed specifications and names of local value sets and code systems may occasionally be available only in Estonian.

Käesolev juhis kirjeldab ravimiskeemi, mida haldab Tervise ja Heaolu Infosüsteemide Keskus. Juhis on kirjutatud eesti ja inglise keeles, kusjuures eestikeelne tekst on kohati põhjalikum ja detailsem, olles suunatud kohalikule arendajale.

## About | Juhendist


  <table border="0">
  <tr><td><b>In English</b></td><td><b>Eesti keeles</b></td></tr>
  <tr>
  <td>
<p>The digital Medication Scheme offers both doctors and patients a comprehensive and up-to-date overview of the medications a patient is taking. The entire management of a patient's medication scheme is consolidated under the one service. In the future, important over-the-counter medications and dietary supplements can be included in the Medication Scheme. </p>
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
<p>Ravimiskeem pakub nii arstidele kui ka patsientidele terviklikku ja ajakohast ülevaadet patsiendi poolt tarvitatavatest ravimitest. Kogu patsiendi ravimiskeemi korraldus koondub Ravimiskeemi teenuse alla. Tulevikus saab ravimiskeemi lisada olulisi käsimüügiravimeid ja ka toidulisandeid.  </p>
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

## Healthcare Specialist Portal | Tervisejuhtimise töölaud TJT


  <table border="0">
  <tr><td><b>In English</b></td><td><b>Eesti keeles</b></td></tr>
  <tr>
  <td>
<p>Tervisejuhtimise töölaud (Healthcare Specialist Portal) is a web-based tool designed for healthcare professionals and other specialists involved in patient care. It consolidates various e-services that support patient treatment. The tool provides a quick overview of an individual’s health data, allows for data updates, and facilitates collaboration among healthcare providers to create a comprehensive health plan for the person. All new generation health data system's e-services will be made available through the portal.

Specialists can access relevant information legally available to them. This includes a unified medication history, essential health details, and the patient’s medical background. Additionally, the dashboard provides condition-specific views and references to private-sector digital solutions.

Each specialist can tailor a personal dashboard to display the most relevant information for their work. This personalization ensures that critical data is readily accessible.

Patients wishing to access the same information can use [Health Portal](https://www.terviseportaal.ee/en/).

The Healthcare Specialist Portal was developed through collaboration between Tervisekassa, TEHIK, and analysis and development partners from Industry62, Net Group, and Nortal. It represents the next generation of health information system services. .</p>
<hr>
<p>Healthcare Specialist Portal:</p>
<ul>
  <li>Is intented for use by healthcare professionals and other specialists involved in providing healthcare services</li>
  <li>Serves as the initial access point for next-generation health information system services</li>
  <li>Ensures that refined services are available to be seamlessly integrated into healthcare institutions' information systems.</li>
</ul>
<p></p>
</td>
<td>
<p>Tervisejuhtimise töölaud on veebipõhine tööriist kõigile tervishoiutöötajatele ja teistele raviprotsessi toetavatele spetsialistidele, mis koondab kokku erinevad patsiendikäsitlust toetavad e-teenused. Lahendus annab kiirelt ülevaate inimese terviseandmetest, võimaldab neid omakorda täiendada ning koostöös teiste tervishoiutöötajatega juhtide inimese terviseplaani. Töölaua kaudu saavad kättesaadavaks kõik uue põlvkonna terviseinfosüsteemi teenused.

Töölaual näeb iga spetsialist kogu infot, milleks tal juriidiliselt õigus on, alates ühtsest ravimiskeemist, elulisest teabest ja terviseajaloost, lõpetades seisundipõhiste vaadete ja viidetega erasektori digilahendustele.

Spetsialistidel on võimalik töölaua avakuva kohandada selliselt, et sealt tuleks välja just temale kõige olulisem info. Inimene ise aga pääseb samale infole ligi [Terviseportaali](https://www.terviseportaal.ee/) kaudu. </p>
<hr>
<p>Tervisejuhtimise töölaud:</p>
<ul>
  <li>On kasutamiseks tervishoiutöötajatele ja teistele spetsialistidele, kes tervishoiuteenuste pakkumisel osalevad</li>
  <li>On eelkõige koostööplatvorm, mis võimaldab oma tööd senisest kiiremini, mugavamalt, efektiivsemalt ja patsiendikesksemalt teha.</li>
  <li>Töölaud on esimene ligipääsupunkt uue põlvkonna terviseinfosüsteemi teenustele ning töölaua abil tagame ka raviasutuste infosüsteemidele juurutamiseks lihvitud teenused.</li>
</ul>
</td>
</tr></table>



## Terminology

Code systems and value sets in this IG are examples. You will find the most up-to-date versions of them in TEHIK terminology server. Always query the terminology from there. [FHIR terminology services](https://build.fhir.org/ig/TEHIK-EE/TerminologyServices/) maintained by Health and Welfare Information Systems Centre IG contains more detailed information.

## References

This IG was initially a Simplifier project: https://simplifier.net/ee-tis 
