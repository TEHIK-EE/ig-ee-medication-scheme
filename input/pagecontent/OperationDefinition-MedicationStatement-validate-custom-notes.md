URL: POST [base]/MedicationStatement/$validate-custom

DEV: 

This is NOT an idempotent operation.
## Ärireeglid
Esmalt valideeritakse kogu sisendit vastu viidatud FHIR profiile ning nende reegleid. Sellele järgneb nn äriline valideerimine.  

Ravimiskeemi valideerimisel sooritatakse järjestikku erinevaid kontrolle. Üldine reegel on, et kui ühes sammus tekib vigu, minnakse alati teistega edasi - püütakse leida kõik võimalikud vead.
OperationOutcome sisaldab **veakoodi ja kirjeldust**, mis annab tehnilise vea tekkimisel teenuse kasutajale teada, et tegemist on tehnilise veaga ning valideerimisprotsess ebaõnnestus. Vt MedIN.04 - Vigade kataloog

Skeemil on toodud tegevuste järjekord, iga ploki kohta on eraldi kirjeldus allpool. Peale kõikide plokkide läbimist tagastakse leitud veateated OperationOutcome väljundisse
<div>
<img src="ridadevalideerimine.svg"  alt="Ravimiskeemi ridade valideerimine" width="40%">
<p>Pilt 1 - siia ilus tekst diagrammi kohta</p>
<p></p>
</div>

## MedIN Andmekvaliteedi kontrollid
Operatsiooni sisendiga läbitakse MedIN Andmekvaliteedi kontrollid ning kogutakse tekkinud veateated

## Retseptikeskuse validatsioon
Operatsiooni sisendiga läbitakse Retseptikeskuse validatsioon ning kogutakse tekkinud veateated. Validatsioon teostatakse ainult nende ravimiskeemi ridade puhul, mille juures tuleb luua uus retsept. Kui tegemist on tühistamise või muutmisega, mis retsepti loomist ei nõua, siis jäetakse antud validatsioon vahele.
**NB!** Erinevus Ravimiskeemi andmete kinnitamine päringuga on see, et andmete valideerimisel küsitakse KÕIKIDE tasemete vigu, mitte ainult A ja E klassifikatsiooniga
Retseptikeskusest saadud vead peegeldatakse väljundisse koodiprefiksiga "MedIN-RK-".

## Näited
Ühe ravimiskeemi rea (MedicationStatment + Medication) valideerimiseks saatmine
**Näidispäring salvestamata ravimiskeemi reaga**:
```
{
  "resourceType": "Parameters",
  "parameter": [
    {
      "name": "input",
      "resource": {
        "resourceType": "Bundle",
        "type": "collection",
        "entry": [
          {
            "fullUrl": "urn:uuid:e8740459-8bfb-4692-a643-dbe486838414",
            "resource": {
              "resourceType": "MedicationStatement",
              "meta": {
                "profile": [
                  "https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
                ]
              },
              "contained": [
                {
                  "resourceType": "PractitionerRole",
                  "id": "med-statement-kinnitaja",
                  "meta": {
                    "profile": [
                      "https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
                    ]
                  },
                  "active": true,
                  "practitioner": {
                    "identifier": [
                      {
                        "system": "https://fhir.ee/sid/pro/est/pho",
                        "value": "D98765" /*siia MEDRE kood*/
                      }
                    ],
                    "display": "Mari Maasikas"
                  },
                  "organization": {
                    "identifier": [
                      {
                        "system": "https://fhir.ee/sid/org/est/br",
                        "value": "11073901" /*siia asutuse reg.kood*/
                      }
                    ],
                    "display": "Doktor Sirje Lille Hambaravi OÜ"
                  },
                  "specialty": [ /*siia MEDRE'st tulnud erialad, igaüks eraldi*/
                    {
                      "coding": [
                        {
                          "system": "https://fhir.ee/CodeSystem/ee-medre-specialty",
                          "code": "E170",
                          "display": "Kardioloogia"
                        }
                      ]
                    }
                  ],
                  "contact": [
                    {
                      "telecom": [
                        {
                          "system": "email",
                          "value": "mari.maasikas@example.org"
                        },
                        {
                          "system": "phone",
                          "value": "555 123456",
                          "use": "work"
                        }
                      ]
                    }
                  ]
                }
              ],
              "extension": [
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time",
                  "valueDateTime": "2024-08-17T03:00:00+03:00"
                },
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-medication-left",
                  "valueInteger": 1
                },
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
                  "valueInteger": 1
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
                      "url": "requestReason",
                      "valueCodeableConcept": {
                        "coding": [
                          {
                            "system": "https://fhir.ee/CodeSystem/myygiloata-ravimi-taotluse-pohjendus",
                            "code": "ML01"
                          }
                        ]
                      }
                    },
                    {
                      "url": "requestDate",
                      "valueDateTime": "2024-04-17T03:00:00+03:00"
                    },
                    {
                      "url": "requestReasonText",
                      "valueString": "siia miskit tarka juttu"
                    }
                  ],
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-marketing-request"
                }
              ],
              "status": "draft",
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
                      "code": "2"
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
                  "reference": "urn:uuid:a1dfb1df-9ef5-4b1f-b24b-3f0ede8d926e"
                }
              },
              "subject": {
                "reference": "Patient/94465"
              },
              "effectivePeriod": {
                "start": "2024-07-23T03:00:00+03:00"
              },
              "dateAsserted": "2024-07-23T14:42:58+03:00",
              "informationSource": [
                {
                  "reference": "#med-statement-kinnitaja"
                }
              ],
              "reason": [
                {
                  "concept": {
                    "coding": [
                      {
                        "system": "https://fhir.ee/CodeSystem/rhk10",
                        "code": "X50"
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
                      "periodUnit": "wk"
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
                        "unit": "ampull",
                        "system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
                        "code": "AM"
                      }
                    }
                  ]
                }
              ]
            }
          },
          {
            "fullUrl": "urn:uuid:a1dfb1df-9ef5-4b1f-b24b-3f0ede8d926e",
            "resource": {
              "resourceType": "Medication",
              "meta": {
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
                        "code": "N07BC02"
                      }
                    ]
                  }
                },
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name",
                  "valueString": "METADON DAK 1 MG/ML"
                }
              ],
              "identifier": [
                {
                  "system": "http://ravimiregister.ee/pakendid",
                  "value": "1034109"
                }
              ],
              "doseForm": {
                "coding": [
                  {
                    "system": "https://fhir.ee/CodeSystem/ravimvormid",
                    "code": "767",
                    "display": "suukaudne lahus"
                  }
                ]
              },
              "totalVolume": {
                "value": 4,
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
                          "code": "11969",
                          "display": "metadoon"
                        }
                      ]
                    }
                  },
                  "isActive": true,
                  "strengthRatio": {
                    "numerator": {
                      "value": 1,
                      "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
                      "code": "mg"
                    },
                    "denominator": {
                      "value": 1,
                      "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
                      "code": "ml"
                    }
                  }
                }
              ]
            }
          }
        ]
      }
    }
  ]
}
```
Näidis-väljund olukorras, kus on osad väljad täitmata ja tekib ka ravimiregistri vastu valideerimisel viga
NB! näidist täiendada, kui on tehtud ka Retseptikeskuse liidestus!

**Näidisvastus salvestamata ravimiskeemi reaga**
```
{
  "resourceType": "OperationOutcome",
  "issue": [
    {
      "severity": "error",
      "code": "business-rule",
      "details": {
        "coding": [
          {
            "code": "MedIN-022"
          }
        ],
        "text": "Reimbursement rate not specified for a medication statement"
      }
    },
    {
      "severity": "error",
      "code": "business-rule",
      "details": {
        "coding": [
          {
            "code": "MedIN-007"
          }
        ],
        "text": "Some MedicationStatements are not RECORDED"
      }
    },
    {
      "severity": "error",
      "code": "business-rule",
      "details": {
        "coding": [
          {
            "code": "MedIN-015"
          }
        ],
        "text": "Package '1034109' not found"
      }
    }
  ]
}
```