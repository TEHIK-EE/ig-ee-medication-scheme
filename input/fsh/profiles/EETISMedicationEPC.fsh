Profile: EETISMedicationEPC
Parent: Medication
Id: ee-tis-medication-epc
Description: "Medication resource as it is presented today in Estonian e-Prescription center. Used on prescriptions and dispensations."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-14T14:34:42.5909877+00:00"
* ^publisher = "TEHIK"
* ^contact[0].name = "TEHIK"
* ^contact[=].telecom[0].system = #url
* ^contact[=].telecom[=].value = "https://www.tehik.ee"
* ^contact[=].telecom[+].system = #email
* ^contact[=].telecom[=].value = "fhir@tehik.ee"
//* ^contact[+].name = "Rutt Lindström"
//* ^contact[=].telecom.system = #email
//* ^contact[=].telecom.value = "rutt.lindstrom@tehik.ee"
//* ^contact[=].telecom.use = #work
* ^jurisdiction = urn:iso:std:iso:3166#EE "Estonia"
* meta.versionId ^example.label = "versionId"
* meta.versionId ^example.valueId = "1"
* meta.lastUpdated = "2024-02-13T09:25:49.780106+00:00"
//* extension ^slicing.ordered = false
// * extension ^slicing.rules = #open
* extension contains
    ExtensionEETISMedicinalProductClassification named atc 0..1 and
   // ExtensionEETISMedicinalProductClassification named narcotic 0..1 and
    ExtensionEETISSizeOfItem named sizeOfItem 0..1 and
    ExtensionEETISMedicinalProductName named name 0..1
// * extension[atc].valueCodeableConcept from $atc-ee (required) 
// * extension[narcotic] ^short = "This classification is for expressing whether the medication is narcotic/psychotropic"     
* identifier ..1
* identifier ^short = "Pakendi kood (pakendipõhisel retseptil)"
* code ..0
* status ..0
* marketingAuthorizationHolder ..0
* doseForm 1..
* doseForm from $ravimvormid-VS (preferred)
//* doseForm.coding from $ravimvormid (preferred)
//* doseForm.coding ^binding.description = "Ravimvormide loend"
* totalVolume 1..
* totalVolume only SimpleQuantity
* totalVolume.value 1..
* totalVolume.value ^short = "Ühikute koguhulk"
* totalVolume.unit ..0
* totalVolume.code ^short = "Ühikute koguhulga ühik"
* ingredient 1..
* ingredient.item from $toimeained-VS (preferred)
* ingredient.item ^short = "Toimeaine loendist"
//* ingredient.item.concept ^binding.description = "Toimeainete loend"
//* ingredient.item.reference ..0
* ingredient.isActive 1..
* ingredient.isActive.value = true
* ingredient.strength[x] only Ratio
* ingredient.strengthRatio 1..
//* ingredient.strengthRatio only Ratio
//* ingredient.strengthRatio ^sliceName = "strengthRatio"
* ingredient.strengthRatio ^short = "Toimeaine tugevus"
* batch ..0
* definition ..0