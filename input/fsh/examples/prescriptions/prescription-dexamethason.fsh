/*Instance: prescription-dexamethason
InstanceOf: MedicationRequest
Usage: #example
Description: "Prescription of dexamethasone with complex dosaging"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-prescription"
* language = #et
//* implicitRules = "http://hl7.org/fhir/reference"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
* extension[=].extension[0].url = "reimbursementRate"
* extension[=].extension[=].valueCodeableConcept = $retsepti-soodustuse-maar#050 "50%"
* extension[=].extension[+].url = "reimbursementCondition"
* extension[=].extension[=].valueCodeableConcept.coding.code = #50_1
* extension[=].extension[=].valueCodeableConcept.coding.display = "siia tuleb kirjeldus vajalikud-tingimused-loendist"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization"
* extension[=].valueCodeableConcept = $retsepti-volituse-liik#public "Avalik"
//* identifier.system = https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept
* identifier.value = "1018862058"
* status = #active
* statusChanged = "2014-06-10"
* intent = #order
* category[0] = $retsepti-liik#1 "tavaretsept"
* category[+] = $retsepti-kordsus#1 "1-kordne"
* medication.reference = Reference(dexamethason)
* subject = Reference(pat1MatiMeri)
* authoredOn = "2023-11-07"
* reason.concept = $rhk-10#C71 "Peaaju pahaloomuline kasvaja"
* courseOfTherapyType = $ravikuuri-tyyp#F "Fikseeritud"
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.timeOfDay = "09:00:00"
* dosageInstruction[=].timing.repeat.boundsDuration = 2 'd' "d"
* dosageInstruction[=].doseAndRate.doseQuantity = 4 $retsept-annustamise-yhik#TA "tablett"
* dosageInstruction[+].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.timeOfDay = "09:00:00"
* dosageInstruction[=].timing.repeat.boundsDuration = 2 'd' "d"
* dosageInstruction[=].doseAndRate.doseQuantity = 2 $retsept-annustamise-yhik#TA "tablett"
* dosageInstruction[+].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.timeOfDay = "09:00:00"
* dosageInstruction[=].timing.repeat.boundsDuration = 2 'd' "d"
* dosageInstruction[=].doseAndRate.doseQuantity = 1 $retsept-annustamise-yhik#TA "tablett"
* dosageInstruction[+].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.timeOfDay = "09:00:00"
* dosageInstruction[=].timing.repeat.boundsDuration = 1 'd' "d"
* dosageInstruction[=].doseAndRate.doseQuantity = 0.5 $retsept-annustamise-yhik#TA "tablett"
* dispenseRequest.validityPeriod.start = "2023-11-07"
* dispenseRequest.validityPeriod.end = "2024-05-07"
//* dispenseRequest.dispenser.reference = "https://fhir.ee/StructureDefinition/ee-tis-organization"
* substitution.allowedBoolean = true
* substitution.reason = $substitution-not-allowed#KP01 "Tegemist on bioloogilise ravimiga"
//* substitution.reason.text = "Tegemist on bioloogilise ravimiga"
*/