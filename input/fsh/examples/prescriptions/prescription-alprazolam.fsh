Instance: prescription-alprazolam
InstanceOf: MedicationRequest
Usage: #example
Description: "Prescription of alprazolam with reimbursement rate 50%"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-prescription"
//* implicitRules = "http://hl7.org/fhir/reference"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
* extension[=].extension[0].url = "reimbursementRate"
* extension[=].extension[=].valueCodeableConcept = $retsepti-soodustuse-maar#50 "50%"
* extension[=].extension[+].url = "reimbursementReason"
* extension[=].extension[=].valueString = "nii on"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization"
* extension[=].valueCodeableConcept = $retsepti-volituse-liik#public "Avalik"
* status = #active
* statusChanged = "2014-06-10"
* intent = #order
* category[0] = $retsepti-liik#1 "tavaretsept"
* category[+] = $retsepti-kordsus#1 "1-kordne"
//* medication.reference.reference = "Medication/alprazolam"
* medication.reference = Reference(alprazolam)
* subject = Reference(pat1MatiMeri)
* authoredOn = "2023-11-07"
* reason.concept = $rhk-10#F41.0 "Paanikahäire"
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 24
* dosageInstruction.timing.repeat.periodUnit = #h
* dosageInstruction.doseAndRate.doseQuantity = 1 $retsept-annustamise-yhik#TA "tablett"
* dispenseRequest.validityPeriod.start = "2023-11-07"
* dispenseRequest.validityPeriod.end = "2023-12-07"
//* dispenseRequest.dispenser.reference = "https://fhir.ee/StructureDefinition/ee-tis-organization"
* substitution.allowedBoolean = true
* substitution.reason = $ravimi-asendamatuse-pohjus#KP08 "Patsiendil on diagnoositud kaasuv psüühika- või käitumishäire"
//* substitution.reason.text = "Patsiendil on diagnoositud kaasuv psüühika- või käitumishäire"