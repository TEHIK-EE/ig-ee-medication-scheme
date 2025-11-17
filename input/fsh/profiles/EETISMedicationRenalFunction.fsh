Profile: EETISMedicationRenalFunction
Parent: Medication
Id: ee-tis-medication-renal-function
Description: "Ravim neerufunktsiooni päringu sisendis. Medication resource for input when validating renal function."
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
* extension contains
    ExtensionEETISMedicinalProductClassification named atc 1..1 and
    ExtensionEETISMedicinalProductName named name 0..1
* identifier 0..*
* identifier ^short = "Package code when medication is prescribed based on specific package. ATC is found in extension."
* identifier ^definition = "Pakendi kood (pakendipõhisel retseptil)."
* identifier.system = $ravimiregister-pakend //(exactly) //võtsin systemi katseks ära
* identifier.system 1..
* code ..0
* status ..0
* marketingAuthorizationHolder ..0
* doseForm 1..
* doseForm from $ravimvormid-VS (preferred)
* doseForm ^short = "Dose form of the medication. E.g powder, tablet, ointment etc."
* doseForm ^definition = "Väljakirjutatud ravimi ravimvorm (loendist). Nt. pulber, tablett, salv jne"
* totalVolume 0..1
* ingredient 1..
* ingredient.item from $toimeained-VS (preferred)
* ingredient.item ^short = "Active ingredient from Ravimiregister value set"
* ingredient.item ^definition = "Toimeaine loendist. Ravimiregistri loend"
* ingredient.isActive 1..
* ingredient.isActive.value = true
* ingredient.strength[x] only Ratio
* ingredient.strengthRatio 1..
* ingredient.strengthRatio ^short = "Strenght ratio of the active ingredient"
* ingredient.strengthRatio ^definition = "Toimeaine tugevus"
* batch ..0
* definition ..0