### Ärireeglid

- In each drug, either drug code or combination of substances and drug form id should be provided
- Server ei loe siin kohustuslikuks muud kui toimeainete ja ravimvormi andmestikku
- **NB!** Koostoimete kontrolli tehakse vähemalt kahe ravimi olemasolul:
    - Kui kinnitatud ravimiskeemis (sh RK andmed) on vähemalt üks rida ja lisatakse ravimit
    - kui päritakse koostoimeid kinnitatud ravimiskeemi kohta ja leitakse vähemalt kaks rida (sh RK andmed) 
    - juhul kui tingimus ei ole täidetud, katkeb töö ja päringut ei tehta
- vt ka Otsustutoe integratsiooni puhul andmete mappingut: MedIN Otsustustoe integratsioon

## Näited
Näide on tehtud olukorrale, kus lisatavat ravimit kaasa ei anta, on ainult patsiendi viide:

**Näidispäring patsiendi viitega**
```
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
Näidis-väljund olukorras, kus on leitud üks koostoime, mis mõjutab kahte ravimiskeemi rida:

**Näidisvastus ühe koostoimega**
```
{
    "resourceType": "Bundle",
    "type": "collection",
    "entry": [
        {
            "resourceType": "ClinicalUseDefinition",
            "id": "medication-interaction1",
            "meta": {
                "profile": [
                    "https://fhir.ee/StructureDefinition/ee-tis-medication-interaction"
                ]
            },
            "contained": [
                {
                    "resourceType": "Medication",
                    "id": "medication-interaction1-varfariin",
                    "meta": {
                        "profile": [
                            "https://fhir.ee/StructureDefinition/ee-tis-medication-epc"
                        ]
                    },
                    "doseForm": {
                        "coding": [
                            {
                                "system": "https://fhir.ee/CodeSystem/ravimvormid",
                                "code": "738",
                                "display": "tablett"
                            }
                        ]
                    },
                    "ingredient": [
                        {
                            "item": {
                                "concept": {
                                    "coding": [
                                        {
                                            "system": "https://fhir.ee/CodeSystem/toimeained",
                                            "code": "11360",
                                            "display": "varfariin"
                                        }
                                    ]
                                }
                            },
                            "isActive": true,
                        }
                    ]
                },
                {
                    "resourceType": "Medication",
                    "id": "medication-interaction1-ibuprofeen",
                    "meta": {
                        "profile": [
                            "https://fhir.ee/StructureDefinition/ee-tis-medication-epc"
                        ]
                    },
                    "ingredient": [
                        {
                            "item": {
                                "concept": {
                                    "coding": [
                                        {
                                            "system": "https://fhir.ee/CodeSystem/toimeained",
                                            "code": "9210",
                                            "display": "ibuprofeen"
                                        }
                                    ]
                                }
                            },
                            "isActive": true
                        }
                    ]
                }
            ],
            "type": "interaction",
            "category": [
                {
                    "text": "D. Kliiniliselt oluline koostoime, mida tuleb pigem vältida"
                },
                {
                    "text": "4.Andmed on saadud asjakohase patsiendirühma seas korraldatud kontrollitud uuringutest"
                }
            ],
            "affected": [
                {
                    "reference": "MedicationStatement/123"
                },
                {
                    "reference": "MedicationStatement/456"
                }
            ],
            "subject": [
                {
                    "reference": "#medication-interaction1-varfariin"
                }
            ],
            "status": {
                "coding": [
                    {
                        "code": "active"
                    }
                ]
            },
            "interaction": {
                "interactant": [
                    {
                        "itemReference": {
                            "reference": "#medication-interaction1-ibuprofeen"
                        }
                    }
                ],
                "type": {
                    "coding": [
                        {
                            "system": "http://hl7.org/fhir/interaction-type",
                            "code": "drug-drug",
                            "display": "drug to drug interaction"
                        }
                    ],
                    "text": "drug to drug interaction"
                },
                "effect": {
                    "concept": {
                        "text": "MSPVA ja varfariini kooskasutamine võib põhjustada tugevat veritsust. Seedetrakti ülaosa verejooksu oht on 2–3 korda suurem võrreldes varfariini monoteraapiaga."
                    }
                },
                "incidence": {
                    "text": "D4"
                },
                "management": [
                    {
                        "text": "Varfariinravi patsientidel tuleb üldiselt vältida MSPVA kasutamist. Veritsusriski hindamiseks ei piisa ainult INRi väärtuse jälgimisest, kuna MSPVA mõjutab ka trombotsüütide funktsiooni. Kui samaaegset kasutamist ei saa vältida, kaaluda mao kaitseks prootonpumba inhibiitorite (nt lansoprasool, omeprasool või pantoprasool) kasutamist. Kui suukaudset antikoagulanti ja MSPVA-d kasutatakse ühel ajal, tuleb patsienti verejooksu sümptomite suhtes jälgida."
                    }
                ]
            }
        }
    ]
}
```
Näidis sisend  olukorrast, kus kaasa on antud nii patsiendi viide kui ka lisatav ravim:

```
**Näidispäring patsiendi viite ja lisatava ravimiga**

{
    "resourceType": "Parameters",
    "parameter": [
        {
            "name": "subject",
            "valueReference": {
                "reference": "Patient/123"
            }
        },
        {
            "name": "input",
            "resource": {
                "resourceType": "Medication",
                "id": "medication-interaction1-varfariin",
                "meta": {
                    "profile": [
                        "https://fhir.ee/StructureDefinition/ee-tis-medication-epc"
                    ]
                },
                "doseForm": {
                    "coding": [
                        {
                            "system": "https://fhir.ee/CodeSystem/ravimvormid",
                            "code": "738",
                            "display": "tablett"
                        }
                    ]
                },
                "ingredient": [
                    {
                        "item": {
                            "concept": {
                                "coding": [
                                    {
                                        "system": "https://fhir.ee/CodeSystem/toimeained",
                                        "code": "11360",
                                        "display": "varfariin"
                                    }
                                ]
                            }
                        },
                        "isActive": true
                    }
                ]
            }
        }
    ]
}
```