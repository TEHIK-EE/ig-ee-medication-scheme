## Ärireeglid:
Patsiendi hetkel kehtiva, kinnitatud ravimiskeemi pärimiseks mõeldud operation, koosneb mitmest järjestikku tehtavast tegevusest:

<div>
<img src="rsparimine.svg"  alt="Kinnitatud ravimiskeemi pärimine - üldine protsess" width="80%">
<p>Kinnitatud ravimiskeemi pärimine - üldine protsess</p>
<p></p>
</div>

### FHIR andmete leidmine
Leiab patsiendi MPI viite alusel viimase kinnitamise fakti ([EETISMedicationList]) ning sellega seotud ravimiskeemi read
filtreerib välja need MedicationStatement'd, millel on määratud effective.end (need on ka märgitud List.entry.flag = ceased) JA need MedicationStatement-d, millel on märgitud List.entry.flag = consolidated ehk read, mis on kokku grupeeritud
tagastab nii kinnitamise fakti (List), MedicationStatement'd kui ka Medication'd.

### Retseptikeskusest FHIR seoste alusel retseptide pärimine

<div>
<img src="rsparimine2.svg"  alt="Retseptikeskusest FHIR seoste alusel retseptide pärimine" width="80%">
<p>Retseptikeskusest FHIR seoste alusel retseptide pärimine</p>
<p></p>
</div>

- teeb päringud Retseptikeskusesse (vt Ravimiskeemiga seotud retseptide päring)
- leiab Ravimiskeemi ridadega seotud retspetid:
    - päritakse kogu info - ehk üldinfo, määratud ravi, isikud, väljastatud (vt ka RETS - API kirjeldus), mh ei välistata annulleeritud retsepte
    - päritakse ainult ID alusel
- genereerib RK andmetest MedicationRequest ning MedicationDispense ja sellega seotud Medication FHIR ressurssid (vt Ravimiskeemiga seotud retseptide retseptide vastus ning arvutatakse ravimi jääk vastavalt Jäägi arvutamise loogika.

### Retseptikeskusest ravimiskeemi väliselt tekkinud kehtivate retseptide pärimine

<div>
<img src="rsparimine3.svg"  alt="Retseptikeskusest ravimiskeemi väliselt tekkinud kehtivate retseptide pärimine" width="80%">
<p>Retseptikeskusest ravimiskeemi väliselt tekkinud kehtivate retseptide pärimine</p>
<p></p>
</div>

- teeb päringud Retseptikeskusesse (vt Ravimiskeemi väliselt loodud retseptide päring )
- leiab Ravimiskeemi väliselt loodud retseptid:
    - päritakse viimasest FHIR kinnitamisest alates VÕI **viimased 540p** (kui kinnitamisi ei ole)
    - päritakse kogu info - ehk üldinfo, määratud ravi, isikud, väljastatud (vt ka RETS - API kirjeldus)
    - päritakse ainult kehtivad retseptid, st staatustes:
        - 00 Koostatud
        - 10 Müüdud
        - 20 Broneeritud apteegis
        - 30 Broneeritud operaatori poolt
    - NB! Välistatud on meditsiiniseadme retseptid, ekstemporaalsed retseptid ja ilma ATC koodita retseptid (eritoidud)
- genereerib RK andmetest MedicationRequest ja sellega seotud Medication ning MedicationDispense ja omakorda sellega seotud Medication FHIR ressurssid, lisaks genereerib nende alusel seotud FHIR MedicationStatement ressursid (kas enam on nii?) ( Ravimiskeemi väliselt loodud retseptide vastus ), arvutab ravimi jäägi vastavalt Jäägi arvutamise loogika.

### Kogu saadud andmestikule grupeerimisloogika rakendamine
- Rakendab saadud FHIR andmetele ning Retseptikeskusest saadud andmetele [Grupeerimise loogika](grouping.html) ravimiskeemis reeglid
- Lühikirjeldusena:
    - leitakse andmetes grupeeritavad ravimiskeemi andmed
    - iga grupi sees leitakse
        - kas on FHIR andmeid juba oelmas
        - mis on kõige hilisem kirje
    - Juhul kui FHIR andmeid esineb, võetakse need aluseks ning täiendatakse hilisemate andmetega
        - sellisel juhul jäetakse leitud FHIR ressursside ID-d samaks ning juhul kui andmeid täiendatakse, on alati tagastatud **List.entry.flag = generated**, näitamaks, et FHIR andmetes olevat seisu on grupeerimisel muudetud
    - Juhul kui FHIR andmeid ei leidu, genereeritakse otse Retseptikeskuse andmetest MedicationStatement
        - sellisel juhul on **List.entry.flag = unchanged**, põhjenduseks on asjaolu, et andmed on Retseptikeskusesse eelnevalt lisatud ning neid kuvatakse siin välja
    - Kõik ülejäänud grupi andmed seotakse kokku läbi ExtensionEETISGroupedItems
- Lõpptulemusena on Ravimiskeemis liigsed kordused eemaldatud ja korduvad andmed seoste abil kokku viidud

### Retseptikeskusest viimati tühistatud retseptide pärimine

<div>
<img src="rsparimine3.svg"  alt="Retseptikeskusest viimati tühistatud retseptide pärimine" width="80%">
<p>Retseptikeskusest viimati tühistatud retseptide pärimine</p>
<p></p>
</div>

- teeb päringud Retseptikeskusesse (vt Viimati tühistatud retseptide päring )
- leiab Ravimiskeemi väliselt tühistatud retseptid
    - päritakse viimased 540p (või päritakse siin ka 180p?) 
        - *Selgitus: päringu parameetritesse ei ole võimalik sisse anda annulleerimise aega või muudatuste aega, saab otsida ainult koostamise aja järgi. Sisuliselt huvitavad meid tühistamised alates viimasest FHIR kinnitamisest, kuid seda on võimalik saada ainult kõiki annulleeritud retsepte pärides ja leides sealt annulleerimise kuupäeva järgi vajalikud andmed.*
    - päritakse ainult üldinfo, patsiendi andmed ja tühistaja andmed (vt ka RETS - API kirjeldus)
- Järjestab tühistatud retseptid viimase muutmise aja järgi, leides kõige hilisema muutmise ajaga retsepti
- **NB!** edasine andmete töötlus on järgmises punktis - siit andmeid väljundisse ei lähe!

### Viimase kinnitamise leidmine ja andmete sinna alla viimine
- Võrdleb ravimiskeemi väliselt loodud retsepte, viimati tühistatud retsepte ja FHIR andmetest leitud viimast kinnitamist ning leiab nendest kõige hilisema
    - Juhul kui RK andmed on hilisemad kui FHIR andmetest leitud kinnitamine (Ravimiskeemi väliselt loodud retspetide koostamise aeg VÕI viimati tühistatud retspetide annulleerimise aeg) siis:
        - genereerib retseptikeskuse andmete põhjal List resssursi (vt Kinnitamise fakti loomine retseptide põhjal)  ja asendab FHIR andmetest leitud kinnitamise sellega, välja arvatud ravimiskeemi üldkommentaar (List.note), mis kopeeritakse FHIR andmetest, juhul kui FHIR andmetes on see täidetud
        - kõik leitud andmed - nii FHIR andmed kui ka RK andmete pealt loodud MedicationStatement'd - seotakse loodud List-ga
        - kõikide entry'te flag'd märgitakse "unchanged" väärtusega v.a. see MedicationStatement, mille põhjal List tehti 
            - *Selgitus: kuna List tähistab kinnitamise fakti, siis ainus mida kinnitati on RK andmete retsept - kas siis loomine või annulleerimine - ning sisuliselt on korrektne öelda, et teised andmed on unchanged*
    - **NB!** Juhul kui RK andmetest ei leita hilisemaid andmeid kui FHIR, ei lisata viimati tühistatud retseptidest andmeid väljundisse

## Näited
**NB!** Vt ka grupeerimise loogikas välja toodud Detailsed ärireeglid ning stsenaariumid

**Näidispäring patsiendi viitega**
```
GET /MedicationStatement/$confirmed-medication-scheme?subject=Patient/94465
```
**Näidisvastus**
```
 Kinnitatud ravimiskeemi pärimine näidisvastus
 {
	"resourceType": "Bundle",
	"type": "collection",
	"total": 3,
	"entry": [
		{
			"resource": {
				"resourceType": "List",
				"meta": {
					"profile": [
						"https://fhir.ee/StructureDefinition/ee-tis-medication-list"
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
							"identifier": {
								"system": "https://fhir.ee/sid/pro/est/pho",
								"value": "D10358"
							},
							"display": "JANNE NETGROUP"
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
										"system": "https://fhir.ee/CodeSystem/erialad",
										"code": "E110",
										"display": "dermatoveneroloogia"
									}
								]
							}
						],
						"contact": [
							{
								"telecom": [
									{
										"system": "email",
										"value": "dem@misp.ee"
									},
									{
										"system": "phone",
										"value": "55112119"
									}
								]
							}
						]
					}
				],
				"identifier": [
					{
						"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
						"value": "2018876206"
					}
				],
				"status": "current",
				"mode": "snapshot",
				"title": "Ravimiskeem",
				"subject": [
					{
						"reference": "Patient/5378"
					}
				],
				"date": "2025-09-30T12:23:35+03:00",
				"source": {
					"reference": "#med-statement-kinnitaja",
					"display": "JANNE NETGROUP"
				},
				"note": [
					{
						"authorString": "JANNE NETGROUP, dermatoveneroloogia, endokrinoloogia, infektsioonhaigused, pediaatria",
						"time": "2025-09-02T11:07:14+03:00",
						"text": "Endokrinoloog lisas ibuprofeeni"
					}
				],
				"entry": [
					{
						"flag": {
							"coding": [
								{
									"system": "https://fhir.ee/CodeSystem/ravimiskeemi-rea-muutuse-tyyp-grupeerimisel",
									"code": "07",
									"display": "Generated"
								}
							]
						},
						"date": "2025-09-30",
						"item": {
							"reference": "MedicationStatement/3028/_history/1"
						}
					},
					{
						"flag": {
							"coding": [
								{
									"system": "urn:oid:1.2.36.1.2001.1001.101.104.16592",
									"code": "01",
									"display": "Unchanged"
								}
							]
						},
						"date": "2025-09-02",
						"item": {
							"identifier": {
								"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
								"value": "1018875539"
							}
						}
					},
					{
						"flag": {
							"coding": [
								{
									"system": "urn:oid:1.2.36.1.2001.1001.101.104.16592",
									"code": "01",
									"display": "Unchanged"
								}
							]
						},
						"date": "2025-08-22",
						"item": {
							"reference": "MedicationStatement/2872/_history/1"
						}
					}
				]
			}
		},
		{
			"fullUrl": "https://fhir.ee/MedicationStatement/3028",
			"resource": {
				"resourceType": "MedicationStatement",
				"id": "3028",
				"meta": {
					"versionId": "1",
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
							"identifier": {
								"system": "https://fhir.ee/sid/pro/est/pho",
								"value": "D10358"
							},
							"display": "JANNE NETGROUP"
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
										"system": "https://fhir.ee/CodeSystem/erialad",
										"code": "E110",
										"display": "dermatoveneroloogia"
									}
								]
							}
						],
						"contact": [
							{
								"telecom": [
									{
										"system": "email",
										"value": "dem@misp.ee"
									},
									{
										"system": "phone",
										"value": "55112119"
									}
								]
							}
						]
					}
				],
				"extension": [
					{
						"extension": [
							{
								"url": "substitutionAllowed",
								"valueBoolean": false
							},
							{
								"url": "substitutionAllowedReason",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/ravimi-asendamatuse-pohjus",
											"code": "KP09",
											"display": "tegemist on müügiloata/erisoodustusega ravimiga"
										}
									]
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-substitution"
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
						"valueQuantity": {
							"value": 20,
							"system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
							"code": "TK"
						}
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-intent",
						"valueCode": "order"
					},
					{
						"extension": [
							{
								"url": "reimbursementRate",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/retsepti-soodustuse-maar",
											"code": "000",
											"display": "0%"
										}
									]
								}
							},
							{
								"url": "reimbursementSpeciality",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/erialad",
											"code": "E110",
											"display": "dermatoveneroloogia"
										}
									]
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time",
						"valueDateTime": "2026-01-26T02:00:00+02:00"
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization",
						"valueCodeableConcept": {
							"coding": [
								{
									"system": "https://fhir.ee/CodeSystem/retsepti-volituse-liik",
									"code": "public",
									"display": "Avalik"
								}
							]
						}
					},
					{
						"extension": [
							{
								"url": "verificationTime",
								"valueDateTime": "2025-09-30T12:23:35+03:00"
							},
							{
								"url": "verificationAuthor",
								"valueReference": {
									"identifier": {
										"system": "https://fhir.ee/sid/pro/est/pho",
										"value": "D10358"
									},
									"display": "JANNE NETGROUP, dermatoveneroloogia"
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
					},
					{
						"extension": [
							{
								"url": "groupingIdentifier",
								"valueIdentifier": {
									"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
									"value": "2018876206"
								}
							},
							{
								"url": "groupingIdentifier",
								"valueIdentifier": {
									"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
									"value": "1018876206"
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-grouped-items"
					},
					{
						"extension": [
							{
								"url": "daysAvailable",
								"valueInteger": 99
							},
							{
								"url": "daysDispensed",
								"valueInteger": 0
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-medication-remainder"
					},
					{
						"extension": [
							{
								"url": "verificationTime",
								"valueDateTime": "2025-09-02T11:07:14+03:00"
							},
							{
								"url": "verificationAuthor",
								"valueReference": {
									"identifier": {
										"system": "https://fhir.ee/sid/pro/est/pho",
										"value": "D10358"
									},
									"display": "JANNE NETGROUP, dermatoveneroloogia, endokrinoloogia, infektsioonhaigused, pediaatria"
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
					}
				],
				"identifier": [
					{
						"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
						"value": "2018876206"
					}
				],
				"status": "recorded",
				"category": [
					{
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
								"code": "f",
								"display": "Fikseeritud"
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
								"code": "1",
								"display": "Tavaretsept"
							}
						]
					},
					{
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/retsepti-kordsus",
								"code": "2",
								"display": "2-kordne"
							}
						]
					}
				],
				"medication": {
					"reference": {
						"reference": "urn:uuid:10b6c6d5-369a-4f90-966f-9cdde798b493"
					}
				},
				"subject": {
					"reference": "Patient/5378"
				},
				"effectivePeriod": {
					"start": "2025-09-30T12:23:35+03:00"
				},
				"dateAsserted": "2025-09-30T12:23:35+03:00",
				"informationSource": [
					{
						"reference": "#med-statement-kinnitaja"
					}
				],
				"derivedFrom": [
					{
						"identifier": {
							"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
							"value": "1018875538"
						}
					}
				],
				"reason": [
					{
						"concept": {
							"coding": [
								{
									"system": "https://fhir.ee/CodeSystem/rhk10",
									"code": "R52",
									"display": "Mujal klassifitseerimata valu"
								}
							],
							"text": "Mujal klassifitseerimata valu"
						}
					}
				],
				"dosage": [
					{
						"patientInstruction": "RKs loodud retsept",
						"timing": {
							"repeat": {
								"boundsDuration": {
									"value": 20,
									"unit": "d",
									"system": "http://unitsofmeasure.org",
									"code": "d"
								},
								"frequency": 1,
								"period": 1,
								"periodUnit": "d",
								"timeOfDay": [
									"08:00:00"
								]
							}
						},
						"doseAndRate": [
							{
								"doseQuantity": {
									"value": 2,
									"unit": "tükk",
									"system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
									"code": "TK"
								}
							}
						]
					}
				]
			}
		},
		{
			"fullUrl": "urn:uuid:10b6c6d5-369a-4f90-966f-9cdde798b493",
			"resource": {
				"resourceType": "Medication",
				"id": "urn:uuid:10b6c6d5-369a-4f90-966f-9cdde798b493",
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
									"system": "https://fhir.ee/CodeSystem/atc-ee",
									"code": "M01AE01",
									"display": "ibuprofeen"
								}
							]
						}
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name",
						"valueString": "IBUPROFEN ZENTIVA"
					}
				],
				"identifier": [
					{
						"system": "http://ravimiregister.ee/pakendid",
						"value": "1870422"
					},
					{
						"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
						"value": "2018876206"
					}
				],
				"doseForm": {
					"coding": [
						{
							"system": "https://fhir.ee/CodeSystem/ravimvormid",
							"code": "1256",
							"display": "õhukese polümeerikattega tablett"
						}
					]
				},
				"totalVolume": {
					"value": 10,
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
										"code": "9210",
										"display": "ibuprofeen"
									}
								]
							}
						},
						"isActive": true,
						"strengthRatio": {
							"numerator": {
								"value": 400,
								"system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
								"code": "MG"
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
			"fullUrl": "urn:uuid:b601fd56-69b1-4778-b2df-478c046ed0a3",
			"resource": {
				"resourceType": "Medication",
				"id": "urn:uuid:b601fd56-69b1-4778-b2df-478c046ed0a3",
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
									"system": "https://fhir.ee/CodeSystem/atc-ee",
									"code": "M01AE01",
									"display": "ibuprofeen"
								}
							]
						}
					}
				],
				"doseForm": {
					"coding": [
						{
							"system": "https://fhir.ee/CodeSystem/ravimvormid",
							"code": "1256",
							"display": "õhukese polümeerikattega tablett"
						}
					]
				},
				"totalVolume": {
					"value": 100,
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
										"code": "9210",
										"display": "ibuprofeen"
									}
								]
							}
						},
						"isActive": true,
						"strengthRatio": {
							"numerator": {
								"value": 400,
								"system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
								"code": "MG"
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
			"resource": {
				"resourceType": "MedicationRequest",
				"extension": [
					{
						"extension": [
							{
								"url": "reimbursementRate",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/retsepti-soodustuse-maar",
											"code": "050",
											"display": "50%"
										}
									]
								}
							},
							{
								"url": "reimbursementSpeciality",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/erialad",
											"code": "E120",
											"display": "endokrinoloogia"
										}
									]
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization",
						"valueCodeableConcept": {
							"coding": [
								{
									"system": "https://fhir.ee/CodeSystem/retsepti-volituse-liik",
									"code": "public",
									"display": "Avalik"
								}
							]
						}
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
						"valueQuantity": {
							"value": 100,
							"system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
							"code": "TK"
						}
					}
				],
				"identifier": [
					{
						"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
						"value": "1018875538"
					}
				],
				"status": "active",
				"statusChanged": "2025-09-02T11:07:13+03:00",
				"intent": "order",
				"category": [
					{
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/retsepti-liik",
								"code": "1",
								"display": "Tavaretsept"
							}
						]
					},
					{
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/retsepti-kordsus",
								"code": "1",
								"display": "1-kordne"
							}
						]
					}
				],
				"medication": {
					"reference": {
						"reference": "urn:uuid:b601fd56-69b1-4778-b2df-478c046ed0a3"
					}
				},
				"subject": {
					"reference": "Patient/5378"
				},
				"authoredOn": "2025-09-02T11:07:13+03:00",
				"requester": {
					"identifier": {
						"system": "https://fhir.ee/sid/pro/est/pho",
						"value": "D10358"
					},
					"display": "JANNE NETGROUP, endokrinoloogia"
				},
				"reason": [
					{
						"concept": {
							"coding": [
								{
									"system": "https://fhir.ee/CodeSystem/rhk10",
									"code": "R51",
									"display": "Peavalu"
								}
							],
							"text": "Peavalu"
						}
					}
				],
				"courseOfTherapyType": {
					"coding": [
						{
							"system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
							"code": "v",
							"display": "Vajadusel"
						}
					]
				},
				"dosageInstruction": [
					{
						"doseAndRate": [
							{
								"doseQuantity": {
									"value": 1,
									"unit": "tablett",
									"system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
									"code": "TA"
								}
							}
						]
					}
				],
				"dispenseRequest": {
					"validityPeriod": {
						"start": "2025-09-02T11:07:13+03:00",
						"end": "2025-10-30T02:00:00+02:00"
					}
				}
			}
		},
		{
			"resource": {
				"resourceType": "MedicationRequest",
				"extension": [
					{
						"extension": [
							{
								"url": "reimbursementRate",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/retsepti-soodustuse-maar",
											"code": "000",
											"display": "0%"
										}
									]
								}
							},
							{
								"url": "reimbursementSpeciality",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/erialad",
											"code": "E110",
											"display": "dermatoveneroloogia"
										}
									]
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization",
						"valueCodeableConcept": {
							"coding": [
								{
									"system": "https://fhir.ee/CodeSystem/retsepti-volituse-liik",
									"code": "public",
									"display": "Avalik"
								}
							]
						}
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
						"valueQuantity": {
							"value": 20,
							"system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
							"code": "TK"
						}
					}
				],
				"identifier": [
					{
						"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
						"value": "1018876206"
					}
				],
				"status": "active",
				"statusChanged": "2025-09-30T12:23:35+03:00",
				"intent": "order",
				"category": [
					{
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/retsepti-liik",
								"code": "1",
								"display": "Tavaretsept"
							}
						]
					},
					{
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/retsepti-kordsus",
								"code": "2",
								"display": "2-kordne"
							}
						]
					}
				],
				"medication": {
					"reference": {
						"reference": "urn:uuid:10b6c6d5-369a-4f90-966f-9cdde798b493"
					}
				},
				"subject": {
					"reference": "Patient/5378"
				},
				"authoredOn": "2025-09-30T12:23:35+03:00",
				"requester": {
					"identifier": {
						"system": "https://fhir.ee/sid/pro/est/pho",
						"value": "D10358"
					},
					"display": "JANNE NETGROUP, dermatoveneroloogia"
				},
				"reason": [
					{
						"concept": {
							"coding": [
								{
									"system": "https://fhir.ee/CodeSystem/rhk10",
									"code": "R52",
									"display": "Mujal klassifitseerimata valu"
								}
							],
							"text": "Mujal klassifitseerimata valu"
						}
					}
				],
				"courseOfTherapyType": {
					"coding": [
						{
							"system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
							"code": "f",
							"display": "Fikseeritud"
						}
					]
				},
				"dosageInstruction": [
					{
						"timing": {
							"repeat": {
								"boundsDuration": {
									"value": 20,
									"unit": "d",
									"system": "http://unitsofmeasure.org",
									"code": "d"
								},
								"frequency": 1,
								"period": 1,
								"periodUnit": "d",
								"timeOfDay": [
									"08:00:00"
								]
							}
						},
						"doseAndRate": [
							{
								"doseQuantity": {
									"value": 2,
									"unit": "tükk",
									"system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
									"code": "TK"
								}
							}
						]
					}
				],
				"dispenseRequest": {
					"validityPeriod": {
						"start": "2025-09-30T12:23:35+03:00",
						"end": "2026-01-26T02:00:00+02:00"
					}
				},
				"substitution": {
					"allowedBoolean": false,
					"reason": {
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/ravimi-asendamatuse-pohjus",
								"code": "KP09",
								"display": "tegemist on müügiloata/erisoodustusega ravimiga"
							}
						]
					}
				}
			}
		},
		{
			"resource": {
				"resourceType": "MedicationRequest",
				"extension": [
					{
						"extension": [
							{
								"url": "reimbursementRate",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/retsepti-soodustuse-maar",
											"code": "000",
											"display": "0%"
										}
									]
								}
							},
							{
								"url": "reimbursementSpeciality",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/erialad",
											"code": "E110",
											"display": "dermatoveneroloogia"
										}
									]
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization",
						"valueCodeableConcept": {
							"coding": [
								{
									"system": "https://fhir.ee/CodeSystem/retsepti-volituse-liik",
									"code": "public",
									"display": "Avalik"
								}
							]
						}
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
						"valueQuantity": {
							"value": 20,
							"system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
							"code": "TK"
						}
					}
				],
				"identifier": [
					{
						"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
						"value": "2018876206"
					}
				],
				"status": "active",
				"statusChanged": "2025-09-30T12:23:35+03:00",
				"intent": "order",
				"category": [
					{
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/retsepti-liik",
								"code": "1",
								"display": "Tavaretsept"
							}
						]
					},
					{
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/retsepti-kordsus",
								"code": "2",
								"display": "2-kordne"
							}
						]
					}
				],
				"medication": {
					"reference": {
						"reference": "urn:uuid:10b6c6d5-369a-4f90-966f-9cdde798b493"
					}
				},
				"subject": {
					"reference": "Patient/5378"
				},
				"authoredOn": "2025-09-30T12:23:35+03:00",
				"requester": {
					"identifier": {
						"system": "https://fhir.ee/sid/pro/est/pho",
						"value": "D10358"
					},
					"display": "JANNE NETGROUP, dermatoveneroloogia"
				},
				"reason": [
					{
						"concept": {
							"coding": [
								{
									"system": "https://fhir.ee/CodeSystem/rhk10",
									"code": "R52",
									"display": "Mujal klassifitseerimata valu"
								}
							],
							"text": "Mujal klassifitseerimata valu"
						}
					}
				],
				"courseOfTherapyType": {
					"coding": [
						{
							"system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
							"code": "f",
							"display": "Fikseeritud"
						}
					]
				},
				"dosageInstruction": [
					{
						"timing": {
							"repeat": {
								"boundsDuration": {
									"value": 20,
									"unit": "d",
									"system": "http://unitsofmeasure.org",
									"code": "d"
								},
								"frequency": 1,
								"period": 1,
								"periodUnit": "d",
								"timeOfDay": [
									"08:00:00"
								]
							}
						},
						"doseAndRate": [
							{
								"doseQuantity": {
									"value": 2,
									"unit": "tükk",
									"system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
									"code": "TK"
								}
							}
						]
					}
				],
				"dispenseRequest": {
					"validityPeriod": {
						"start": "2025-09-30T12:23:35+03:00",
						"end": "2026-01-26T02:00:00+02:00"
					}
				},
				"substitution": {
					"allowedBoolean": false,
					"reason": {
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/ravimi-asendamatuse-pohjus",
								"code": "KP09",
								"display": "tegemist on müügiloata/erisoodustusega ravimiga"
							}
						]
					}
				}
			}
		},
		{
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
							"identifier": {
								"system": "https://fhir.ee/sid/pro/est/pho",
								"value": "D10358"
							},
							"display": "JANNE NETGROUP"
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
										"system": "https://fhir.ee/CodeSystem/erialad",
										"code": "E290",
										"display": "pediaatria"
									}
								]
							}
						],
						"contact": [
							{
								"telecom": [
									{
										"system": "email",
										"value": "pediaater@misp.ee"
									},
									{
										"system": "phone",
										"value": "55112119"
									}
								]
							}
						]
					}
				],
				"extension": [
					{
						"extension": [
							{
								"url": "substitutionAllowed",
								"valueBoolean": false
							},
							{
								"url": "substitutionAllowedReason",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/ravimi-asendamatuse-pohjus",
											"code": "KP05",
											"display": "patsiendile on paremini talutav konkreetne ravim, mille toimekestus erineb kõigist teistest sama toimeainega ja ravimvormis ravimitest"
										}
									]
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-substitution"
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
						"valueQuantity": {
							"value": 10,
							"system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
							"code": "TK"
						}
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-intent",
						"valueCode": "order"
					},
					{
						"extension": [
							{
								"url": "reimbursementRate",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/retsepti-soodustuse-maar",
											"code": "000",
											"display": "0%"
										}
									]
								}
							},
							{
								"url": "reimbursementSpeciality",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/erialad",
											"code": "E290",
											"display": "pediaatria"
										}
									]
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time",
						"valueDateTime": "2025-10-30T02:00:00+02:00"
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization",
						"valueCodeableConcept": {
							"coding": [
								{
									"system": "https://fhir.ee/CodeSystem/retsepti-volituse-liik",
									"code": "public",
									"display": "Avalik"
								}
							]
						}
					},
					{
						"extension": [
							{
								"url": "verificationTime",
								"valueDateTime": "2025-09-02T11:08:09+03:00"
							},
							{
								"url": "verificationAuthor",
								"valueReference": {
									"identifier": {
										"system": "https://fhir.ee/sid/pro/est/pho",
										"value": "D10358"
									},
									"display": "JANNE NETGROUP, pediaatria"
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
					},
					{
						"extension": [
							{
								"url": "daysAvailable",
								"valueInteger": 70
							},
							{
								"url": "daysDispensed",
								"valueInteger": 0
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-medication-remainder"
					},
					{
						"extension": [
							{
								"url": "groupingIdentifier",
								"valueIdentifier": {
									"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
									"value": "1018875539"
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-grouped-items"
					}
				],
				"identifier": [
					{
						"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
						"value": "1018875539"
					}
				],
				"status": "recorded",
				"category": [
					{
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
								"code": "p",
								"display": "Pidev"
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
								"code": "1",
								"display": "Tavaretsept"
							}
						]
					},
					{
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/retsepti-kordsus",
								"code": "1",
								"display": "1-kordne"
							}
						]
					}
				],
				"medication": {
					"reference": {
						"reference": "urn:uuid:4cba93cf-4203-4dd1-8c52-8bb9714b0b1e"
					}
				},
				"subject": {
					"reference": "Patient/5378"
				},
				"effectivePeriod": {
					"start": "2025-09-02T11:08:09+03:00"
				},
				"dateAsserted": "2025-09-02T11:08:09+03:00",
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
									"code": "R52",
									"display": "Mujal klassifitseerimata valu"
								}
							],
							"text": "Mujal klassifitseerimata valu"
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
						"doseAndRate": [
							{
								"doseQuantity": {
									"value": 1,
									"unit": "tablett",
									"system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
									"code": "TA"
								}
							}
						]
					}
				]
			}
		},
		{
			"fullUrl": "urn:uuid:4cba93cf-4203-4dd1-8c52-8bb9714b0b1e",
			"resource": {
				"resourceType": "Medication",
				"id": "urn:uuid:4cba93cf-4203-4dd1-8c52-8bb9714b0b1e",
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
									"system": "https://fhir.ee/CodeSystem/atc-ee",
									"code": "M01AE01",
									"display": "ibuprofeen"
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
						"system": "http://ravimiregister.ee/pakendid",
						"value": "1012521"
					},
					{
						"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
						"value": "1018875539"
					}
				],
				"doseForm": {
					"coding": [
						{
							"system": "https://fhir.ee/CodeSystem/ravimvormid",
							"code": "1256",
							"display": "õhukese polümeerikattega tablett"
						}
					]
				},
				"totalVolume": {
					"value": 10,
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
										"code": "9210",
										"display": "ibuprofeen"
									}
								]
							}
						},
						"isActive": true,
						"strengthRatio": {
							"numerator": {
								"value": 600,
								"system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
								"code": "MG"
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
			"resource": {
				"resourceType": "MedicationRequest",
				"extension": [
					{
						"extension": [
							{
								"url": "reimbursementRate",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/retsepti-soodustuse-maar",
											"code": "000",
											"display": "0%"
										}
									]
								}
							},
							{
								"url": "reimbursementSpeciality",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/erialad",
											"code": "E290",
											"display": "pediaatria"
										}
									]
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization",
						"valueCodeableConcept": {
							"coding": [
								{
									"system": "https://fhir.ee/CodeSystem/retsepti-volituse-liik",
									"code": "public",
									"display": "Avalik"
								}
							]
						}
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
						"valueQuantity": {
							"value": 10,
							"system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
							"code": "TK"
						}
					}
				],
				"identifier": [
					{
						"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
						"value": "1018875539"
					}
				],
				"status": "active",
				"statusChanged": "2025-09-02T11:08:09+03:00",
				"intent": "order",
				"category": [
					{
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/retsepti-liik",
								"code": "1",
								"display": "Tavaretsept"
							}
						]
					},
					{
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/retsepti-kordsus",
								"code": "1",
								"display": "1-kordne"
							}
						]
					}
				],
				"medication": {
					"reference": {
						"reference": "urn:uuid:4cba93cf-4203-4dd1-8c52-8bb9714b0b1e"
					}
				},
				"subject": {
					"reference": "Patient/5378"
				},
				"authoredOn": "2025-09-02T11:08:09+03:00",
				"requester": {
					"identifier": {
						"system": "https://fhir.ee/sid/pro/est/pho",
						"value": "D10358"
					},
					"display": "JANNE NETGROUP, pediaatria"
				},
				"reason": [
					{
						"concept": {
							"coding": [
								{
									"system": "https://fhir.ee/CodeSystem/rhk10",
									"code": "R52",
									"display": "Mujal klassifitseerimata valu"
								}
							],
							"text": "Mujal klassifitseerimata valu"
						}
					}
				],
				"courseOfTherapyType": {
					"coding": [
						{
							"system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
							"code": "p",
							"display": "Pidev"
						}
					]
				},
				"dosageInstruction": [
					{
						"timing": {
							"repeat": {
								"frequency": 1,
								"period": 1,
								"periodUnit": "wk"
							}
						},
						"doseAndRate": [
							{
								"doseQuantity": {
									"value": 1,
									"unit": "tablett",
									"system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
									"code": "TA"
								}
							}
						]
					}
				],
				"dispenseRequest": {
					"validityPeriod": {
						"start": "2025-09-02T11:08:09+03:00",
						"end": "2025-10-30T02:00:00+02:00"
					}
				},
				"substitution": {
					"allowedBoolean": false,
					"reason": {
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/ravimi-asendamatuse-pohjus",
								"code": "KP05",
								"display": "patsiendile on paremini talutav konkreetne ravim, mille toimekestus erineb kõigist teistest sama toimeainega ja ravimvormis ravimitest"
							}
						]
					}
				}
			}
		},
		{
			"fullUrl": "https://fhir.ee/MedicationStatement/2872",
			"resource": {
				"resourceType": "MedicationStatement",
				"id": "2872",
				"meta": {
					"versionId": "1",
					"lastUpdated": "2025-08-22T09:20:38+03:00",
					"profile": [
						"https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
					]
				},
				"contained": [
					{
						"resourceType": "PractitionerRole",
						"id": "PractitionerRole-D10358",
						"meta": {
							"profile": [
								"https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
							]
						},
						"active": true,
						"practitioner": {
							"identifier": {
								"system": "https://fhir.ee/sid/pro/est/pho",
								"value": "D10358"
							},
							"display": "JANNE NETGROUP"
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
										"system": "https://fhir.ee/CodeSystem/eriala",
										"code": "E160",
										"display": "infektsioonhaigused"
									}
								]
							}
						]
					}
				],
				"extension": [
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time",
						"valueDateTime": "2025-10-21T03:00:00+03:00"
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
						"valueQuantity": {
							"value": 90,
							"system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
							"code": "TK"
						}
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization",
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
								"valueBoolean": false
							},
							{
								"url": "substitutionAllowedReason",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/ravimi-asendamatuse-pohjus",
											"code": "KP05"
										}
									]
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-substitution"
					},
					{
						"extension": [
							{
								"url": "reimbursementRate",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/retsepti-soodustuse-maar",
											"code": "050"
										}
									]
								}
							},
							{
								"url": "reimbursementCondition",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/ravimi-soodustuse-vajalikud-tingimused",
											"code": "50_1"
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
								"valueDateTime": "2025-08-22T09:20:40+03:00"
							},
							{
								"url": "verificationAuthor",
								"valueReference": {
									"identifier": {
										"system": "https://fhir.ee/sid/pro/est/pho",
										"value": "D10358"
									},
									"display": "JANNE NETGROUP, dermatoveneroloogia, endokrinoloogia, infektsioonhaigused, pediaatria"
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
					},
					{
						"extension": [
							{
								"url": "daysAvailable",
								"valueInteger": 60
							},
							{
								"url": "daysDispensed",
								"valueInteger": 0
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-medication-remainder"
					}
				],
				"status": "recorded",
				"category": [
					{
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
								"code": "v"
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
						"reference": "Medication/2871"
					}
				},
				"subject": {
					"reference": "Patient/5378"
				},
				"effectivePeriod": {
					"start": "2025-08-22T09:20:34+03:00"
				},
				"dateAsserted": "2025-08-22T09:20:36+03:00",
				"informationSource": [
					{
						"reference": "#PractitionerRole-D10358",
						"display": "JANNE NETGROUP"
					}
				],
				"derivedFrom": [
					{
						"identifier": {
							"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
							"value": "1018875309"
						}
					}
				],
				"reason": [
					{
						"concept": {
							"coding": [
								{
									"system": "https://fhir.ee/CodeSystem/rhk10",
									"code": "E88"
								}
							],
							"text": "Muud ainevahetushäired"
						}
					}
				],
				"dosage": [
					{
						"route": {
							"text": "suukaudne"
						},
						"doseAndRate": [
							{
								"doseQuantity": {
									"value": 3,
									"unit": "tükk",
									"system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
									"code": "TK"
								}
							}
						]
					}
				]
			}
		},
		{
			"fullUrl": "https://fhir.ee/Medication/2871",
			"resource": {
				"resourceType": "Medication",
				"id": "2871",
				"meta": {
					"versionId": "1",
					"lastUpdated": "2025-08-22T09:20:38+03:00",
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
									"system": "https://fhir.ee/CodeSystem/atc-ee",
									"code": "C10AA05"
								}
							]
						}
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name",
						"valueString": "SORTIS 80 MG"
					}
				],
				"identifier": [
					{
						"system": "http://ravimiregister.ee/pakendid",
						"value": "1124996"
					}
				],
				"doseForm": {
					"coding": [
						{
							"system": "https://fhir.ee/CodeSystem/ravimvormid",
							"code": "1256",
							"display": "õhukese polümeerikattega tablett"
						}
					]
				},
				"totalVolume": {
					"value": 30,
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
										"code": "11945",
										"display": "atorvastatiin"
									}
								]
							}
						},
						"isActive": true,
						"strengthRatio": {
							"numerator": {
								"value": 80,
								"system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
								"code": "MG"
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
			"fullUrl": "urn:uuid:957d3e5a-ada7-4787-8387-ef0677b474db",
			"resource": {
				"resourceType": "Medication",
				"id": "urn:uuid:957d3e5a-ada7-4787-8387-ef0677b474db",
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
									"system": "https://fhir.ee/CodeSystem/atc-ee",
									"code": "C10AA05",
									"display": "atorvastatiin"
								}
							]
						}
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name",
						"valueString": "SORTIS 80 MG"
					}
				],
				"identifier": [
					{
						"system": "http://ravimiregister.ee/pakendid",
						"value": "1124996"
					}
				],
				"doseForm": {
					"coding": [
						{
							"system": "https://fhir.ee/CodeSystem/ravimvormid",
							"code": "1256",
							"display": "õhukese polümeerikattega tablett"
						}
					]
				},
				"totalVolume": {
					"value": 30,
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
										"code": "11945",
										"display": "atorvastatiin"
									}
								]
							}
						},
						"isActive": true,
						"strengthRatio": {
							"numerator": {
								"value": 80,
								"system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
								"code": "MG"
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
			"resource": {
				"resourceType": "MedicationRequest",
				"extension": [
					{
						"extension": [
							{
								"url": "reimbursementRate",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/retsepti-soodustuse-maar",
											"code": "050",
											"display": "50%"
										}
									]
								}
							},
							{
								"url": "reimbursementSpeciality",
								"valueCodeableConcept": {
									"coding": [
										{
											"system": "https://fhir.ee/CodeSystem/erialad",
											"code": "E110",
											"display": "dermatoveneroloogia"
										}
									]
								}
							}
						],
						"url": "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization",
						"valueCodeableConcept": {
							"coding": [
								{
									"system": "https://fhir.ee/CodeSystem/retsepti-volituse-liik",
									"code": "public",
									"display": "Avalik"
								}
							]
						}
					},
					{
						"url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
						"valueQuantity": {
							"value": 90,
							"system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
							"code": "TK"
						}
					}
				],
				"identifier": [
					{
						"system": "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept",
						"value": "1018875309"
					}
				],
				"status": "active",
				"statusChanged": "2025-08-22T09:20:40+03:00",
				"intent": "order",
				"category": [
					{
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/retsepti-liik",
								"code": "1",
								"display": "Tavaretsept"
							}
						]
					},
					{
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/retsepti-kordsus",
								"code": "1",
								"display": "1-kordne"
							}
						]
					}
				],
				"medication": {
					"reference": {
						"reference": "urn:uuid:957d3e5a-ada7-4787-8387-ef0677b474db"
					}
				},
				"subject": {
					"reference": "Patient/5378"
				},
				"authoredOn": "2025-08-22T09:20:40+03:00",
				"requester": {
					"identifier": {
						"system": "https://fhir.ee/sid/pro/est/pho",
						"value": "D10358"
					},
					"display": "JANNE NETGROUP, dermatoveneroloogia"
				},
				"reason": [
					{
						"concept": {
							"coding": [
								{
									"system": "https://fhir.ee/CodeSystem/rhk10",
									"code": "E88",
									"display": "Muud ainevahetushäired"
								}
							],
							"text": "Muud ainevahetushäired"
						}
					}
				],
				"courseOfTherapyType": {
					"coding": [
						{
							"system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
							"code": "v",
							"display": "Vajadusel"
						}
					]
				},
				"dosageInstruction": [
					{
						"doseAndRate": [
							{
								"doseQuantity": {
									"value": 3,
									"unit": "tükk",
									"system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
									"code": "TK"
								}
							}
						]
					}
				],
				"dispenseRequest": {
					"validityPeriod": {
						"start": "2025-08-22T09:20:40+03:00",
						"end": "2025-10-20T03:00:00+03:00"
					}
				},
				"substitution": {
					"allowedBoolean": false,
					"reason": {
						"coding": [
							{
								"system": "https://fhir.ee/CodeSystem/ravimi-asendamatuse-pohjus",
								"code": "KP05",
								"display": "patsiendile on paremini talutav konkreetne ravim, mille toimekestus erineb kõigist teistest sama toimeainega ja ravimvormis ravimitest"
							}
						]
					}
				}
			}
		}
	]
}
``` 
