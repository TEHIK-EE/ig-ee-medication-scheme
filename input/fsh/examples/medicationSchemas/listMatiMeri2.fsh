/*
Instance: listMatiMeri2
InstanceOf: List
Usage: #example
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-list"
* language = #et
//* implicitRules = "http://hl7.org/fhir/reference"
* status = #current
* mode = #working
* subject = Reference(pat1MatiMeri)
//* source = Reference(https://fhir.ee/StructureDefinition/ee-tis-device-tjt)  Viitab profiilile, mitte TJT objektile
* entry[0].item = Reference(MedicationStatementAlprazolam)
* entry[+].item = Reference(MedicationStatementNovorapid)
* entry[+].item = Reference(MedicationStatement-ospen)
*/