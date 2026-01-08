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

# Ärireeglid
- Server ei loe siin kohustuslikuks muud kui toimeainete ja ravimvormi andmestikku
- vt ka Otsustutoe integratsiooni puhul andmete mappingut: MedIN Otsustustoe integratsioon
- päringute kohta salvestatakse statistika vt MedIN Statistika#1.Neerufunktsioonip%C3%A4ringutestatistika, kuid statistika salvestamise õnnestumine/ebaõnnestumine ei mõjuta muid tehtavaid tegevusi

# Teenuse äriloogika
skeem

## Patsiendi vanuse kontroll
Esmalt tehakse patsiendil vanuse kontroll, kui patsient on noorem kui 18a, hoiatusi ei pärita ega tagastata, töö katkeb ning tagastatakse (mis teade?)

## Toimeainete leidmine
Järgmises sammus leitakse otsusetoe sisendi jaoks toimeained, seda tehakse vastavalt sisendile, kas: 
- sisendisse ette antud ravimi andmetega
- või kõikide patsiendi kehtivas ravimiskeemis leitud ravimi andmetega

## Patsiendi eGFR näidu pärimine ja loogika
Analüüside pärimiseks kasutatakse MedIN Blaze integratsioon 

Päringu vastusena saadakse üks Observation ressurss EETISObservationEGFR

**Patsiendi näit on suurem või võrdne 90**
Juhul kui patsiendi eGFR näit on suurem või võrdne 90-ga siis töö katkeb, tagastatakse Bundle, kus sees pole ühtegi ClinicalUseDefinition ning patsiendi analüüsi Observation ressurss märkega Observation.status = "final"
 *Selgitus: juhul kui patsiendi eGFR näit on suurem või võrdne 90-ga, on tegemist patsiendiga, kellel ei ole neerufunktsiooni puudulikkust ning kellele ei ole ka korrektne kuvada neerufn hoiatusi*

**Patsiendi analüüsi aegumise loogika**
igale eGFR näidule leitakse kuupäev järgmiselt:
- analüüsi tegemise/proovi võtmise kp (collected) -> analüüs kinnitamise kp (effective) -> dokumendi kp (documentReference)
- ehk esmalt proovitakse leida analüüsi tegemise kuupäeva, kui seda ei leita, liigutakse järgmisesse sammu ja nii edasi
Saadud patsiendi eGFR näit läbib järgmise loogika:

(suurem või võrdne 90 näidu puhul aegumist ei ole)
väiksem kui 90...60 - aegumine 365 päeva
59..45 - aegumine 180 päeva
44..30 - aegumine 120 päeva
29..15 - aegumine 120 päeva
vähem kui 15 - aegumine 90 päeva

Juhul kui teenusest saadud kõige viimane näit on äriloogika kohaselt aegunud, siis kasutatakse seda edasises protsessis AGA märgitakse see kontrollperioodist väljas olevaks ehk Observation.status = "unknown"

Sama loogika käivitub juhul kui ühelegi saadud analüüsi tulemusele ei leita kuupäeva.

Juhul kui näit ei ole aegunud, märgitakse Observation.status = "final"

**Patsiendi analüüsi ei leita**
Juhul kui ühtegi eGFR näitu ei leita, liigutakse edasi järgmisesse sammu ilma eGFR näiduta

## Otsustustoelt andmete pärimine
Otsustustoele tehakse päring vastavalt eelmises sammus saadud eGFR tulemusega või ilma selleta.

**NB!** Juhul kui eGFR tulemust kaasa ei panda, pannakse Otsustustoe sisendisse kaasa iga ravimi ATC kood, et hilisemas sammus ATC-põhist linki saada.

Andmed päritakse MedIN Otsustustoe integratsioon kaudu, iga toimeaine kohta leitakse kuni üks hoiatus, hoiatused filtreeritakse selliselt, et alles jääksid ainult C/D tasemega hoiatused.

## Väljundisse saadetavate tulemuste loogika
Kui kui C/D taseme hoiatusi jäi alles, tehakse otsus vastavalt eelnevalt saadud tulemustele:
- Juhul kui patsiendi eGFR näit oli kontrollperioodis, lisatakse väljundisse leitud hoiatused ning kehtiv patsiendi analüüsi Observation ressurss, päringu vastuse Bundle sisse. Analüüsi Observation ressursile viitavad kõik ClinicalUseDefinition ressursid.
- Juhul kui patsiendi eGFR näit oli kontrollperioodist väljas, siis lisatakse väljundisse leitud hoiatused ning aluseks võetud patsiendi analüüsi Observation ressurss (koos märkega, Observation.status=unknown), päringu vastuse Bundle sisse. Analüüsi Observation ressursile viitavad kõik ClinicalUseDefinition ressursid.
- Juhul kui patsiendil ei leitud ühtegi eGFR tulemust, lisatakse väljundisse
    - Observation ressurss, millel on täidetud ainult status=unknown ja dataAbsentReason=not-performed 
    - hoiatused grupeeritakse ravimipõhisteks ning nendes täidetakse ainult ClinicalUseDefinition.contained atribuut (aluseks olnud Medication-ga) ning extension, kus on ATC-põhine link ravimi artiklile
- Juhul kui C/D taseme hoiatusi peale filtreerimist alles ei jää, tagastatakse Bundle, kus sees pole ühtegi ClinicalUseDefinition, patsiendi eGFR lisatakse vastavalt eelnevalt kirjeldatud loogikale

## Näited
Näide on tehtud olukorrale, kus antakse kaasa nii patsiendi viide kui ka lisatav ravim.
Näidispäring nii patsiendi kui ka ette antud ravimiga
```
{
  "resourceType": "Parameters",
  "parameter": [
    {
      "name": "subject",
      "valueReference": {
        "reference": "Patient/{{patient_mpi}}"
      }
    },
    {
      "name": "input",
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
                  "code": "M01AE01",
                  "system": "https://fhir.ee/CodeSystem/atc-ee"
                }
              ]
            }
          },
          {
            "url": "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name",
            "valueString": "IBUMAX"
          }
        ],
        "identifier": [
          {
            "value": "1073012",
            "system": "http://ravimiregister.ee/pakendid"
          }
        ],
        "doseForm": {
          "coding": [
            {
              "code": "1256",
              "system": "https://fhir.ee/CodeSystem/ravimvormid",
              "display": "õhukese polümeerikattega tablett"
            }
          ]
        },
        "totalVolume": {
          "code": "TK",
          "value": 100,
          "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik"
        },
        "ingredient": [
          {
            "item": {
              "concept": {
                "coding": [
                  {
                    "code": "9210",
                    "system": "https://fhir.ee/CodeSystem/toimeained",
                    "display": "ibuprofeen"
                  }
                ]
              }
            },
            "isActive": true,
            "strengthRatio": {
              "numerator": {
                "code": "MG",
                "value": 400,
                "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik"
              },
              "denominator": {
                "code": "TK",
                "value": 1,
                "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik"
              }
            }
          }
        ]
      }
    },
    {
      "name": "input",
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
                  "code": "C09DA84",
                  "system": "https://fhir.ee/CodeSystem/atc-ee"
                }
              ]
            }
          },
          {
            "url": "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name",
            "valueString": "CANOCOMBI"
          }
        ],
        "doseForm": {
          "coding": [
            {
              "code": "738",
              "system": "https://fhir.ee/CodeSystem/ravimvormid",
              "display": "tablett"
            }
          ]
        },
        "totalVolume": {
          "code": "TK",
          "value": 30,
          "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik"
        },
        "ingredient": [
          {
            "item": {
              "concept": {
                "coding": [
                  {
                    "code": "10591",
                    "system": "https://fhir.ee/CodeSystem/toimeained",
                    "display": "kandesartaan"
                  }
                ]
              }
            },
            "isActive": true,
            "strengthRatio": {
              "numerator": {
                "code": "MG",
                "value": 32,
                "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik"
              },
              "denominator": {
                "code": "TK",
                "value": 1,
                "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik"
              }
            }
          },
          {
            "item": {
              "concept": {
                "coding": [
                  {
                    "code": "10447",
                    "system": "https://fhir.ee/CodeSystem/toimeained",
                    "display": "hüdroklorotiasiid"
                  }
                ]
              }
            },
            "isActive": true,
            "strengthRatio": {
              "numerator": {
                "code": "MG",
                "value": 25,
                "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik"
              },
              "denominator": {
                "code": "TK",
                "value": 1,
                "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik"
              }
            }
          }
        ]
      }
    }
  ]
}
```

Näidis-väljund olukorras, kus patsiendil on kontroll-perioodist väljas eGFR ja hoiatused

```
Näidisvastus kontrollperioodist väljas eGFR ja hoiatustega
tulekul
```

Näidis-väljund olukorras, kus patsiendil ei ole eGFR 

```
Näidisvastus ilma eGFR-ta patsiendile
tulekul
```