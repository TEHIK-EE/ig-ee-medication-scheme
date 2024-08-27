Instance: D12345
InstanceOf: Practitioner
Usage: #example
Description: "Practitioner, Doctor Mart Murakas"
* meta.profile = "https://fhir.ee/base/StructureDefinition/ee-practitioner"
* identifier[0].system = $medre
* identifier[=].value = "D12345"
* identifier[+].system = "https://fhir.ee/sid/pid/est/ni"
* identifier[=].value = "35006080229"
* active = true
* name.family = "Murakas"
* name.given = "Mart"