Instance: prescription-ospen
InstanceOf: MedicationRequest
Usage: #example
Description: "Prescription of phenoxymethylpenicillin"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-prescription"
//* implicitRules = "http://hl7.org/fhir/reference"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
* extension[=].extension[0].url = "reimbursementRate"
* extension[=].extension[=].valueCodeableConcept = $retsepti-soodustuse-maar#50 "50%"
//* extension[=].extension[+].url = "reimbursementReason"
//* extension[=].extension[=].valueString = "nii on"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization"
* extension[=].valueCodeableConcept = $retsepti-volituse-liik#public "Avalik"
* identifier.system = https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept
* identifier.value = "1018862058"
* status = #active
* statusChanged = "2023-11-09"
* intent = #order
* category[0] = $retsepti-liik#1 "tavaretsept"
* category[+] = $retsepti-kordsus#1 "1-kordne"
* medication.reference = Reference(fenoksymetyylpenitsilliin)
* subject = Reference(pat1MatiMeri)
* authoredOn = "2023-11-07"
* reason.concept = $rhk-10#J20.2 "Streptokokitekkene äge bronhiit"
* courseOfTherapyType = $ravikuuri-tyyp#F "Fikseeritud"
* dosageInstruction.timing.repeat.frequency = 3
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.timing.repeat.boundsDuration = 7 'd' "d" //UCUM?
* dosageInstruction.doseAndRate.doseQuantity = 1 $retsept-annustamise-yhik#TA "tablett"
* dispenseRequest.validityPeriod.start = "2023-11-07"
* dispenseRequest.validityPeriod.end = "2024-05-07"
* substitution.allowedBoolean = true
* substitution.reason = $ravimi-asendamatuse-pohjus#KP02 "Tegemist on kitsa terapeutilise vahemikuga ravimiga"
//* substitution.reason.text = "Tegemist on kitsa terapeutilise vahemikuga ravimiga"