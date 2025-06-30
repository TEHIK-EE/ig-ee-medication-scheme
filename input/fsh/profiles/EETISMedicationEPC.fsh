Profile: EETISMedicationEPC
Parent: Medication
Id: ee-tis-medication-epc
Description: "Ravim. Medication resource as it is presented today in Estonian e-Prescription center (Retseptikeskus). Used on prescriptions NOT on dispensations."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-14T14:34:42.5909877+00:00"
* ^publisher = "TEHIK"
* ^contact[0].name = "TEHIK"
* ^contact[=].telecom[0].system = #url
* ^contact[=].telecom[=].value = "https://www.tehik.ee"
* ^contact[=].telecom[+].system = #email
* ^contact[=].telecom[=].value = "fhir@tehik.ee"
* ^jurisdiction = urn:iso:std:iso:3166#EE "Estonia"
* meta.versionId ^example.label = "versionId"
* meta.versionId ^example.valueId = "1"
//* extension ^slicing.ordered = false
// * extension ^slicing.rules = #open
* extension contains
    ExtensionEETISMedicinalProductClassification named atc 1..1 and
//    ExtensionEETISMedicinalProductClassification named narcotic 0..1 and - hetkel seda ei kasuta, sest pole CS ega VS aga vajadusel saame sisse lylitada. Siia alla saab lisda ka käsimyygi ja retseptiravimite eristamise.
    ExtensionEETISSizeOfItem named sizeOfItem 0..1 and
    ExtensionEETISMedicinalProductName named name 0..1
// * extension[atc].valueCodeableConcept from $atc-ee (required) 
// * extension[narcotic] ^short = "This classification is for expressing whether the medication is narcotic/psychotropic"     
* identifier 1..*
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system" //oli system
* identifier ^slicing.rules = #open
* identifier ^short = "Package code when medication is prescribed based on specific package"
* identifier ^definition = "Pakendi kood (pakendipõhisel retseptil)"
* identifier contains
    packageNumber 0..1 and
    prescriptionNumber 0..1
* identifier[packageNumber].system from https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/ravimiregister-pakend (preferred)
* identifier[packageNumber] ^binding.description = "kui on pakendipõhine retsept siis grupeerivaks tunnuseks on pakendi number"
* identifier[prescriptionNumber].system from https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept (preferred)
* identifier[prescriptionNumber] ^binding.description = "kui on vaja grupeerida retsepti numbrite alusel"
* code ..0
* status ..0
* marketingAuthorizationHolder ..0
* doseForm 1..
* doseForm from $ravimvormid-VS (preferred)
//* doseForm.coding from $ravimvormid (preferred)
//* doseForm.coding ^binding.description = "Ravimvormide loend"
* doseForm ^short = "Dose form of the medication. E.g powder, tablet, ointment etc."
* doseForm ^definition = "Väljakirjutatud ravimi ravimvorm (loendist). Nt. pulber, tablett, salv jne"
* totalVolume 1..
* totalVolume ^short = "If the certain medication (brand name) is chosen then total volume is the amount of medication in package. If based on just active ingredient then total volume is same as in MedicationStatement TotalPrescribedAmount."
* totalVolume ^definition = "Kui preparaat ON määratud, siis on ravimite hulk pakendis. Kui preparaat EI ole määratud, siis on see kogu välja kirjutatud hulk (ehk võrdne MedicationStatement extension andmetega)."
* totalVolume only SimpleQuantity
* totalVolume.value 1..
* totalVolume.value ^short = "Total volume of medication."
* totalVolume.value ^definition = "Ühikute koguhulk. Ainult number, nt 100"
* totalVolume.unit ..0
* totalVolume.code ^short = "Unit for total volume"
* totalVolume.code ^definition = "Ühikute koguhulga ühik"
* ingredient 1..
* ingredient.item from $toimeained-VS (preferred)
* ingredient.item ^short = "Active ingredient from Ravimiregister value set"
* ingredient.item ^definition = "Toimeaine loendist. Ravimiregistri loend"
//* ingredient.item.concept ^binding.description = "Toimeainete loend. Ravimiregistri loend"
//* ingredient.item.reference ..0
* ingredient.isActive 1..
* ingredient.isActive.value = true
* ingredient.strength[x] only Ratio
* ingredient.strengthRatio 1..
//* ingredient.strengthRatio only Ratio
//* ingredient.strengthRatio ^sliceName = "strengthRatio"
* ingredient.strengthRatio ^short = "Strenght ratio of the active ingredient"
* ingredient.strengthRatio ^definition = "Toimeaine tugevus"
* batch ..0
* definition ..0