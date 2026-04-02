Instance: tsink-eritoit
InstanceOf: Medication
Usage: #example
Description: "Description of medical nutrition ICONFIT BIOAKTIIVNE TSINK "
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-medical-nutrition"
* language = #et
//* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
//* extension[=].valueCodeableConcept = $atc-ee#C01CA24 "epinefriin"
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
//* extension[=].valueCodeableConcept = $ravikuuri-tyyp#P "Pidev" //vale koodisüsteem testimiseks
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-size-of-item"
* extension[=].valueQuantity = 25 $retsept-mahu-ja-massiyhik#MG
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name"
* extension[=].valueString = "ICONFIT BIOAKTIIVNE TSINK "
* identifier[0].system = $ravimiregister-pakend
* identifier[0].value = "7018107"
* doseForm = $ravimvormid#1051 "kõvakapsel"
* totalVolume.value = 90
* ingredient.item.concept = $toimeained#12186 "tsink"
//* ingredient.isActive = true
//* ingredient.strengthRatio.numerator = 1 $retsept-mahu-ja-massiyhik#MG
//* ingredient.strengthRatio.denominator = 1 $retsept-mahu-ja-massiyhik#ML