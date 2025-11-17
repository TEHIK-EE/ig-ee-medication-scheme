Instance: adrenaline-renal-function
InstanceOf: Medication
Usage: #example
Description: "Description of medication adrenaline used as an input when validating medications affecting renal function"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-renal-function"
* language = #et
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
* extension[=].valueCodeableConcept = $atc-ee#C01CA24 "Epinefriin"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name"
* extension[=].valueString = "Adrenaline auxilia"
* identifier.system = $ravimiregister-pakend
* identifier.value = "3018563"
* doseForm = $ravimvormid#739 "süstelahus"
* ingredient.item.concept = $toimeained#8554 "epinefriin"
* ingredient.isActive = true
* ingredient.strengthRatio.numerator = 1 $retsept-mahu-ja-massiyhik#MG
* ingredient.strengthRatio.denominator = 1 $retsept-mahu-ja-massiyhik#ML