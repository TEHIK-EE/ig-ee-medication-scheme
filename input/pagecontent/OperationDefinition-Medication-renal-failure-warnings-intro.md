# Kirjeldus
Neerufunktsiooni hoiatusi saab pärida kas patsiendi kehtiva ravimiskeemi kohta VÕI ühe lisatava ravimi kohta. Mõlemal juhul päritakse sisemiselt TIS-s olev patsiendi viimane eGFR näit, kontrollitakse, kas see on vastavalt äriloogikale aegunud ning võimalusel kasutatakse seda kehtivate hoiatuste pärimiseks. Juhul kui eGFR näit ei ole kehtiv, tagastatakse toimeaine(te) kohta kõige kõrgema tasemega leitud hoiatused.   

- Andes ette ainult patsiendi viite - otsitakse hoiatusi patsiendi hetkel kehtivast ravimiskeemist
    - siin leitakse MedIN serveri andmestikust kehtiv ravimiskeem (aktuaalses kinnitatud ravimiskeemis sisalduvad MedicationStatement'ega seotud Medication ressursid)
    - Iga leitud Medication saadetakse SynBase Otsustustoe päringusse
    - leitud hoiatustele leitakse ka MedicationStatement vasted ClinicalUseDefinition.affected väljas reference'dena
- Andes ette toimeained/preparaadi - otsitakse hoiatusi AINULT ette antud toimeainete/preparaatide alusel, patsiendi ravimiskeemi kohta hoiatusi ei tagastata
    - sisendis olevad Medication andmed saadetakse SynBase Otsustustoe päringusse
    - tagastatakse leitud hoiatused
- Mõlemal juhul tagastatakse ka leitud patsiendi kehtiv eGFR näit, kui see leitakse