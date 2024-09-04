Instance: prescription-alprazolam
InstanceOf: MedicationRequest
Usage: #example
Description: "Prescription of alprazolam with reimbursement rate 50%"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-prescription"
//* implicitRules = "http://hl7.org/fhir/reference"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
* extension[=].extension[0].url = "reimbursementRate"
* extension[=].extension[=].valueCodeableConcept = $retsepti-soodustuse-maar#50 "50%"
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
* substitution.reason = $ravimi-asendamatuse-pohjus#KP08 "Prohibited because the patient has been diagnosed with concurrent mental or behavioural disorder"
//* substitution.reason.text = "Patsiendil on diagnoositud kaasuv psüühika- või käitumishäire"