Instance: dexamethason
InstanceOf: Medication
Usage: #example
Description: "Description of medication dexamethasone"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-epc"
* language = #et
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
* extension[=].valueCodeableConcept = $atc-ee#H02AB02 "deksametasoon"
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-size-of-item"
//* extension[=].valueQuantity = 4 $retsept-mahu-ja-massiyhik#MG
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name"
* extension[=].valueString = "Nodexon"
* identifier.system = "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/ravimiregister-pakend"
* identifier.value = "123456"
* doseForm = $ravimvormid#738 "tablett"
* totalVolume.value = 20
* ingredient.item.concept = $toimeained#8510 "deksametasoon"
* ingredient.isActive = true

* ingredient.strengthRatio.numerator = 4 $retsept-mahu-ja-massiyhik#MG
* ingredient.strengthRatio.denominator = 1 $retsept-mahu-ja-massiyhik#TABL