Instance: N98765
InstanceOf: Practitioner
Usage: #example
Description: "Practitioner, Nurse Õde Laura"
* meta.profile = "https://fhir.ee/base/StructureDefinition/ee-practitioner"
* language = #et
* identifier[0].system = $medre
* identifier[=].value = "N98765"
* identifier[+].system = "https://fhir.ee/sid/pid/est/ni"
* identifier[=].value = "49806307018"
* active = true
* name.family = "Õde"
* name.given = "Laura"
* qualification.code = $v2-0360#PN "Advanced Practice Nurse"