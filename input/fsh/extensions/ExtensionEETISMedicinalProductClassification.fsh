Extension: ExtensionEETISMedicinalProductClassification
Id: ee-tis-medicinal-product-classification
Description: "Klassifikatsioon. Classification of the product, e.g. ATC."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-15T06:15:37.9998371+00:00"
* ^publisher = "TEHIK"
* ^contact[0].name = "TEHIK"
* ^contact[=].telecom[0].system = #url
* ^contact[=].telecom[=].value = "https://www.tehik.ee"
* ^contact[=].telecom[+].system = #email
* ^contact[=].telecom[=].value = "fhir@tehik.ee"
* ^jurisdiction = urn:iso:std:iso:3166#EE "Estonia"
* ^context.type = #element
* ^context.expression = "Medication"
* . ^short = "Classifications of the product, e.g ATC, narcotic/psychotropic, orphan drug, etc."
* value[x] only CodeableConcept
//* value[x] ^slicing.discriminator.type = #type
//* value[x] ^slicing.discriminator.path = "$this"
//* value[x] ^slicing.rules = #open
//* valueCodeableConcept only CodeableConcept
//* valueCodeableConcept ^sliceName = "valueCodeableConcept"
* valueCodeableConcept ^short = "Medication classified according to some defined system."
* valueCodeableConcept ^definition = "Ravimi klassifikatsioon"
//* valueCodeableConcept ^binding.description = "ATC"
//* valueCodeableConcept.coding from $atc (preferred)
//* valueCodeableConcept.coding ^definition = "ATC. \r\n\r\nA reference to a code defined by a terminology system."
//* valueCodeableConcept.coding ^binding.description = "ATC"