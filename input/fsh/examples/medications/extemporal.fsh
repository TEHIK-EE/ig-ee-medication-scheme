Instance: extemporal
InstanceOf: Medication
Usage: #example
Description: "Extemporal medication example of sulfur ointment"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-extemporal"
//* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
//* extension[=].valueCodeableConcept = $atc-ee#C01CA24 "Epinefriin"
// * extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
// * extension[=].valueCodeableConcept.text = "psyhhotroopne" //meelega vale katsetuse mõttes//
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-size-of-item"
//* extension[=].valueQuantity = 1 $retsept-mahu-ja-massiyhik#ML
//* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name"
//* extension[=].valueString = "Adrenaliin"
* doseForm = $ravimvormid#789 "salv"
* totalVolume.value = 100
* ingredient.item.concept.text = "Rp
Sulfuris praecipitati 33,0
Adipis suilli ad 100,0
M. f. ung.
D. S. "
//* ingredient.isActive = true
//* ingredient.strengthRatio.numerator = 1 $retsept-mahu-ja-massiyhik#MG
//* ingredient.strengthRatio.denominator = 1 $retsept-mahu-ja-massiyhik#ML