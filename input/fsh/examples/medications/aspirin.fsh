Instance: aspirin
InstanceOf: Medication
Usage: #example
Description: "Description of medication Aspirin"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-epc"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
* extension[=].valueCodeableConcept = $atc-ee#B01AC06 "Atsetüülsalitsüülhape"
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
//* extension[=].valueCodeableConcept.text = "psyhhotroopne"
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-size-of-item"
//* extension[=].valueQuantity = 1 https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik#MG
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name"
* extension[=].valueString = "ASPIRIN CARDIO"
* identifier.system = "https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/ravimiregister-pakend"
* identifier.value = "1345687"
* doseForm = $ravimvormid#965 "gastroresistentne tablett"
* totalVolume.value = 98
* ingredient.item.concept = $toimeained#9773 "atsetüülsalitsüülhape"
* ingredient.isActive = true
* ingredient.strengthRatio.numerator = 1 $retsept-mahu-ja-massiyhik#MG
* ingredient.strengthRatio.denominator = 1 $retsept-mahu-ja-massiyhik#TABL