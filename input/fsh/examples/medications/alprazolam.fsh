Instance: alprazolam
InstanceOf: Medication
Usage: #example
Description: "Description of medication alprazoleme"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-epc"
* language = #et
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
* extension[=].valueCodeableConcept = $atc-ee#N05BA12 "alprasolaam"
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
//* extension[=].valueCodeableConcept.text = "psyhhotroopne"
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-size-of-item"
//* extension[=].valueQuantity = 1 https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik#MG
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name"
* extension[=].valueString = "Xanax XR"
* identifier.system = "https://fhir.ee/tis-fhir-identifikaatorid/ravimiregister-pakend"
* identifier.value = "1021857"
* doseForm = $ravimvormid#1224 "toimeainet prolongeeritult vabastav tablett"
* totalVolume.value = 30
* ingredient.item.concept = $toimeained#11707 "alprasolaam"
* ingredient.isActive = true
* ingredient.strengthRatio.numerator = 1 $retsept-mahu-ja-massiyhik#MG
* ingredient.strengthRatio.denominator = 1 $retsept-mahu-ja-massiyhik#TABL