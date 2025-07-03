Instance: MedicationStatementAlprazolam
InstanceOf: MedicationStatement
Usage: #example
Description: "Ravimiskeemi rida. Schema line for alprazolam"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
* language = #et
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-substitution"
* extension[=].extension[0].url = "substitutionAllowed"
* extension[=].extension[=].valueBoolean = true
* extension[=].extension[+].url = "substitutionAllowedReason"
* extension[=].extension[=].valueCodeableConcept = $ravimi-asendamatuse-pohjus#KP08 "patsiendil on diagnoositud kaasuv psüühika- või käitumishäire"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount"
* extension[=].valueQuantity.value = 30
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time"
* extension[=].valueDateTime = "2023-11-07"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medication-remainder"
* extension[=].extension[0].url = "daysAvailable"
* extension[=].extension[=].valueInteger = 30
* extension[=].extension[+].url = "daysDispensed"
* extension[=].extension[=].valueInteger = 10
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
* extension[=].extension[0].url = "reimbursementRate"
* extension[=].extension[=].valueCodeableConcept = $retsepti-soodustuse-maar#050 "50%"
* extension[=].extension[+].url = "reimbursementCondition"
* extension[=].extension[=].valueCodeableConcept = $reimbursement-condition#50_1 "vajalikud tingimused bla bla"
//* extension[=].extension[=].valueCodeableConcept.coding.display = "siia tuleb kirjeldus vajalikud-tingimused-loendist"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization"
* extension[=].valueCodeableConcept = $retsepti-volituse-liik#private "Privaatne"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-prescription-intent"
* extension[=].valueCode = #order
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-verification"
* extension[=].extension[0].url = "verificationTime"
* extension[=].extension[=].valueDateTime = "2023-11-09"
* extension[=].extension[+].url = "verificationAuthor"
* extension[=].extension[=].valueReference = Reference(PractRoleD12345)
* status = #recorded
* category[0] = $ravikuuri-tyyp#V "Vajadusel"
* category[=].text = "ühekordne"
* category[+] = $statement-origin-category#123 "ei ole patsiendi ytluse põhjal"
* category[+] = $retsepti-liik#1 "tavaretsept"
* category[=].text = "tavaretsept"
* category[+] = $retsepti-kordsus#1 "1-kordne"
* category[=].text = "1-kordne"
* medication.reference = Reference(alprazolam)
* subject = Reference(pat1MatiMeri)
* effectivePeriod.start = "2015-02-07T13:28:17-05:00"
//* effectivePeriod.end = "2027-10-01"
* reason.concept = $rhk-10-VS#F41.0 "Paanikahäire"
* note.authorReference = Reference(N98765)
* note.time = "2023-09-01"
* note.text = "patsient helistas ja soovis suuremat annust"
//* dosage.patientInstruction = "none"
* dosage.timing.repeat.frequency = 1
* dosage.timing.repeat.period = 24
* dosage.timing.repeat.periodUnit = #h
* dosage.doseAndRate.doseQuantity = 1 $retsept-annustamise-yhik#TA "tablett"