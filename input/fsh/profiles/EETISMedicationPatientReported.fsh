/*Parent: Medication
Id: ee-tis-medication-patient-reported
Description: "Patsiendi sõnul ravim. Medication resource for the representation of food supplements etc as patient reports them to healthcare professional."
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
    ExtensionEETISMedicinalProductName named name 0..1
// * extension[atc].valueCodeableConcept from $atc-ee (required) 
// * extension[narcotic] ^short = "This classification is for expressing whether the medication is narcotic/psychotropic"     
* identifier 0..*
* identifier ^short = "Identifier of the food supplement"
* identifier ^definition = "Toidulisandi/eritoidu identifikaator"
* code 0..1
* code ^short = "Type of food supplement"
* code ^definition = "Toidulisand/eritoit. OMA LOEND?!?"
* status ..0
* marketingAuthorizationHolder ..0
* ingredient ..0
* batch ..0
* definition ..0
*/