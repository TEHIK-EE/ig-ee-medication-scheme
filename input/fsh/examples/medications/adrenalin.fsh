Instance: adrenalin
InstanceOf: Medication
Usage: #example
Description: "Description of medication adrenaline"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-epc"
* language = #et
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
* extension[=].valueCodeableConcept = $atc-ee#C01CA24 "Epinefriin"
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
//* extension[=].valueCodeableConcept = $ravikuuri-tyyp#P "Pidev" //vale koodisüsteem testimiseks
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-size-of-item"
* extension[=].valueQuantity = 1 $retsept-mahu-ja-massiyhik#ML
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name"
* extension[=].valueString = "Adrenaliin"
* doseForm = $ravimvormid#739 "süstelahus"
* totalVolume.value = 5
* ingredient.item.concept = $toimeained#8554 "epinefriin"
* ingredient.isActive = true
* ingredient.strengthRatio.numerator = 1 $retsept-mahu-ja-massiyhik#MG
* ingredient.strengthRatio.denominator = 1 $retsept-mahu-ja-massiyhik#ML