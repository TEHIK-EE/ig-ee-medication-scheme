# Kasutuslood
{% include fsh-link-references.md %}

Tehniliselt ei ole Ravimiskeemi teenus oma ülesehituselt märkimisväärselt keerukas, kuid teenuste kasutus on erinevates ärilistes stsenaariumites mõnevõrra erinev. 
Teenuste tehniline kirjeldus on toodud MedIN API kirjeldus alamlehtedel, järgnevalt on aga ära toodud teenuste kasutamine erinevates ärilistes stsenaariumites.

Näidetena on toodud järgmised kasutuslood:
* Patsiendi ravimiskeemi pärimine
* Ravimiskeemi ravimi lisamine
* Ravimiskeemi ravimi eemaldamine
* Ravimiskeemi ravimi muutmine
* Ravimiskeemi ravimi pikendamine  
* Patsiendi ravimiskeemi ajaloo pärimine
NB! Näitlikustamiseks on iga tegevus eraldiseisvalt tehtud ning selle järel ravimiskeem kinnitatud, reaalses elus on aga ette nähtud, et kõik ühe Patsiendi ravimiskeemi muudatused, mis ühe lõppkasutaja poolt tehakse, jäetakse klientsüsteemi poolel meelde ning <u>kinnitatakse ühe korraga - et oleks kõik muudatused ühes kinnitamise päringus.<u>

Kasutuslugudes on eeldatud, et teenuse kasutamiseks autentimine on juba sooritatud [autoriseerimiseteenuse kaudu](https://teabekeskus.tehik.ee/et/teenused/tis-teenused/tis-andmevahetus/autoriseerimise-teenus), ning patsiendi viide on päritud [MPI - Patsiend üldandmete teenus](https://github.tehik.ee/ig-ee-mpi/index.html) päringutega. 

### Patsiendi ravimiskeemi pärimine
<div>
<img src="patsiendiravimiskeemiparimine.svg"  alt="patsiendiravimiskeemiparimine" width="50%">
<p>Joonis 1. Patsiendi ravimiskeemi pärimine</p>
<p></p>
</div>

1. Klientsüsteem teeb MPI viite alusel päringu Kinnitatud ravimiskeemi pärimine 
2. MedIN tagastab FHIR Bundle, kus on sees ravimiskeemi andmestik ([vt MedIN Andmemudel](documentation.html)) 
    * Retseptikeskusest leitakse ka kõik patsiendi kehtivad müümata ja välja müüdud retspetid alates viimasest ravimiskeemi kinnitamisest või viimased 180 päeva
    * FHIR Bundle tagastab muuhulgas List ressursi, mis sisaldab ravimiskeemi viimase muudatuse aega - olgu siis MedIN või Retseptikeskuse poolelt - see andmestik on vajalik nn "tõendusena"  ravimiskeemi andmete muutmisel
3. Klientsüsteem teeb MPI viite alusel päringu [Koostoimete pärimine](OperationDefinition-Interactions.html)
    * **NB!** Oluline on siin anda ette ainult patsiendi viide, et saada kehtivas ravimiskeemis esinevaid koostoimeid.
    * seda päringut saab ka kinnitatud ravimiskeemi pärimisega paralleelselt teha
4. Klientsüsteem viib kahe päringu tulemused omavahel kokku ja kuvab ravimiskeemi ja koostoimed lõppkasutajale

### Ravimiskeemi ravimi lisamine
<div>
<img src="ravimiskeemiravimilisamine.svg"  alt="Ravimiskeemi ravimi lisamine" width="50%">
<p>Joonis 2. Ravimiskeemi ravimi lisamine</p>
<p></p>
</div>

1. Klientsüsteemis on lõppkasutaja sisestanud lisatava ravimi andmestiku ja klientsüsteem teeb päringu [Koostoimete pärimine](OperationDefinition-Interactions.html)
    * **NB!** siin on oluline lisaks patsiendi viitele anda sisendisse ka lisatava ravimi andmed
    * Koostoimete pärimiseks on vajalikud minimaalselt preparaadi andmed või toimeainete-tugevuste ning ravimvormi andmed
2. MedIN tagastab FHIR Bundle ressursi, kus on sees koostoimete andmestik 
3. Klientsüsteem kuvab lõppkasutajale välja tekkivate koostoimete info
4. Lõppkasutaja on sisestanud lisatava ravimi andmed ja klientsüsteem teeb päringu [Retsepti soodustuste pärimine](OperationDefinition-Task-reimbursements.html)
5. MedIN tagastab FHIR Task ressursi, mille Task.output atribuudis on soodusmäärade andmestik
6. Klientsüsteem kuvab soodusmäärade valiku lõppkasutajale või otsustab ise, millist soodusmäära kasutada
7. Lõppkasutaja on ravimi andmetega lõpetanud ja ravimi andmed on valmis valideerimiseks, klientsüsteem teeb päringu [Ravimiskeemi ridade valideerimine](OperationDefinition-MedicationStatement-validate-custom.html)
    * Juhul kui klientsüsteemis on kasutusel ka lokaalne andmestik, on soovituslik valideerimise päring teha vahetult enne salvestamist, et lõppkasutaja saaks andmeid korrigeerida
8. MedIN tagastab FHIR OperationOutcome ressursi, mille sees on valideerimisteated koos nende tasemetega
    * **NB!** Oluline on teada, et Ravimiskeemi hilisem kinnitamine ei õnnestu, juhul kui lahendamata on jäänud mõni valideerimisteade tasemega Fatal või Error 
9. Klientsüsteem kuvab teated lõppkasutajale, kes vajadusel korrigeerib andmeid
10. Lõppkasutaja on muudatustega lõpule jõudnud ja soovib Patsiendi ravimiskeemi uuel kujul kinnitada ning retseptid luua, Klientsüsteem teeb päringu [Ravimiskeemi andmete kinnitamine](OperationDefinition-MedicationStatement-confirm.html)
    * **NB!** siin tuleb viitena anda sisse viimase muudatuse viide, milleks on Kinnitatud ravimiskeemi pärimisel saadud FHIR List ressurss - seda kasutatakse, et kontrollida, kas muudatused on tehtud kõige viimast seisu omades.
    * Päringu sisendisse tuleb anda kogu kinnitatud ravimiskeemi pärimisel saadud väljund koos muudatuste ja täiendustega - antud juhul lisatud rida ning kõik Kinnitatud ravimiskeemi pärimisel saadud read
11. MedIN valideerib andmed, kontrollib koostoimeid,  loob uued retseptid ning salvestab FHIR andmed, tagastades FHIR Bundle, mis sisaldab kogu aktuaalset patsiendi ravimiskeemi, sh viiteid loodud retseptidele
    * Valideerimisreeglid - [MedIN Andmekvaliteedi kontrollid](controls.html)
    * **NB!** Juhul kui kinnitamise käigus tekib vigu ja tagastatakse OperationOutcome, siis saadetud andmeid FHIR-i ei salvestata, küll aga tehakse Retseptikeskuses retseptide lisamist ükshaaval, mis võib tingida olukorra kus kinnitamine ebaõnnestub, kuid mingid retseptid siiski loodi. Sellisel juhul need loodud retseptid peegelduvad ka [Kinnitatud ravimiskeemi pärimine](OperationDefinition-MedicationStatement-confirmed-medication-scheme.html) päringu tulemustes. 

### Ravimiskeemi ravimi eemaldamine
*NB! Lihtsuse huvides on skeemilt ja tegevuste nimekirjast jäetud ära koostoimete pärimine*
<div>
<img src="ravimieemaldamine.svg"  alt="Ravimi eemaldamine" width="50%">
<p>Joonis 3. Ravimiskeemi rea eemaldamine </p>
<p></p>
</div>

1. Klientsüsteem teeb MPI viite alusel päringu [Kinnitatud ravimiskeemi pärimine](OperationDefinition-MedicationStatement-confirmed-medication-scheme.html) 
2. MedIN tagastab FHIR Bundle, kus on sees ravimiskeemi andmestik ([vt MedIN Andmemudel](documentation.html))
3. Lõppkasutaja valib eemaldada mingi kindla rea ravimiskeemist, lisades ka eemaldamise põhjuse, mille Klientsüsteem meelde jätab.
4. Lõppkasutaja on muudatustega lõpule jõudnud ja soovib Patsiendi ravimiskeemi uuel kujul - eemaldatud reaga - kinnitada, Klientsüsteem teeb päringu [Ravimiskeemi andmete kinnitamine](OperationDefinition-MedicationStatement-confirm.html)
    * Rea eemaldamiseks tuleb FHIR andmetesse lisada MedicationStatement.effective.end kuupäev, väärtustades selle tänase kuupäeva+kellaajaga, ning täita extension [ExtensionEETISCancelledStatusReason] 
    * **NB!** siin tuleb viitena anda sisse viimase muudatuse viide, milleks on Kinnitatud ravimiskeemi pärimisel saadud FHIR List ressurss - seda kasutatakse, et kontrollida, kas muudatused on tehtud kõige viimast seisu omades.
    * Päringu sisendisse tuleb anda kogu kinnitatud ravimiskeemi pärimisel saadud väljund koos muudatuste ja täiendustega - antud juhul eemaldatav rida muudetud kujul ning kõik ülejäänud Kinnitatud ravimiskeemi pärimisel saadud read
5. MedIN valideerib andmed, kontrollib koostoimeid,  võimalusel tühistab eemaldatava reaga seotud retseptid ning salvestab FHIR andmed, tagastades FHIR Bundle, mis sisaldab kogu aktuaalset patsiendi ravimiskeemi, sh viiteid loodud retseptidele
    * Valideerimisreeglid - [MedIN Andmekvaliteedi kontrollid](controls.html)
    * **NB!** Juhul kui kinnitamise käigus tekib vigu ja tagastatakse OperationOutcome, siis saadetud andmeid FHIR-i ei salvestata, küll aga tehakse Retseptikeskuses retseptide tühistamist ükshaaval, mis võib tingida olukorra kus kinnitamine ebaõnnestub, kuid mingid retseptid siiski annulleeritakse. Sellisel juhul peegeldub see muudatus ka [Kinnitatud ravimiskeemi pärimine](OperationDefinition-MedicationStatement-confirmed-medication-scheme.html) päringu tulemustes.

### Ravimiskeemi ravimi muutmine
*NB! Lihtsuse huvides on skeemilt ja tegevuste nimekirjast jäetud ära koostoimete pärimine*
<div>
<img src="ravimimuutmine.svg"  alt="Ravimiskeemi rea muutmine" width="50%">
<p>Joonis 4. Ravimiskeemi rea muutmine</p>
<p></p>
</div>

1. Klientsüsteem teeb MPI viite alusel päringu [Kinnitatud ravimiskeemi pärimine](OperationDefinition-MedicationStatement-confirmed-medication-scheme.html) 
2. MedIN tagastab FHIR Bundle, kus on sees ravimiskeemi andmestik ([vt MedIN Andmemudel](documentation.html))
3. Lõppkasutaja valib muuta mingit kindlat rida ravimiskeemis, Klientsüsteem kuvab lõppkasutajale muutmise vormi, kus kasutaja saab andmeid muuta.
    * **NB!** Keelatud on muuta ravimiskeemi rea puhul toimeaineid ja nende järjekorda/preparaadi andmeid, ATC koodi ning ravimvormi
4. Lõppkasutaja on sisestanud muudetava ravimi andmed ja klientsüsteem teeb päringu [Retsepti soodustuste pärimine](OperationDefinition-Task-reimbursements.html)
5. MedIN tagastab FHIR Task ressursis, mille Task.output atribuudis on soodusmäärade andmestik
6. Klientsüsteem kuvab soodusmäärade valiku lõppkasutajale või otsustab ise, millist soodusmäära kasutada
7. Lõppkasutaja on ravimi andmetega lõpetanud ja ravimi andmed on valmis valideerimiseks, klientsüsteemi teeb päringu [Ravimiskeemi ridade valideerimine](OperationDefinition-MedicationStatement-validate-custom.html)
    * Juhul kui klientsüsteemis on kasutusel ka lokaalne andmestik, on soovituslik valideerimise päring teha vahetult enne salvestamist, et lõppkasutaja saaks 
8. MedIN tagastab FHIR OperationOutcome ressursi, mille sees on valideerimisteated koos nende tasemetega
    * **NB!** Oluline on teada, et Ravimiskeemi hilisem kinnitamine ei õnnestu, juhul kui lahendamata on jäänud mõni valideerimisteade tasemega **Fatal** või **Error** 
9. Klientsüsteem kuvab teated lõppkasutajale, kes vajadusel korrigeerib andmeid
10. Lõppkasutaja on muudatustega lõpule jõudnud ja soovib Patsiendi ravimiskeemi uuel kujul - muudetud reaga - kinnitada, Klientsüsteem teeb päringu [Ravimiskeemi andmete kinnitamine](OperationDefinition-MedicationStatement-confirm.html)
    * Rea muutmisel tuleb arvestada, et järgnevate atribuutide muutmisel tühistatakse eelmised retseptid ja luuakse uued:
        * Toimeainete tugevused
        * Mitte asendada valik
        * ravimeid pakendis
        * pakkide arv
        * Müügiloata ravimi taotluse põhjendus + kirjeldus
        * retsepti kommentaar
        * Ravikuuri kestus
        * kordsus
        * volitus
        * retsepti kehtivus
    * **NB!** siin tuleb viitena anda sisse viimase muudatuse viide, milleks on Kinnitatud ravimiskeemi pärimisel saadud FHIR List ressurss - seda kasutatakse, et kontrollida, kas muudatused on tehtud kõige viimast seisu omades.
    * Päringu sisendisse tuleb anda kogu kinnitatud ravimiskeemi pärimisel saadud väljund koos muudatuste ja täiendustega - antud juhul muudetav rida muudetud kujul ning kõik ülejäänud Kinnitatud ravimiskeemi pärimisel saadud read
11. MedIN valideerib andmed, kontrollib koostoimeid, võimalusel tühistab muudetava reaga seotud retseptid ning loob uuendatud andmete pealt uued retseptid; salvestab FHIR andmed, tagastades FHIR Bundle, mis sisaldab kogu aktuaalset patsiendi ravimiskeemi, sh viiteid loodud retseptidele
    * Valideerimisreeglid - [MedIN Andmekvaliteedi kontrollid](controls.html)
    * **NB!** Juhul kui kinnitamise käigus tekib vigu ja tagastatakse OperationOutcome, siis saadetud andmeid ei salvestata, küll aga tehakse Retseptikeskuses retseptide tühistamist ja kinnitamist ükshaaval, mis võib tingida olukorra kus kinnitamine ebaõnnestub, kuid mingid retseptid siiski annulleeritakse ja uued luuakse. Sellisel juhul peegeldub see muudatus ka [Kinnitatud ravimiskeemi pärimine](OperationDefinition-MedicationStatement-confirmed-medication-scheme.html) päringu tulemustes.

### Ravimiskeemi ravimi pikendamine
*NB! Lihtsuse huvides on skeemilt ja tegevuste nimekirjast jäetud ära koostoimete pärimine*
<div>
<img src="ravimipikendamine.svg"  alt="Ravimiskeemi rea pikendamine" width="50%">
<p>Joonis 5. Ravimiskeemi rea pikendamine</p>
<p></p>
</div>

1. Klientsüsteem teeb MPI viite alusel päringu [Kinnitatud ravimiskeemi pärimine](OperationDefinition-MedicationStatement-confirmed-medication-scheme.html) 
2. MedIN tagastab FHIR Bundle, kus on sees ravimiskeemi andmestik ([vt MedIN Andmemudel](documentation.html))
3. Lõppkasutaja valib pikendada mingit kindlat rida ravimiskeemis, Klientsüsteem kuvab lõppkasutajale vastava vormi, kus kasutaja saab andmeid sisestada.
    * *"Pikendamise"* all mõeldakse muutmise ärilist erijuhtu, kus lõppkasutaja soovib pikendada ravi ehk samale ravimile väljastada uued retseptid ilma ravi muutmata. Seda tehakse sagedasti püsiravimite puhul.  
4. Lõppkasutaja on sisestanud pikendatava ravimi andmed ja klientsüsteem teeb päringu [Retsepti soodustuste pärimine](OperationDefinition-Task-reimbursements.html)
5. MedIN tagastab FHIR Task ressursis, mille Task.output atribuudis on soodusmäärade andmestik
6. Klientsüsteem kuvab soodusmäärade valiku lõppkasutajale või otsustab ise, millist soodusmäära kasutada
7. Lõppkasutaja on muudatustega lõpule jõudnud ja soovib Patsiendi ravimiskeemi uuel kujul - pikendatud reaga - kinnitada, Klientsüsteem teeb päringu [Ravimiskeemi andmete kinnitamine](OperationDefinition-MedicationStatement-confirm.html)
    * Rea pikendamiseks tuleb muuta vähemalt üht atribuuti, mis tingiks muutmise ahelas vanade retseptide tühistamise ja uute loomise (vt Ravimiskeemi ravimi muutmine) **JA täiendavalt tuleb pikendataval real täita atribuut MedicationStatement.PartOf**, lisades sinna pikendatava retsepti (ükskõik millise eelmise MedicationStatement.derivedFrom väärtuse - välja sisu valideeritakse vastu profiili aga sealt edasi kontrollitaks ainult välja täidetust). Selle atribuudi täitmine käivitab loogika, mis säilitab eelmised sama ravimiskeemi reaga seotud retseptid ning ei tühista neid
    * **NB!** siin tuleb viitena anda sisse viimase muudatuse viide, milleks on Kinnitatud ravimiskeemi pärimisel saadud FHIR List ressurss - seda kasutatakse, et kontrollida, kas muudatused on tehtud kõige viimast seisu omades.
    * Päringu sisendisse tuleb anda kogu kinnitatud ravimiskeemi pärimisel saadud väljund koos muudatuste ja täiendustega - antud juhul pikendatav rida muudetud kujul ning kõik ülejäänud Kinnitatud ravimiskeemi pärimisel saadud read
8. MedIN valideerib andmed, kontrollib koostoimeid, loob uuendatud andmete pealt uued retseptid; salvestab FHIR andmed, tagastades FHIR Bundle, mis sisaldab kogu aktuaalset patsiendi ravimiskeemi, sh viiteid loodud retseptidele
    * Valideerimisreeglid - [MedIN Andmekvaliteedi kontrollid](controls.html)
    * **NB!** Juhul kui kinnitamise käigus tekib vigu ja tagastatakse OperationOutcome, siis saadetud andmeid ei salvestata, küll aga tehakse Retseptikeskuses retseptide lisamist ükshaaval, mis võib tingida olukorra kus kinnitamine ebaõnnestub, kuid mingid retseptid siiski loodi. Sellisel juhul need loodud retseptid peegelduvad ka [Kinnitatud ravimiskeemi pärimine](OperationDefinition-MedicationStatement-confirmed-medication-scheme.html) päringu tulemustes

### Patsiendi ravimiskeemi ajaloo pärimine
1. Klientsüsteem teeb patsiendi MPI viite alusel päringu [Ravimiskeemi ajaloo pärimine](OperationDefinition-MedicationStatement-history.html)
2. MedIN tagastab FHIR Bundle, kus on sees patsiendi kõikide kunagi kehtinud ravimiskeemide koguandmestik ([vt MedIN Andmemudel](documentation.html)), st ravimiskeemide read ning seotud ravimite, retseptide ja väljamüükide andmed 
    * Retseptikeskusest leitakse ka kõik patsiendile kunagi määratud retseptid, nii kehtivad kui ka annuleeritud, ilma ajalise piiranguta (see on vajalik, kuna patsiendil võib olla retsepte, mis on lisatud nö ravimiskeemi väliselt ehk nende kohta puudub info MedIN-is)
    * FHIR Bundle tagastab List ressursid, mis sisaldavad nii MedIN-is kui ka Retseptikeskuses olevaid andmeid koos ravimiskeemi kinnitamise ajaga - olgu siis MedIN või Retseptikeskuse poolelt (RK poolelt on kinnitamise ajaks retsepti lisamise või annulleerimise aeg)
        *Üks List ressurss sisaldab ühe kinnitamisega seotud andmeid ehk ravimiskeemi rida/ridu
    * **NB!** Kuna tehakse üks päring, mis tagastab kõik patsiendiga seotud ravimiskeemide andmed, siis võib see olla üsna ajamahukas. Päringu filtreerimine parameetritega vähemalt esialgu planeeritud ei ole
3. Klientsüsteem kuvab patsiendi ravimiskeemide ajaloo lõppkasutajale
