Instance: metformin
InstanceOf: Medication
Usage: #example
Description: "Description of medication metformin"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-epc"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
* extension[=].valueCodeableConcept = $atc-ee#A10BA02 "metformiin"
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-size-of-item"
//* extension[=].valueQuantity = 500 $retsept-mahu-ja-massiyhik#MG
* doseForm = $ravimvormid#1518 "tablett+õhukese polümeerikattega tablett"
* totalVolume.value = 120
* ingredient.item.concept = $toimeained#11354 "metformiin"
* ingredient.isActive = true
* ingredient.strengthRatio.numerator = 500 $retsept-mahu-ja-massiyhik#MG
* ingredient.strengthRatio.denominator = 1 $retsept-mahu-ja-massiyhik#TABL