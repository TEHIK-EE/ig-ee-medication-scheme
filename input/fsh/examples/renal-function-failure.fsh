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
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-related-observation-or-conditions"
* extension[=].valueReference = Reference(EETISObservationEGFR)
* type = #undesirable-effect
//* category.coding[drugFormGroup] empty
//* category[drugFormGroup] = {}
//* category[drugFormGroup].coding = FixedDrugFormGroupCoding
* category[0].coding.display = "2, Systemic, süsteemne"
* category[0].text = "Kas panna kirjeldus display või texti alla"
//* category.coding[failureDegree] empty
//* category[failureDegree] = {}
//* category[failureDegree].coding = FixedFailureDegreeCoding
* category[1].coding.display = "failureDegree 1 - GFR 30-59 ml/min (mõõdukas neerupuudulikkus)"
* category[1].text = "Kas panna kirjeldus display või texti alla"
//* category.coding[additionalInformation] empty
//* category[additionalInformation] = {}
//* category[additionalInformation].coding = FixedAdditionalInformationCoding
* category[2].coding.display = "additional information. bla bla bla. siia võib ka igast asju lisada"
* category[0].text = "Kas panna kirjeldus display või texti alla"
* subject.reference = "#metformin"
//* subject.identifier.valueIdentifier = "11354"
* undesirableEffect.classification.text = "C, Annust või annustamise vahemikku tuleb kohandada"
//* undesirableEffect.symptomConditionEffect.reference = Reference(observation-definition1)
