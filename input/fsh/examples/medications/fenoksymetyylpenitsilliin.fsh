Instance: fenoksymetyylpenitsilliin
InstanceOf: Medication
Usage: #example
Description: "Description of medication phenoxymethylpenicillin"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-epc"
* language = #et
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
* extension[=].valueCodeableConcept = $atc-ee#J01CE02 "fenoksümetüülpenitsilliin"
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-size-of-item"
//* extension[=].valueQuantity = 1000000 $retsept-mahu-ja-massiyhik#RÜ
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name"
* extension[=].valueString = "Ospen"
* doseForm = $ravimvormid#1256 "Õhukese polümeerikattega tablett"
* totalVolume.value = 12
* ingredient.item.concept = $toimeained#11470 "fenoksümetüülpenitsilliin"
* ingredient.isActive = true
* ingredient.strengthRatio.numerator = 1000000 $retsept-mahu-ja-massiyhik#RÜ
* ingredient.strengthRatio.denominator = 1 $retsept-mahu-ja-massiyhik#TABL
// viidatud retseptilt, kus asendamine pole lubatud. Peaks olema ka pakendikood.