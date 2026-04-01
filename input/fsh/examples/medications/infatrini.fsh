Instance: infatrini
InstanceOf: Medication
Usage: #example
Description: "Description of medical nutrition INFATRINI"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-medical-nutrition"
* language = #et
//* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
//* extension[=].valueCodeableConcept = $atc-ee#C01CA24 "epinefriin"
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
//* extension[=].valueCodeableConcept = $ravikuuri-tyyp#P "Pidev" //vale koodisüsteem testimiseks
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-size-of-item"
* extension[=].valueQuantity = 125 $retsept-mahu-ja-massiyhik#ML
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name"
* extension[=].valueString = "INFATRINI"
* identifier[0].system = $ravimiregister-pakend
* identifier[0].value = "7017432"
* doseForm = $ravimvormid#795 "suukaudne suspensioon"
* totalVolume.value = 24
* ingredient.item.concept.text = "imikute toitesegu"
//* ingredient.isActive = true
//* ingredient.strengthRatio.numerator = 1 $retsept-mahu-ja-massiyhik#MG
//* ingredient.strengthRatio.denominator = 1 $retsept-mahu-ja-massiyhik#ML