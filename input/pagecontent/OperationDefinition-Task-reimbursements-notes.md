URL: POST [base]/Task/$reimbursements

This is NOT an idempotent operation.

## Ärireeglid
- Task.input's kaasasolevat MedicationStatement ressurssi valideeritakse vastu profiili
- vt ka Retseptikeskuse integratsiooni puhul andmete mappingut: MedIN Retseptikeskuse integratsioon#Soodustustep%C3%A4rimine

## Näited
Näidis-sisend olukorras, kus andmeid ei ole veel salvestatud ja soovitakse pärida võimalikke soodustusi.

Kasutatud on [ravimit](https://ravimiregister.ee/publichomepage.aspx?pv=PublicMedDetail&vid=b1834c31-1479-4c89-b5d3-8f824c3190cb) ja eeldatud, et patsiendile pannakse diagnoos E11-E11 või E14-E14.

*Patsiendi viide on veel vigane.* 

**Näidispäring salvestamata ravimiskeemi reaga**
```
{
  "resourceType": "Parameters",
  "parameter": [
    {
      "name": "input",
      "resource": {
        "resourceType": "Task",
        "contained": [
          {
            "resourceType": "Medication",
            "meta": {
              "profile": [
                "https://fhir.ee/StructureDefinition/ee-tis-medication-epc"
              ]
            },
            "id": "input-medication",
            "extension": [
              {
                "url": "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification",
                "valueCodeableConcept": {
                  "coding": [
                    {
                      "system": "https://fhir.ee/CodeSystem/atc",
                      "code": "A10AE54",
                      "display": "glargiin-insuliin + liksisenatiid"
                    }
                  ]
                }
              },
              {
                "url": "https://fhir.ee/StructureDefinition/ee-tis-size-of-item",
                "valueQuantity": {
                  "value": 3,
                  "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
                  "code": "ML"
                }
              },
              {
                "url": "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name",
                "valueString": "SULIQUA"
              }
            ],
            "identifier": [
              {
                "system": "http://ravimiregister.ee/pakendid",
                "value": "1737042"
              }
            ],
            "doseForm": {
              "coding": [
                {
                  "system": "https://fhir.ee/CodeSystem/ravimvormid",
                  "code": "1461",
                  "display": "süstelahus pen-süstlis"
                }
              ]
            },
            "totalVolume": {
              "value": 12
            },
            "ingredient": [
              {
                "item": {
                  "concept": {
                    "coding": [
                      {
                        "system": "https://fhir.ee/CodeSystem/toimeained",
                        "code": "12560",
                        "display": "glargiin-insuliin"
                      }
                    ]
                  }
                },
                "isActive": true,
                "strengthRatio": {
                  "numerator": {
                    "value": 100,
                    "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
                    "code": "ÜHIK"
                  },
                  "denominator": {
                    "value": 1,
                    "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
                    "code": "TK"
                  }
                }
              },
              {
                "item": {
                  "concept": {
                    "coding": [
                      {
                        "system": "https://fhir.ee/CodeSystem/toimeained",
                        "code": "13527",
                        "display": "liksisenatiid"
                      }
                    ]
                  }
                },
                "isActive": true,
                "strengthRatio": {
                  "numerator": {
                    "value": 33,
                    "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
                    "code": "MCG"
                  },
                  "denominator": {
                    "value": 1,
                    "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
                    "code": "ML"
                  }
                }
              }
            ]
          },
          {
            "resourceType": "MedicationStatement",
            "meta": {
              "profile": [
                "https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
              ]
            },
            "id": "input-statement",
            "extension": [
              {
                "url": "https://fhir.ee/StructureDefinition/ee-tis-substitution-allowed",
                "extension": [
                  {
                    "url": "substitutionAllowed",
                    "valueBoolean": true
                  },
                  {
                    "url": "substitutionAllowedReason",
                    "valueCodeableConcept": {
                      "coding": [
                        {
                          "system": "https://fhir.ee/CodeSystem/ravimi-asendamatuse-pohjus",
                          "code": "KP08",
                          "display": "Patsiendil on diagnoositud kaasuv psüühika- või käitumishäire"
                        }
                      ]
                    }
                  }
                ]
              },
              {
                "url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
                "valueInteger": 15
              },
              {
                "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time",
                "valueDateTime": "2024-08-27T03:00:00+03:00"
              },
              {
                "url": "https://fhir.ee/StructureDefinition/ee-tis-medication-left",
                "valueInteger": 5
              },
              {
                "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-authorization",
                "valueCodeableConcept": {
                  "coding": [
                    {
                      "system": "https://fhir.ee/CodeSystem/retsepti-volituse-liik",
                      "code": "V",
                      "display": "volitatud"
                    }
                  ]
                }
              },
              {
                "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-intent",
                "valueCode": "order"
              }
            ],
            "status": "recorded",
            "category": [
              {
                "coding": [
                  {
                    "system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
                    "code": "p",
                    "display": "pidev"
                  }
                ],
                "text": "pidev"
              },
              {
                "coding": [
                  {
                    "system": "https://fhir.ee/CodeSystem/statement-origin-category",
                    "code": "123",
                    "display": "ei ole patsiendi ytluse põhjal"
                  }
                ]
              },
              {
                "coding": [
                  {
                    "system": "https://fhir.ee/CodeSystem/retsepti-liik",
                    "code": "1",
                    "display": "tavaretsept"
                  }
                ],
                "text": "tavaretsept"
              },
              {
                "coding": [
                  {
                    "system": "https://fhir.ee/CodeSystem/retsepti-kordsus",
                    "code": "3",
                    "display": "3-kordne"
                  }
                ],
                "text": "3-kordne"
              }
            ],
            "medication": {
              "reference": {
                "reference": "#input-medication"
              }
            },
            "subject": {
              "reference": "Patient/pat1MatiMeri"
            },
            "informationSource": [
              {
                "reference": "#PractitionerRole-N11243",
                "display": "Firstname Lastname"
              }
            ],
            "effectivePeriod": {
              "start": "2024-02-27"
            },
            "reason": [
              {
                "concept": {
                  "coding": [
                    {
                      "system": "http://fhir.ee/CodeSystem/rhk-10",
                      "code": "E11.3",
                      "display": "Insuliinisõltumatu suhkurtõbi silmatüsistusega"
                    }
                  ]
                }
              }
            ],
            "dosage": [
              {
                "patientInstruction": "süstida kõhunaha alla",
                "timing": {
                  "repeat": {
                    "frequency": 3,
                    "period": 1,
                    "periodUnit": "d",
                    "timeOfDay": [
                      "09:00:00",
                      "15:00:00",
                      "20:00:00"
                    ]
                  }
                },
                "doseAndRate": [
                  {
                    "doseQuantity": {
                      "value": 12,
                      "system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
                      "code": "TY"
                    }
                  }
                ]
              }
            ]
          },
          {
            "resourceType": "PractitionerRole",
            "id": "PractitionerRole-N11243",
            "meta": {
              "profile": [
                "https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
              ]
            },
            "active": true,
            "practitioner": {
              "identifier": {
                "system": "https://fhir.ee/sid/pro/est/pho",
                "value": "N11243"
              },
              "display": "Firstname Lastname"
            },
            "organization": {
              "identifier": {
                "system": "https://fhir.ee/sid/org/est/br",
                "value": "11242172"
              },
              "display": "Aktsiaselts Ida-Tallinna Keskhaigla"
            },
            "code": [
              {
                "coding": [
                  {
                    "system": "http://terminology.hl7.org/CodeSystem/practitioner-role",
                    "code": "doctor",
                    "display": "Doctor"
                  }
                ]
              }
            ],
            "specialty": [
              {
                "coding": [
                  {
                    "system": "https://fhir.ee/CodeSystem/ee-medre-specialty",
                    "code": "E130",
                    "display": "E130-display"
                  }
                ]
              }
            ],
            "contact": [
              {
                "telecom": [
                  {
                    "system": "email",
                    "value": "test@example.com"
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
        "meta": {
          "profile": [
            "https://fhir.ee/StructureDefinition/ee-tis-reinbursement-task"
          ]
        },
        "implicitRules": "http://hl7.org/fhir/reference",
        "status": "requested",
        "intent": "proposal",
        "priority": "routine",
        "focus": {
          "reference": "#input-statement"
        }
      }
    }
  ]
}
```
Näidis-väljund olukorras, kus on saadetud Ravimiskeemi rida, mida ei ole veel maha salvestatud:

**Näidisvastus salvestamata ravimiskeemi reaga**
```
{
  "resourceType": "Task",
  "meta": {
    "profile": [
      "https://fhir.ee/StructureDefinition/ee-tis-reinbursement-task"
    ]
  },
  "implicitRules": "http://hl7.org/fhir/reference",
  "contained": [
    {
      "resourceType": "Medication",
      "id": "input-medication",
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
                "code": "A10AE54",
                "display": "glargiin-insuliin + liksisenatiid"
              }
            ]
          }
        },
        {
          "url": "https://fhir.ee/StructureDefinition/ee-tis-size-of-item",
          "valueQuantity": {
            "value": 3,
            "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
            "code": "ML"
          }
        },
        {
          "url": "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name",
          "valueString": "SULIQUA"
        }
      ],
      "identifier": [
        {
          "system": "http://ravimiregister.ee/pakendid",
          "value": "1737042"
        }
      ],
      "doseForm": {
        "coding": [
          {
            "system": "https://fhir.ee/CodeSystem/ravimvormid",
            "code": "1461",
            "display": "süstelahus pen-süstlis"
          }
        ]
      },
      "totalVolume": {
        "value": 12
      },
      "ingredient": [
        {
          "item": {
            "concept": {
              "coding": [
                {
                  "system": "https://fhir.ee/CodeSystem/toimeained",
                  "code": "12560",
                  "display": "glargiin-insuliin"
                }
              ]
            }
          },
          "isActive": true,
          "strengthRatio": {
            "numerator": {
              "value": 100,
              "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
              "code": "ÜHIK"
            },
            "denominator": {
              "value": 1,
              "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
              "code": "TK"
            }
          }
        },
        {
          "item": {
            "concept": {
              "coding": [
                {
                  "system": "https://fhir.ee/CodeSystem/toimeained",
                  "code": "13527",
                  "display": "liksisenatiid"
                }
              ]
            }
          },
          "isActive": true,
          "strengthRatio": {
            "numerator": {
              "value": 33,
              "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
              "code": "MCG"
            },
            "denominator": {
              "value": 1,
              "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
              "code": "ML"
            }
          }
        }
      ]
    },
    {
      "resourceType": "MedicationStatement",
      "id": "input-statement",
      "meta": {
        "profile": [
          "https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
        ]
      },
      "extension": [
        {
          "extension": [
            {
              "url": "substitutionAllowed",
              "valueBoolean": true
            },
            {
              "url": "substitutionAllowedReason",
              "valueCodeableConcept": {
                "coding": [
                  {
                    "system": "https://fhir.ee/CodeSystem/ravimi-asendamatuse-pohjus",
                    "code": "KP08",
                    "display": "Patsiendil on diagnoositud kaasuv psüühika- või käitumishäire"
                  }
                ]
              }
            }
          ],
          "url": "https://fhir.ee/StructureDefinition/ee-tis-substitution-allowed"
        },
        {
          "url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
          "valueInteger": 15
        },
        {
          "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time",
          "valueDateTime": "2024-08-27T03:00:00+03:00"
        },
        {
          "url": "https://fhir.ee/StructureDefinition/ee-tis-medication-left",
          "valueInteger": 5
        },
        {
          "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-authorization",
          "valueCodeableConcept": {
            "coding": [
              {
                "system": "https://fhir.ee/CodeSystem/retsepti-volituse-liik",
                "code": "V",
                "display": "volitatud"
              }
            ]
          }
        },
        {
          "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-intent",
          "valueCode": "order"
        }
      ],
      "status": "recorded",
      "category": [
        {
          "coding": [
            {
              "system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
              "code": "p",
              "display": "pidev"
            }
          ],
          "text": "pidev"
        },
        {
          "coding": [
            {
              "system": "https://fhir.ee/CodeSystem/statement-origin-category",
              "code": "123",
              "display": "ei ole patsiendi ytluse põhjal"
            }
          ]
        },
        {
          "coding": [
            {
              "system": "https://fhir.ee/CodeSystem/retsepti-liik",
              "code": "1",
              "display": "tavaretsept"
            }
          ],
          "text": "tavaretsept"
        },
        {
          "coding": [
            {
              "system": "https://fhir.ee/CodeSystem/retsepti-kordsus",
              "code": "3",
              "display": "3-kordne"
            }
          ],
          "text": "3-kordne"
        }
      ],
      "medication": {
        "reference": {
          "reference": "#input-medication"
        }
      },
      "subject": {
        "reference": "Patient/pat1MatiMeri"
      },
      "effectivePeriod": {
        "start": "2024-02-27"
      },
      "reason": [
        {
          "concept": {
            "coding": [
              {
                "system": "http://fhir.ee/CodeSystem/rhk-10",
                "code": "E11.3",
                "display": "Insuliinisõltumatu suhkurtõbi silmatüsistusega"
              }
            ]
          }
        }
      ],
      "dosage": [
        {
          "patientInstruction": "süstida kõhunaha alla",
          "timing": {
            "repeat": {
              "frequency": 3,
              "period": 1,
              "periodUnit": "d",
              "timeOfDay": [
                "09:00:00",
                "15:00:00",
                "20:00:00"
              ]
            }
          },
          "doseAndRate": [
            {
              "doseQuantity": {
                "value": 12,
                "system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
                "code": "TY"
              }
            }
          ]
        }
      ]
    },
    {
      "resourceType": "PractitionerRole",
      "id": "PractitionerRole-N11243",
      "meta": {
        "profile": [
          "https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
        ]
      },
      "active": true,
      "practitioner": {
        "identifier": {
          "system": "https://fhir.ee/sid/pro/est/pho",
          "value": "N11243"
        },
        "display": "Firstname Lastname"
      },
      "organization": {
        "identifier": {
          "system": "https://fhir.ee/sid/org/est/br",
          "value": "11242172"
        },
        "display": "Aktsiaselts Ida-Tallinna Keskhaigla"
      },
      "code": [
        {
          "coding": [
            {
              "system": "http://terminology.hl7.org/CodeSystem/practitioner-role",
              "code": "doctor",
              "display": "Doctor"
            }
          ]
        }
      ],
      "specialty": [
        {
          "coding": [
            {
              "system": "https://fhir.ee/CodeSystem/ee-medre-specialty",
              "code": "E130",
              "display": "E130-display"
            }
          ]
        }
      ],
      "contact": [
        {
          "telecom": [
            {
              "system": "email",
              "value": "test@example.com"
            },
            {
              "system": "phone",
              "value": "37256789012"
            }
          ]
        }
      ]
    },
    {
      "resourceType": "Parameters",
      "id": "output-params",
      "meta": {
        "profile": [
          "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-task-response-parameters"
        ]
      },
      "parameter": [
        {
          "name": "insuranceParameter",
          "valueBoolean": true
        },
        {
          "name": "insuranceEUParameter",
          "valueBoolean": false
        },
        {
          "name": "oldAgePensionParameter",
          "valueBoolean": false
        },
        {
          "name": "incapacityForWorkPensionParameter",
          "valueBoolean": false
        },
        {
          "name": "reimbursementRateParameter",
          "valueCodeableConcept": {
            "coding": [
              {
                "system": "https://fhir.ee/CodeSystem/retsepti-soodustuse-maar",
                "code": "75",
                "display": "75%"
              }
            ],
            "text": "II tüüpi diabeedi raviks kombinatsioonis metformiiniga rasvumusega patsientidele (KMI>=35kg/m2), kellel suukaudsed diabeediravimid (metformiin, sulfonüüluurea preparaat, PPAR agonist, DPP-4 inhibiitor) maksimaalsetes talutavates annustes ei ole andnu"
          }
        },
        {
          "name": "reimbursementRateParameter",
          "valueCodeableConcept": {
            "coding": [
              {
                "system": "https://fhir.ee/CodeSystem/retsepti-soodustuse-maar",
                "code": "50",
                "display": "50%"
              }
            ],
            "text": "II tüüpi diabeedi raviks kombinatsioonis metformiiniga juhul kui ravi suukaudsete diabeediravimitega ei ole efektiivne või on vastunäidustatud"
          }
        },
        {
          "name": "reimbursementRateParameter",
          "valueCodeableConcept": {
            "coding": [
              {
                "system": "https://fhir.ee/CodeSystem/retsepti-soodustuse-maar",
                "code": "0",
                "display": "0%"
              }
            ]
          }
        }
      ]
    }
  ],
  "status": "requested",
  "intent": "proposal",
  "priority": "routine",
  "focus": {
    "reference": "#input-statement"
  },
  "output": [
    {
      "valueReference": {
        "reference": "#output-params"
      }
    }
  ]
}
```