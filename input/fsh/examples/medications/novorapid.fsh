Instance: novorapid
InstanceOf: Medication
Usage: #example
Description: "Description of medication aspart-insulin"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-epc"
* language = #et
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
* extension[=].valueCodeableConcept = $atc-ee#J01CE02 "fenoksümetüülpenitsilliin"
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-size-of-item"
//* extension[=].valueQuantity = 1000000 $retsept-mahu-ja-massiyhik#RÜ
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name"
* extension[=].valueString = "Novorapid Flexpen"
* identifier.system = "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/ravimiregister-pakend"
* identifier.value = "123456"
* doseForm = $ravimvormid#1256 "Õhukese polümeerikattega tablett"
* totalVolume.value = 12
* ingredient.item.concept = $toimeained#11470 "fenoksümetüülpenitsilliin"
* ingredient.isActive = true
* ingredient.strengthRatio.numerator = 1000000 $retsept-mahu-ja-massiyhik#RÜ
* ingredient.strengthRatio.denominator = 1 $retsept-mahu-ja-massiyhik#TABL