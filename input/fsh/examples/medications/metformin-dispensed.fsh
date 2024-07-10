Instance: metformin-dispensed
InstanceOf: Medication
Usage: #example
Description: "Description of medication metformin dispensed to patient"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-dispensed-to-patient"
//* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
//* extension[=].valueCodeableConcept = $atc-ee#A10BA02 "metformiin"
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-size-of-item"
//* extension[=].valueQuantity = 500 $retsept-mahu-ja-massiyhik#MG
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name"
* extension[=].valueString = "METFORAL 500MG"
* identifier.system = "http://ravimiregister.ee/pakendid"
* identifier.value = "1064719"