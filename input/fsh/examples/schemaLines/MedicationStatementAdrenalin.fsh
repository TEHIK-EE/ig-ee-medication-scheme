Instance: MedicationStatementAdrenalin
InstanceOf: MedicationStatement
Usage: #example
Description: "Ravimiskeemi rida. Schema line for adrenalin"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-substitution"
* extension[=].extension[0].url = "substitutionAllowed"
* extension[=].extension[=].valueBoolean = true
* extension[=].extension[+].url = "substitutionAllowedReason"
* extension[=].extension[=].valueCodeableConcept = $ravimi-asendamatuse-pohjus#KP09 "Tegemist on müügiloata/erisoodustusega ravimiga"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount"
* extension[=].valueQuantity.value = 5
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time"
* extension[=].valueDateTime = "2023-11-07"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medication-remainder"
* extension[=].valueInteger = 5
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
* extension[=].extension[0].url = "reimbursementRate"
* extension[=].extension[=].valueCodeableConcept = $retsepti-soodustuse-maar#50 "50%"
* extension[=].extension[+].url = "reimbursementReason"
* extension[=].extension[=].valueString = "nii on"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-unauthorized-product-request"
* extension[=].extension[0].url = "requestNumber"
* extension[=].extension[=].valueId = "123456"
* extension[=].extension[+].url = "requestReason"
* extension[=].extension[=].valueCodeableConcept = $myygiloata-ravimi-taotluse-pohjendus#ML01 "Eestis puudub haiguse/seisundi raviks müügiloaga ravim"
* extension[=].extension[+].url = "requestStatus"
* extension[=].extension[=].valueCodeableConcept = $myygiloata-ravimi-taotluse-otsus#P "Otsus positiivne"
* extension[=].extension[+].url = "requestDate"
* extension[=].extension[=].valueDateTime = "2023-11-11"
//* extension[=].extension[+].url = "requestNegDecision"
//* extension[=].extension[=].valueCodeableConcept = $myygiloata-ravimi-neg-otsuse-pohjendus#ON04 
* extension[=].extension[+].url = "requestReasonText"
* extension[=].extension[=].valueString = "siia miskit tarka juttu"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-lock-status"
* extension[=].extension[0].url = "lockStatus"
* extension[=].extension[=].valueBoolean = true
* extension[=].extension[+].url = "lockOwner"
* extension[=].extension[=].valueString = "Tehiku Apteek"
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
* category[0] = $ravikuuri-tyyp#U "Ühekordne"
* category[=].text = "ühekordne"
* category[+] = $statement-origin-category#123 "ei ole patsiendi ytluse põhjal"
* category[+] = $retsepti-liik#1 "tavaretsept"
* category[=].text = "tavaretsept"
* category[+] = $retsepti-kordsus#1 "1-kordne"
* category[=].text = "1-kordne"
* medication.reference = Reference(adrenalin)
* subject = Reference(pat1MatiMeri)
* effectivePeriod.start = "2015-02-07T13:28:17-05:00"
//* effectivePeriod.end = "2027-10-01"
* derivedFrom = Reference(prescription-adrenalin-pos-dec)
* reason.concept = $rhk-10#D89.8 "Immuunmehhanismi hõlmavad mujal klassifitseerimata muud täpsustatud haigusseisundid"
* note.authorReference = Reference(N98765)
* note.time = "2023-09-01"
* note.text = "lõpuks ometi sai müügiloataotlus rahuldatud ja saab ravimit tellida"
* dosage.patientInstruction = "none"
* dosage.timing.repeat.count = 1
* dosage.asNeeded = true
* dosage.doseAndRate.doseQuantity = 1 $retsept-annustamise-yhik#TK