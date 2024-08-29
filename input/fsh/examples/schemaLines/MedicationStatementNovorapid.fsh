Instance: MedicationStatementNovorapid
InstanceOf: MedicationStatement
Usage: #example
Description: "Ravimiskeemi rida. Schema line for aspart-insulin"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-substitution"
* extension[=].extension[0].url = "substitutionAllowed"
* extension[=].extension[=].valueBoolean = true
* extension[=].extension[+].url = "substitutionAllowedReason"
* extension[=].extension[=].valueCodeableConcept = $ravimi-asendamatuse-pohjus#KP08 "Prohibited because the patient has been diagnosed with concurrent mental or behavioural disorder"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount"
* extension[=].valueQuantity.value = 15
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time"
* extension[=].valueDateTime = "2023-11-07"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medication-remainder"
* extension[=].extension[0].url = "daysAvailable"
* extension[=].extension[=].valueInteger = 30
* extension[=].extension[+].url = "daysDispensed"
* extension[=].extension[=].valueInteger = 10
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
* extension[=].extension[0].url = "reimbursementRate"
* extension[=].extension[=].valueCodeableConcept = $retsepti-soodustuse-maar#100 "100%"
* extension[=].extension[+].url = "reimbursementReason"
* extension[=].extension[=].valueString = "nii on"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization"
* extension[=].valueCodeableConcept = $retsepti-volituse-liik#v "Volitatud"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-prescription-intent"
* extension[=].valueCode = #order
// Kas intent andmevälja võib code'iks teha nagu on MedicationRequestil?
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-verification"
* extension[=].extension[0].url = "verificationTime"
* extension[=].extension[=].valueDateTime = "2023-11-09"
* extension[=].extension[+].url = "verificationAuthor"
* extension[=].extension[=].valueReference = Reference(PractRoleD12345)
* status = #recorded
* category[0] = $ravikuuri-tyyp#P "Pidev"
* category[=].text = "pidev"
* category[+] = $statement-origin-category#123 "ei ole patsiendi ytluse põhjal"
* category[+] = $retsepti-liik#1 "tavaretsept"
* category[=].text = "tavaretsept"
* category[+] = $retsepti-kordsus#3 "3-kordne"
* category[=].text = "3-kordne"
* medication.reference = Reference(novorapid)
* subject = Reference(pat1MatiMeri)
* effectivePeriod.start = "2015-02-07T13:28:17-05:00"
//* effectivePeriod.end = "2027-10-01"
* reason.concept = $rhk-10#E10.9 "Insuliinisõltuv suhkurtõbi tüsistusteta"
* note.authorReference = Reference(N98765)
* note.time = "2023-09-01"
* note.text = "patsient jälgib ilusti ravimiskeemi"
* dosage.patientInstruction = "süstida kõhunaha alla"
* dosage.timing.repeat.frequency = 3
* dosage.timing.repeat.period = 1
* dosage.timing.repeat.periodUnit = #d
* dosage.doseAndRate.doseQuantity = 12 $retsept-annustamise-yhik#TY "toimeaine ühik"