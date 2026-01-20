## Ärireeglid

Patsiendi ravimiskeemi ajaloo pärimiseks mõeldud operation koosneb mitmest järjestikku tehtavast tegevusest:



joonis!



###  FHIR andmete leidmine

* Leiab patsiendi MPI viite alusel kõik ravimiskeemi kinnitamise faktid (EETISMedicationList) ning sellega seotud kehtivad ravimiskeemi read 
* **EI** filtreeri välja neid MedicationStatement'e, millel on määratud effective.end (need on ka märgitud List.entry.flag = ceased) ega neid, mis on konsolideeritud (nendel on märgitud List.entry.flag = consolidated)
* Tagastab nii kinnitamise fakti (List), MedicationStatement'd kui ka Medication'd (st ravimiskeemi reaga seotud ehk välja kirjutatud ravimi andmed)


### 1.2.2. Retseptikeskusest patsiendiga seotud retseptide pärimine

* Teeb päringud Retseptikeskusesse (vt Ravimiskeemi väliselt loodud retseptide päring) patsiendi isikukoodi alusel

&nbsp;	- Viidatud päringu kirjeldus käib ravimiskeemi kohta - **NB! ravimiskeemi ajaloo puhul tuleb sisendis teha järgnevad muudatused:**

&nbsp;		- koostatud alates kuupäev on rakenduses konfigureeritav, hetkel 2018-01-01

&nbsp;		- staatused ehk staatused.staatus väärtused puuduvad (huvitavad kõikides staatustes retseptid)

&nbsp;	- Päritakse kogu info - ehk üldinfo, määratud ravi, isikud, väljastatud (vt ka API kirjeldus), mh ei välistata annulleeritud retsepte

* Päringuga saab kätte kõik patsiendiga seotud retseptid läbi aegade - sealt tuleb järgmistes sammudes välja filtreerida:

&nbsp;	- Ravimiskeemiga seotud retseptid - sammu 1.2.3 jaoks (järgmine peatükk)

&nbsp;	- Ravimiskeemi väliselt tekkinud retseptid - sammu 1.2.4 jaoks (ülejärgmine peatükk)



### 1.2.3 Retseptikeskuse andmete põhjal FHIR ravimiskeemi andmete täiendamine

* Eeltingimus: punktis 1.2.2 on tehtud Retseptikeskuse päring
* Leiab Ravimiskeemi ridadega seotud retseptid

&nbsp;	- Retseptikeskuse päringu väljundis huvitavad ainult sellised retseptid, mille numbrid leiti punktis 1.2.1 (MedicationStatement.derivedFrom.identifier.value). Ülejäänud retseptide osas tuleb toimida nii, nagu kirjeldatud punktis 1.2.4

* Genereerib RK andmetest MedicationRequest ning MedicationDispense ja sellega seotud Medication (ehk välja ostetud ravimi) FHIR ressurssid (vt Ravimiskeemiga seotud retseptide vastus)

&nbsp;	- Ka siin on viidatud vastuse kirjeldus ravimiskeemi kohta, aga täpselt samad RK vastus → FHIR mäppimise reeglid kehtivad ka ajaloo puhul

* Ümber mäpitud ressursid lisatakse $history vastuse Bundle-sse



Selle sammu vastus oleks MedIN serveris olev täielik ravimiskeemi ajalugu ehk täiendatud Bundle List elementidest, kus on MedicationStatement ja sellega seotud Medication, MedicationRequest, MedicationDispense ja sellega seotud Medication.



### 1.2.4 Retseptikeskusest ravimiskeemi väliselt tekkinud kehtivate ja annulleeritud retseptide pärimine ning FHIR ressursside loomine

* Eeltingimus: punktis 1.2.2 on tehtud Retseptikeskuse päring
* Leiab Ravimiskeemi väliselt loodud retseptid:

&nbsp;	- Retseptikeskuse päringu väljundis huvitavad ainult sellised retseptid, mis \*\*ei ole\*\* ravimiskeemiga seotud, st mille kohta puuduvad viited punktis 1.2.1 leitud ravimiskeemi ridades

* Genereerib RK andmetest MedicationRequest ja sellega seotud Medication ning MedicationDispense ja omakorda sellega seotud Medication FHIR ressurssid, lisaks genereerib nende alusel seotud FHIR MedicationStatement ressursid (vt Ravimiskeemi väliselt loodud retseptide vastus). 

&nbsp;	- Viidatud vastuse kirjeldus käib ravimiskeemiga seotud retseptide pärimise kohta, aga täpselt samad RK vastus → FHIR mäppimise reeglid kehtivad ka ajaloo puhul. \*\*NB! Ainuke erinevus ravimiskeemi ajaloo puhul on järgmine:\*\*

&nbsp;		- Kui RK tagastab annulleeritud staatuses retsepti, siis tuleb sellest teha kaks MedicationStatement'i - üks, millel MedicationStatement.effectivePeriod.end on täitmata ja teine, millel MedicationStatement.effectivePeriod.end = annulleerimise kuupäev 

Muus osas on mäppimine täpselt sama ning mõlemad MedicationStatement ressursid viitavad samale MedicationRequest'ile

Mõlema MedicationStatement kohta tuleb ka luua eraldi List ressurss (vt järgmist punkti)

* Lisaks eelkirjeldatule tuleb iga loodud MedicationStatement'i kohta genereerida ka List ressurss kinnitaja andmetega (RK-st päritud retseptide puhul on alati ühe kinnitamise kohta üks retsept). Vt mäppimise kirjeldust siit - Kinnitamise fakti loomine retseptide põhjal. Kirjeldus käib ravimiskeemi kinnitamise kohta - \*\*NB! ravimiskeemi ajaloo osas on mäppimisel järgnevad täiendused:\*\*

&nbsp;	- Kinnitamisega seotud ravimiskeemi read - List.Entry\[] kollektsioon täita \*\*ainult Ravimiskeemi väliselt loodud retsepti genereeritud MedicationStatement'iga\*\*

&nbsp;	- rea flag - \*\*Märkida vastavalt retsepti staatusele, mille pealt List genereeritakse:\*\*

&nbsp;		- annulleeritud - ceased

&nbsp;		- teised staatused - prescribed

&nbsp;	- rea viide - \*\*Märkida retsepti andmete põhjal loodud MedicationStatement viide\*\*

&nbsp;	- rea kuupäev - \*\*Võtta see retsepti andmete põhjal loodud MedicationStatement.effective.start väljast\*\*

* Ümber mäpitud ressursid lisatakse $history vastuse Bundle-sse



Selle sammu vastus oleks punktis 1.2.3 saadud Bundle täiendamine ainult Retseptikeskuses olevate retseptide põhjal loodud List elementidega, kus on MedicationStatement ja sellega seotud Medication, MedicationRequest, MedicationDispense ja sellega seotud Medication.



### 1.2.5 Grupeerimise loogika rakendamine

* Eeltingimus: kas siin on neid?
* Rakendab kogu saadud tulemile Ravimiskeemi ajaloos kasutatav grupeerimise loogika

Selle sammu vastus oleks kõikidele leitud andmetele eraldi arvutusliku grupeerimise identifier lisamine  


## 1.3 Näited

Näidispäring patsiendi viitega

Ravimiskeemi ajaloo pärimine

```

GET /MedicationStatement/$history?subject=Patient/140959

```

Näidisvastus 

Ravimiskeemi ajaloo näidisvastus

```
{
    "resourceType": "Bundle",
    "type": "searchset",
    "entry": [
        {
            "fullUrl": "Medication/988",
            "resource": {
                "resourceType": "Medication",
                "id": "988",
                "meta": {
                    "versionId": "1",
                    "lastUpdated": "2024-09-06T12:14:04+03:00",
                    "profile": [
                        "https://fhir.ee/StructureDefinition/ee-tis-medication-epc"
                    ]
                },
                "extension": [
                    {
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification",
                        "valueCodeableConcept": {
                            "coding": [
                                {
                                    "system": "https://fhir.ee/CodeSystem/atc",
                                    "code": "C08DA01"
                                }
                            ]
                        }
                    }
                ],
                "doseForm": {
                    "coding": [
                        {
                            "system": "https://fhir.ee/CodeSystem/ravimvormid",
                            "code": "1224",
                            "display": "toimeainet prolongeeritult vabastav tablett"
                        }
                    ]
                },
                "totalVolume": {
                    "value": 20,
                    "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
                    "code": "TK"
                },
                "ingredient": [
                    {
                        "item": {
                            "concept": {
                                "coding": [
                                    {
                                        "system": "https://fhir.ee/CodeSystem/toimeained",
                                        "code": "10872",
                                        "display": "verapamiil"
                                    }
                                ]
                            }
                        },
                        "isActive": true,
                        "strengthRatio": {
                            "numerator": {
                                "value": 120,
                                "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
                                "code": "mg"
                            },
                            "denominator": {
                                "value": 1,
                                "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
                                "code": "TK"
                            }
                        }
                    }
                ]
            }
        },
        {
            "fullUrl": "MedicationStatement/989",
            "resource": {
                "resourceType": "MedicationStatement",
                "id": "989",
                "meta": {
                    "versionId": "1",
                    "lastUpdated": "2024-09-06T12:14:04+03:00",
                    "profile": [
                        "https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
                    ]
                },
                "contained": [
                    {
                        "resourceType": "PractitionerRole",
                        "id": "PractitionerRole-D09908",
                        "meta": {
                            "profile": [
                                "https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
                            ]
                        },
                        "active": true,
                        "practitioner": {
                            "identifier": {
                                "system": "https://fhir.ee/sid/pro/est/pho",
                                "value": "D09908"
                            },
                            "display": "EGE KÄOSAAR"
                        },
                        "organization": {
                            "identifier": {
                                "system": "https://fhir.ee/sid/org/est/br",
                                "value": "90006399"
                            },
                            "display": "sihtasutus Põhja-Eesti Regionaalhaigla"
                        },
                        "specialty": [
                            {
                                "coding": [
                                    {
                                        "system": "https://fhir.ee/CodeSystem/ee-medre-specialty",
                                        "code": "E160",
                                        "display": "infektsioonhaigused"
                                    }
                                ]
                            }
                        ],
                        "contact": [
                            {
                                "telecom": [
                                    {
                                        "system": "email",
                                        "value": "email@example.com"
                                    },
                                    {
                                        "system": "phone",
                                        "value": "37256789012"
                                    }
                                ]
                            }
                        ]
                    }
                ],
                "extension": [
                    {
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time",
                        "valueDateTime": "2024-11-05T02:00:00+02:00"
                    },
                    {
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-medication-left",
                        "valueInteger": 20
                    },
                    {
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
                        "valueInteger": 20
                    },
                    {
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-authorization",
                        "valueCodeableConcept": {
                            "coding": [
                                {
                                    "system": "https://fhir.ee/CodeSystem/retsepti-volituse-liik",
                                    "code": "public"
                                }
                            ]
                        }
                    },
                    {
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-intent",
                        "valueCode": "order"
                    },
                    {
                        "extension": [
                            {
                                "url": "substitutionAllowed",
                                "valueBoolean": true
                            }
                        ],
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-substitution-allowed"
                    },
                    {
                        "extension": [
                            {
                                "url": "reimbursementRate",
                                "valueCodeableConcept": {
                                    "coding": [
                                        {
                                            "system": "https://fhir.ee/CodeSystem/retsepti-soodustuse-maar",
                                            "code": "0"
                                        }
                                    ]
                                }
                            }
                        ],
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
                    },
                    {
                        "extension": [
                            {
                                "url": "verificationTime",
                                "valueDateTime": "2024-09-06T12:14:05+03:00"
                            },
                            {
                                "url": "verificationAuthor",
                                "valueReference": {
                                    "identifier": {
                                        "system": "https://fhir.ee/sid/pro/est/pho",
                                        "value": "D09908"
                                    },
                                    "display": "EGE KÄOSAAR, infektsioonhaigused"
                                }
                            }
                        ],
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
                    }
                ],
                "status": "recorded",
                "category": [
                    {
                        "coding": [
                            {
                                "system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
                                "code": "p"
                            }
                        ]
                    },
                    {
                        "coding": [
                            {
                                "system": "https://fhir.ee/CodeSystem/statement-origin-category",
                                "code": "pc"
                            }
                        ]
                    },
                    {
                        "coding": [
                            {
                                "system": "https://fhir.ee/CodeSystem/retsepti-liik",
                                "code": "1"
                            }
                        ]
                    },
                    {
                        "coding": [
                            {
                                "system": "https://fhir.ee/CodeSystem/retsepti-kordsus",
                                "code": "1"
                            }
                        ]
                    }
                ],
                "medication": {
                    "reference": {
                        "reference": "Medication/988"
                    }
                },
                "subject": {
                    "reference": "Patient/140959"
                },
                "effectivePeriod": {
                    "start": "2024-09-06T03:00:00+03:00"
                },
                "dateAsserted": "2024-09-06T12:14:03+03:00",
                "informationSource": [
                    {
                        "reference": "#PractitionerRole-D09908",
                        "display": "EGE KÄOSAAR"
                    }
                ],
                "derivedFrom": [
                    {
                        "identifier": {
                            "system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
                            "value": "1018869912"
                        }
                    }
                ],
                "reason": [
                    {
                        "concept": {
                            "coding": [
                                {
                                    "system": "https://fhir.ee/CodeSystem/rhk10",
                                    "code": "C57.0"
                                }
                            ]
                        }
                    }
                ],
                "dosage": [
                    {
                        "timing": {
                            "repeat": {
                                "frequency": 1,
                                "period": 1,
                                "periodUnit": "h"
                            }
                        },
                        "route": {
                            "coding": [
                                {
                                    "system": "https://fhir.ee/CodeSystem/manustamistee",
                                    "code": "suukaudne"
                                }
                            ]
                        },
                        "doseAndRate": [
                            {
                                "doseQuantity": {
                                    "value": 1,
                                    "unit": "milligramm",
                                    "system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
                                    "code": "MG"
                                }
                            }
                        ]
                    }
                ]
            }
        },
        {
            "fullUrl": "MedicationStatement/989",
            "resource": {
                "resourceType": "MedicationStatement",
                "id": "989",
                "meta": {
                    "versionId": "2",
                    "lastUpdated": "2024-09-09T15:16:18+03:00",
                    "profile": [
                        "https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
                    ]
                },
                "contained": [
                    {
                        "resourceType": "PractitionerRole",
                        "id": "PractitionerRole-D09908",
                        "meta": {
                            "profile": [
                                "https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
                            ]
                        },
                        "active": true,
                        "practitioner": {
                            "identifier": {
                                "system": "https://fhir.ee/sid/pro/est/pho",
                                "value": "D09908"
                            },
                            "display": "EGE KÄOSAAR"
                        },
                        "organization": {
                            "identifier": {
                                "system": "https://fhir.ee/sid/org/est/br",
                                "value": "90006399"
                            },
                            "display": "sihtasutus Põhja-Eesti Regionaalhaigla"
                        },
                        "specialty": [
                            {
                                "coding": [
                                    {
                                        "system": "https://fhir.ee/CodeSystem/ee-medre-specialty",
                                        "code": "E160",
                                        "display": "infektsioonhaigused"
                                    }
                                ]
                            }
                        ],
                        "contact": [
                            {
                                "telecom": [
                                    {
                                        "system": "email",
                                        "value": "email@example.com"
                                    },
                                    {
                                        "system": "phone",
                                        "value": "37256789012"
                                    }
                                ]
                            }
                        ]
                    }
                ],
                "extension": [
                    {
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time",
                        "valueDateTime": "2024-11-05T02:00:00+02:00"
                    },
                    {
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-medication-left",
                        "valueInteger": 20
                    },
                    {
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
                        "valueInteger": 20
                    },
                    {
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-authorization",
                        "valueCodeableConcept": {
                            "coding": [
                                {
                                    "system": "https://fhir.ee/CodeSystem/retsepti-volituse-liik",
                                    "code": "public"
                                }
                            ]
                        }
                    },
                    {
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-intent",
                        "valueCode": "order"
                    },
                    {
                        "extension": [
                            {
                                "url": "substitutionAllowed",
                                "valueBoolean": true
                            }
                        ],
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-substitution-allowed"
                    },
                    {
                        "extension": [
                            {
                                "url": "reimbursementRate",
                                "valueCodeableConcept": {
                                    "coding": [
                                        {
                                            "system": "https://fhir.ee/CodeSystem/retsepti-soodustuse-maar",
                                            "code": "0"
                                        }
                                    ]
                                }
                            }
                        ],
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
                    },
                    {
                        "extension": [
                            {
                                "url": "verificationTime",
                                "valueDateTime": "2024-09-06T12:14:05+03:00"
                            },
                            {
                                "url": "verificationAuthor",
                                "valueReference": {
                                    "identifier": {
                                        "system": "https://fhir.ee/sid/pro/est/pho",
                                        "value": "D09908"
                                    },
                                    "display": "EGE KÄOSAAR, infektsioonhaigused"
                                }
                            }
                        ],
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
                    },
                    {
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-cancelled-status-reason",
                        "valueCodeableConcept": {
                            "coding": [
                                {
                                    "system": "https://fhir.ee/CodeSystem/retsepti-annulleerimise-pohjus",
                                    "code": "AN02"
                                }
                            ]
                        }
                    },
                    {
                        "extension": [
                            {
                                "url": "verificationTime",
                                "valueDateTime": "2024-09-09T15:16:20+03:00"
                            },
                            {
                                "url": "verificationAuthor",
                                "valueReference": {
                                    "identifier": {
                                        "system": "https://fhir.ee/sid/pro/est/pho",
                                        "value": "D09908"
                                    },
                                    "display": "EGE KÄOSAAR, infektsioonhaigused"
                                }
                            }
                        ],
                        "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
                    }
                ],
                "status": "recorded",
                "category": [
                    {
                        "coding": [
                            {
                                "system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
                                "code": "p"
                            }
                        ]
                    },
                    {
                        "coding": [
                            {
                                "system": "https://fhir.ee/CodeSystem/statement-origin-category",
                                "code": "pc"
                            }
                        ]
                    },
                    {
                        "coding": [
                            {
                                "system": "https://fhir.ee/CodeSystem/retsepti-liik",
                                "code": "1"
                            }
                        ]
                    },
                    {
                        "coding": [
                            {
                                "system": "https://fhir.ee/CodeSystem/retsepti-kordsus",
                                "code": "1"
                            }
                        ]
                    }
                ],
                "medication": {
                    "reference": {
                        "reference": "Medication/988"
                    }
                },
                "subject": {
                    "reference": "Patient/140959"
                },
                "effectivePeriod": {
                    "start": "2024-09-06T03:00:00+03:00",
                    "end": "2024-09-09T03:00:00+03:00"
                },
                "dateAsserted": "2024-09-06T12:14:03+03:00",
                "informationSource": [
                    {
                        "reference": "#PractitionerRole-D09908",
                        "display": "EGE KÄOSAAR"
                    }
                ],
                "derivedFrom": [
                    {
                        "identifier": {
                            "system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
                            "value": "1018869912"
                        }
                    }
                ],
                "reason": [
                    {
                        "concept": {
                            "coding": [
                                {
                                    "system": "https://fhir.ee/CodeSystem/rhk10",
                                    "code": "C57.0"
                                }
                            ]
                        }
                    }
                ],
                "dosage": [
                    {
                        "timing": {
                            "repeat": {
                                "frequency": 1,
                                "period": 1,
                                "periodUnit": "h"
                            }
                        },
                        "route": {
                            "coding": [
                                {
                                    "system": "https://fhir.ee/CodeSystem/manustamistee",
                                    "code": "suukaudne"
                                }
                            ]
                        },
                        "doseAndRate": [
                            {
                                "doseQuantity": {
                                    "value": 1,
                                    "unit": "milligramm",
                                    "system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
                                    "code": "MG"
                                }
                            }
                        ]
                    }
                ]
            }
        },
        {
            "fullUrl": "List/990",
            "resource": {
                "resourceType": "List",
                "id": "990",
                "meta": {
                    "versionId": "1",
                    "lastUpdated": "2024-09-06T12:14:04+03:00",
                    "profile": [
                        "https://fhir.ee/StructureDefinition/ee-tis-medication-list"
                    ]
                },
                "contained": [
                    {
                        "resourceType": "PractitionerRole",
                        "id": "PractitionerRole-D09908",
                        "meta": {
                            "profile": [
                                "https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
                            ]
                        },
                        "active": true,
                        "practitioner": {
                            "identifier": {
                                "system": "https://fhir.ee/sid/pro/est/pho",
                                "value": "D09908"
                            },
                            "display": "EGE KÄOSAAR"
                        },
                        "organization": {
                            "identifier": {
                                "system": "https://fhir.ee/sid/org/est/br",
                                "value": "90006399"
                            },
                            "display": "sihtasutus Põhja-Eesti Regionaalhaigla"
                        },
                        "specialty": [
                            {
                                "coding": [
                                    {
                                        "system": "https://fhir.ee/CodeSystem/ee-medre-specialty",
                                        "code": "E160",
                                        "display": "infektsioonhaigused"
                                    }
                                ]
                            }
                        ],
                        "contact": [
                            {
                                "telecom": [
                                    {
                                        "system": "email",
                                        "value": "email@example.com"
                                    },
                                    {
                                        "system": "phone",
                                        "value": "37256789012"
                                    }
                                ]
                            }
                        ]
                    }
                ],
                "status": "current",
                "mode": "snapshot",
                "title": "Ravimiskeem",
                "subject": [
                    {
                        "reference": "Patient/140959"
                    }
                ],
                "date": "2024-09-06T12:14:05+03:00",
                "source": {
                    "reference": "#PractitionerRole-D09908",
                    "display": "EGE KÄOSAAR"
                },
                "entry": [
                    {
                        "flag": {
                            "coding": [
                                {
                                    "system": "urn:oid:1.2.36.1.2001.1001.101.104.16592",
                                    "code": "04",
                                    "display": "Prescribed"
                                }
                            ]
                        },
                        "deleted": false,
                        "date": "2024-09-06",
                        "item": {
                            "reference": "MedicationStatement/989/_history/1"
                        }
                    }
                ]
            }
        },
        {
            "fullUrl": "List/998",
            "resource": {
                "resourceType": "List",
                "id": "998",
                "meta": {
                    "versionId": "1",
                    "lastUpdated": "2024-09-09T15:16:18+03:00",
                    "profile": [
                        "https://fhir.ee/StructureDefinition/ee-tis-medication-list"
                    ]
                },
                "contained": [
                    {
                        "resourceType": "PractitionerRole",
                        "id": "PractitionerRole-D09908",
                        "meta": {
                            "profile": [
                                "https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
                            ]
                        },
                        "active": true,
                        "practitioner": {
                            "identifier": {
                                "system": "https://fhir.ee/sid/pro/est/pho",
                                "value": "D09908"
                            },
                            "display": "EGE KÄOSAAR"
                        },
                        "organization": {
                            "identifier": {
                                "system": "https://fhir.ee/sid/org/est/br",
                                "value": "90006399"
                            },
                            "display": "sihtasutus Põhja-Eesti Regionaalhaigla"
                        },
                        "specialty": [
                            {
                                "coding": [
                                    {
                                        "system": "https://fhir.ee/CodeSystem/ee-medre-specialty",
                                        "code": "E160",
                                        "display": "infektsioonhaigused"
                                    }
                                ]
                            }
                        ],
                        "contact": [
                            {
                                "telecom": [
                                    {
                                        "system": "email",
                                        "value": "email@example.com"
                                    },
                                    {
                                        "system": "phone",
                                        "value": "37256789012"
                                    }
                                ]
                            }
                        ]
                    }
                ],
                "status": "current",
                "mode": "snapshot",
                "title": "Ravimiskeem",
                "subject": [
                    {
                        "reference": "Patient/140959"
                    }
                ],
                "date": "2024-09-09T15:16:20+03:00",
                "source": {
                    "reference": "#PractitionerRole-D09908",
                    "display": "EGE KÄOSAAR"
                },
                "entry": [
                    {
                        "flag": {
                            "coding": [
                                {
                                    "system": "urn:oid:1.2.36.1.2001.1001.101.104.16592",
                                    "code": "05",
                                    "display": "Ceased"
                                }
                            ]
                        },
                        "deleted": false,
                        "date": "2024-09-09",
                        "item": {
                            "reference": "MedicationStatement/989/_history/2"
                        }
                    }
                ]
            }
        }
    ]
} 

```





