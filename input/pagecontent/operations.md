## Operations in Medication Scheme

Interaktsioonide jaoks tuleb kasutada operatsiooni [Medication/$interactions](OperationDefinition-medication-interactions.html)





### Koostoimete pärimine

Parameetrid

| **In Parameters:** |   |   |   |   |   |   |  
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | 				
| **Name** | **Scope** | **Cardinality** | **Type** | **Binding** | **Profile** | **Documentation** | 
| subject | type | 1..1 | Reference (Patient) |   | EEBasePatient | Patsiendi MPI viide - kelle ravimiskeemi vastu koostoimete kontrolli tehakse. | 
| input |   | 0..* | Medication |   | Medication | "Kui on lisatud, siis ravimid/toimeained, mille kohta küsitakse koostoimeid patsiendi hetkel kehtiva ravimiskeemiga <br />NB! Server ei loe siin kohustuslikuks muud kui toimeainete ja ravimvormi andmestikku". |  
{:.table-bordered .table-sm}


| **Out Parameters:** |   |   |   |   |   |   |  
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | 				
| **Name** | **Scope** | **Cardinality** | **Type** | **Binding** | **Profile** | **Documentation** | 
| return |   | 1..1 | Bundle |   | Bundle sees on EETISMedicationInteraction | "Operation väljundiks on alati Bundle - kui koostoimeid ei ole, on Bundle tühi.<br /> Toimeainete vahelised koostoimed, iga toimeainete paari vahel leitud koostoime on üks eraldiseisev ClinicalUseDefinition (EETISMedicationInteraction). <br />Tagastatavatel Medication ressurssidel on andmestikus märgitud vastvalt patsiendi ravimiskeemi andmetele - toimeaine + ravimvormi info, <br />täiendavalt võib ka kaasas olla pakendi viide ja nimetus. <br />Ravimiskeemi ridade viited on ClinicalUseDefinition.affected väljas reference'dena". |
{:.table-bordered .table-sm}

Ärireeglid:
 - In each drug, either drug code or combination of substances and drug form id should be provided
 - Server ei loe siin kohustuslikuks muud kui toimeainete ja ravimvormi andmestikku
 - vt ka Otsustutoe integratsiooni puhul andmete mappingut: MedIN Otsustustoe integratsioon

Näited

```json

{
    "resourceType": "Parameters",
    "parameter": [
        {
            "name": "subject",
            "valueReference": {
                "reference": "Patient/123"
            }
        }
    ]
}
```

|**see**  |On tabel. |aga|  |soovin | 
|**kas**  |Voiks nyyd töötada? |2 |noh |mis |
{:.table-bordered .table-sm}


|kui |raske |
|saab |olla? |
{:.table-bordered .table-sm}