# Use cases | Kasutusjuhud
{% include fsh-link-references.md %}
### Sissejuhatus
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
<img src=".svg"  alt="" width="60%">
<p>Joonis 1.</p>
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