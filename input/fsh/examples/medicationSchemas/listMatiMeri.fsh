/*Instance: listMatiMeri
InstanceOf: List
Usage: #example
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-list"
* language = #et
//* implicitRules = "http://hl7.org/fhir/reference"
* status = #current
* mode = #snapshot
* title = "Mati Meri ravimiskeem"
* subject = Reference(pat1MatiMeri)
* date = "2017-07-30"
//* source = Reference(https://fhir.ee/StructureDefinition/ee-tis-practitioner-role)
* entry[0].deleted = false
* entry[=].date = "2023-06-30"
* entry[=].item = Reference(MedicationStatementAdrenalin) "Adrenaliin"
* entry[+].deleted = false
* entry[=].date = "2023-01-30"
* entry[=].item = Reference(MedicationStatementAlprazolam) "Alprasolaam"
* entry[+].deleted = false
* entry[=].date = "2023-11-30"
* entry[=].item = Reference(MedicationStatement-metformin) "Metformiin"
* entry[+].deleted = false
* entry[=].date = "2023-01-03"
* entry[=].item = Reference(MedicationStatementNovorapid) "Aspart-insuliin"
* entry[+].deleted = true
* entry[=].date = "2023-12-12"
* entry[=].item = Reference(MedicationStatement-ospen2) "Fenoksymetyylpenitsilliin"
*/