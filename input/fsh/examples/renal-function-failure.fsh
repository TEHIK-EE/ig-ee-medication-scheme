Instance: renal-function-failure
InstanceOf: ClinicalUseDefinition
Usage: #example
Description: "Example of a alert when medication affects renal function and dosage must be corrected" 
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-renal-failure-ds"
* language = #et
* status = #active
* contained = metformin
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-affected-medication-statements"
* extension[=].valueReference = Reference(MedicationStatement-metformin)
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-additional-information-link"
* extension[=].valueString = "www.synbase.ee/metformin-neerufunktsioon"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-nephrotoxic"
* extension[=].valueBoolean = false 
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-dosage-modification"
* extension[=].extension[0].url = "dosageIntervalMin"
* extension[=].extension[=].valueQuantity.value = 6
* extension[=].extension[+].url = "dosageIntervalMax"
* extension[=].extension[=].valueQuantity.value = 12
* extension[=].extension[+].url = "recommendation"
* extension[=].extension[=].valueString = "Siin on soovitused"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-related-observation-or-condition"
* extension[=].valueReference = Reference(observation-egfr1)
* type = #undesirable-effect
//* category.coding[drugFormGroup] empty
//* category[drugFormGroup] = {}
//* category[drugFormGroup].coding = FixedDrugFormGroupCoding
* category[0].coding.code = #2
* category[=].coding.display = "süsteemne"
* category[=].coding.system = "https://fhir.ee/drug-form-group"
* category[=].text = "Kirjeldus siia text alla. kui on veel vaja midagi lisada"
//* category.coding[failureDegree] empty
//* category[failureDegree] = {}
//* category[failureDegree].coding = FixedFailureDegreeCoding
* category[+].coding.code = #1
* category[=].coding.system = "https://fhir.ee/failure-degree"
* category[=].text = "GFR 30-59 ml/min (mõõdukas neerupuudulikkus)"
//* category.coding[additionalInformation] empty
//* category[additionalInformation] = {}
//* category[additionalInformation].coding = FixedAdditionalInformationCoding
//* category[+].coding.display = "additional information. bla bla bla. siia võib ka igast asju lisada"
* category[+].coding.system = "https://fhir.ee/additional-information"
* category[=].text = "Kuna vosoritiidi ohutust ja efektiivsust neerukahjustuse korral ei ole hinnatud [(1)],[(2)], ei saa tõenduspõhiseid soovitusi anda. Siiski, tuginedes eliminatsioonimehhanismile, ei mõjuta neerupuudulikkus ilmselt vosoritiidi farmakokineetikat. Vosoritiid on modifitseeritud C-tüüpi natriureetiline peptiid. Vosoritiidi metabolism toimub eeldatavasti kataboolsete radade kaudu ja laguneb väikesteks peptiidideks ja aminohapeteks [(1)], [(2)]."
* subject.reference = "#metformin"
//* subject.identifier.valueIdentifier = "11354"
* undesirableEffect.classification.text = "Annust või annustamise vahemikku tuleb kohandada"
* undesirableEffect.classification.coding.code = #C
* undesirableEffect.classification.coding.system = "https://fhir.ee/synbase-warning-classification"
//* undesirableEffect.symptomConditionEffect.reference = Reference(observation-definition1)
