Instance: D98765
InstanceOf: Practitioner
Usage: #example
Description: "Practitioner, Doctor Arst Ly"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-practitioner"
* language = #et
* identifier[0].system = $medre
* identifier[=].value = "D98765"
* identifier[+].system = "https://fhir.ee/sid/pid/est/ni"
* identifier[=].value = "489050599952"
* active = true
* name.family = "Arst"
* name.given = "Ly"