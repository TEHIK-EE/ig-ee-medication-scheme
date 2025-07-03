Instance: prescription-cancelled
InstanceOf: MedicationRequest
Usage: #example
Description: "Cancelled prescription of phenoxymethylpenicillin"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-prescription"
* language = #et
//* implicitRules = "http://hl7.org/fhir/reference"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
* extension[=].extension[0].url = "reimbursementRate"
* extension[=].extension[=].valueCodeableConcept = $retsepti-soodustuse-maar#050 "50%"
* extension[=].extension[+].url = "reimbursementCondition"
* extension[=].extension[=].valueCodeableConcept = $reimbursement-condition#90_1 "vajalikud tingimused bla bla"
//* extension[=].extension[=].valueCodeableConcept.coding.display = "siia tuleb kirjeldus vajalikud-tingimused-loendist"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization"
* extension[=].valueCodeableConcept = $retsepti-volituse-liik#public "Avalik"
//* identifier.system = https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept
* identifier.value = "1018862058"
* status = #cancelled
* statusReason = $retsepti-annulleerimise-pohjus#AN01 "Raviskeemi muudatus: soovimatu koos- või kõrvaltoime"
//* statusReason.text = "Raviskeemi muudatus: soovimatu koos- või kõrvaltoime"
* statusChanged = "2014-06-10"
* intent = #order
* medication.reference = Reference(fenoksymetyylpenitsilliin)
* subject = Reference(pat1MatiMeri)
* informationSource = Reference(PractRoleD98765)
* authoredOn = "2023-11-07"
* reason.concept = $rhk-10#J20.2 "Streptokokitekkene äge bronhiit"
* dosageInstruction.timing.repeat.count = 3
* dosageInstruction.timing.repeat.durationUnit = #d
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 8
* dosageInstruction.timing.repeat.periodUnit = #h
* dosageInstruction.doseAndRate.doseQuantity = 1 $retsept-annustamise-yhik#TA "tablett"
* dispenseRequest.validityPeriod.start = "2023-11-07"
* dispenseRequest.validityPeriod.end = "2024-05-07"
//* dispenseRequest.dispenser.reference = "https://fhir.ee/StructureDefinition/ee-tis-organization"
* substitution.allowedBoolean = false
* substitution.reason = $ravimi-asendamatuse-pohjus#KP01 "tegemist on bioloogilise ravimiga"
//* substitution.reason.text = "Tegemist on bioloogilise ravimiga"