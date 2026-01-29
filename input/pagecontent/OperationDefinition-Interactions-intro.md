# Koostoimete pärimine
URL: POST [base]/Medication/$interactions

This is NOT an idempotent operation.

## Kirjeldus
Klient-süsteemide töövoo paremaks toetamiseks on võimalik kasutada operation't analoogselt tänasele retseptikeskuse x-tee teenusele rets.koostoime_list:
- Andes ette ainult patsiendi viite - otsitakse koostoimeid patsiendi hetkel kehtivast ravimiskeemist
    - siin leitakse MedIN serveri andmestikust kehtiv ravimiskeem (aktuaalses kinnitatud ravimiskeemis sisalduvad MedicationStatement'ega seotud Medication ressursid)
    - Iga leitud Medication puhul luuakse SynBase API drug, kus märgitakse "old_drug": false
    - leitud koostoimetele leitakse ka MedicationStatement vasted - kus toimeained/preparaadid esinevad, need lisatakase ClinicalUseDefinition.affected väljas reference'dena
- Andes ette toimeained/preparaat - otsitakse koostoimeid ette antud toimeainete/preparaatide ja kehtiva ravimiskeemi vahel
    - siin leitakse MedIN serveri andmestikust kehtiv ravimiskeem (aktuaalses kinnitatud ravimiskeemis sisalduvad MedicationStatement'ega seotud Medication ressursid)
    - Igast leitud Medication puhul luuakse SynBase API drug, kus märgitakse "old_drug": true
    - Täiendavalt võetakse sisendist tulnud Medication kirjed ja nendest luuakse SynBase API drug kirjed, kus märgitakse "old_drug": false
    - Leitud koostoimetele leitakse ka MedicationStatement vasted - kus toimeained/preparaadid esinevad, need lisatakase ClinicalUseDefinition.affected väljas reference'dena
