Instance: pat1MatiMeri
InstanceOf: Patient
Usage: #example
Description: "Patient Mati Meri"
* meta.profile = "https://fhir.ee/base/StructureDefinition/ee-patient"
* identifier[0].system = "https://fhir.ee/sid/pid/est/ni"
* identifier[=].value = "38301105216"
* identifier[+].system = "https://fhir.ee/sid/pid/est/ppn"
* identifier[=].value = "K0307337"
* identifier[=].period.end = "2023-12-28"
* identifier[=].assigner.display = "Estonian Police and Board Agency"
* active = true
* name.use = #official
* name.family = "Meri"
* name.given = "Mati"
* gender = #male
//* birthDate = "1983-01-11"
//* birthDate.extension.url = "https://fhir.ee/StructureDefinition/ee-date-accuracy-indicator"
//* birthDate.extension.valueCoding = $ee-date-accuracy-indicator#AAA "Day, month and year are accurate"
//* address.extension[0].url = "https://fhir.ee/base/StructureDefinition/ee-ads"
//* address.extension[=].valueCoding = $ee-ads#2280361
* address.extension[+].url = "https://fhir.ee/base/StructureDefinition/ee-ehak"
* address.extension[=].valueCoding = $ehak#0387
* address.extension[+].url = "http://hl7.org/fhir/StructureDefinition/address-official"
* address.extension[=].valueBoolean = true
* address.use = #work
* address.text = "Harju maakond, Tallinn, Lasnamäe linnaosa, Valukoja tn 10"
* address.city = "Tallinn"
* address.state = "Harju"
* address.postalCode = "14215"
* address.country = "EE"