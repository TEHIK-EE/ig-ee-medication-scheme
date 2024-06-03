Instance: listMatiMeri3
InstanceOf: List
Usage: #example
Description: "List of patient's medications verified by D12345"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-list"
//* implicitRules = "http://hl7.org/fhir/reference"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-consent-with-interactions"
* extension[=].valueBoolean = true
* status = #current
* mode = #snapshot
* title = "Ravimiskeem, kinnitatud D12345 poolt"
* code = $list-example-codes#medications "Medication List"
* code.text = "Medication List"
* subject = Reference(pat1MatiMeri)
* date = "2024-01-19T13:17:15.4473399+00:00"
* source = Reference(PractRoleD12345) // List source peaks olema TJT?
* entry[0].flag = $list-item-flag#01 "Unchanged"
//* entry[=].deleted = false
* entry[=].date = "2023-06-30"
* entry[=].item = Reference(MedicationStatementAdrenalin) "Adrenaliin"
* entry[+].flag = $list-item-flag#04 "Prescribed"
//* entry[=].deleted = false
* entry[=].date = "2023-01-30"
* entry[=].item = Reference(MedicationStatementAlprazolam) "Alprasolaam"
* entry[+].flag = $list-item-flag#04 "Prescribed"
//* entry[=].deleted = false
* entry[=].date = "2023-11-30"
* entry[=].item = Reference(MedicationStatement-metformin) "Metformiin"
* entry[+].flag = $list-item-flag#01 "Unchanged"
//* entry[=].deleted = false
* entry[=].date = "2023-01-03"
* entry[=].item = Reference(MedicationStatementNovorapid) "Aspart-insuliin"
* entry[+].flag = $list-item-flag#06 "Suspended"
//* entry[=].deleted = true
* entry[=].date = "2023-12-12"
* entry[=].item = Reference(MedicationStatement-ospen2) "Fenoksymetyylpenitsilliin"