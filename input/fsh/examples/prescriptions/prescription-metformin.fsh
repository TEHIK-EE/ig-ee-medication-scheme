Instance: prescription-metformin
InstanceOf: MedicationRequest
Usage: #example
Description: "Prescription of metformin with substitution NOT allowed and reason for that"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-prescription"
* language = #et
//* implicitRules = "http://hl7.org/fhir/reference"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
* extension[=].extension[0].url = "reimbursementRate"
* extension[=].extension[=].valueCodeableConcept = $retsepti-soodustuse-maar#090 "90%"
* extension[=].extension[+].url = "reimbursementCondition"
* extension[=].extension[=].valueCodeableConcept = $reimbursement-condition#90_1 "vajalikud tingimused bla bla"
* extension[=].extension[+].url = "reimbursementSpeciality"
* extension[=].extension[=].valueCodeableConcept = $erialad#E110 "dermatoveneroloogia"
//* extension[=].extension[=].valueCodeableConcept.coding.display = "siia tuleb kirjeldus vajalikud-tingimused-loendist"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization"
* extension[=].valueCodeableConcept = $retsepti-volituse-liik#public "Avalik"
* identifier.system = $retseptikeskus-retsept
* identifier.value = "1018862058"
* status = #active
* statusChanged = "2014-06-10"
* intent = #order
* category[0] = $retsepti-liik#1 "Tavaretsept"
* category[+] = $retsepti-kordsus#3 "3-kordne"
* medication.reference = Reference(metformin)
* subject = Reference(pat1MatiMeri)
* authoredOn = "2023-11-07"
* reason.concept = $rhk-10#E12 "Väärtoitumussuhkurtõbi"
* courseOfTherapyType = $ravikuuri-tyyp#P "Pidev"
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.timeOfDay = "09:00:00"
* dosageInstruction[=].doseAndRate.doseQuantity = 1 $retsept-annustamise-yhik#TA "tablett"
* dosageInstruction[+].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.timeOfDay = "21:00:00"
* dosageInstruction[=].doseAndRate.doseQuantity = 2 $retsept-annustamise-yhik#TA "tablett"
* dispenseRequest.validityPeriod.start = "2023-11-07"
* dispenseRequest.validityPeriod.end = "2024-05-07"
* substitution.allowedBoolean = false
* substitution.reason = $ravimi-asendamatuse-pohjus#KP01 "tegemist on bioloogilise ravimiga"
//* substitution.reason.text = "Tegemist on bioloogilise ravimiga"