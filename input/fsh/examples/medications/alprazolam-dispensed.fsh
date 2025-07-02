Instance: alprazolam-dispensed
InstanceOf: Medication
Usage: #example
Description: "Description of medication alprazoleme for dispensation to patient"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-dispensed-to-patient"
* language = #et
//* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
//* extension[=].valueCodeableConcept = $atc-ee#N05BA12 "alprasolaam"
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
//* extension[=].valueCodeableConcept.text = "psyhhotroopne"
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-size-of-item"
//* extension[=].valueQuantity = 1 https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik#MG
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name"
* extension[=].valueString = "Xanax XR"
* identifier[0].system = $ravimiregister-pakend
* identifier[0].value = "1021857"