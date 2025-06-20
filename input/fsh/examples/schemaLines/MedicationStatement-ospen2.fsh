Instance: MedicationStatement-ospen2
InstanceOf: MedicationStatement
Usage: #example
Description: "Ravimiskeemi rida. Schema line for phenoxymethylpenicillin"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
* language = #et
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-substitution"
* extension[=].extension[0].url = "substitutionAllowed"
* extension[=].extension[=].valueBoolean = true
* extension[=].extension[+].url = "substitutionAllowedReason"
* extension[=].extension[=].valueCodeableConcept = $ravimi-asendamatuse-pohjus#KP03 "patsiendil esineb ülitundlikkus abiaine vastu, mis esineb kõigis teistes sarnastes ja sama toimeainega ravimites"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount"
* extension[=].valueQuantity.value = 12
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time"
* extension[=].valueDateTime = "2023-11-07"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medication-remainder"
* extension[=].extension[0].url = "daysAvailable"
* extension[=].extension[=].valueInteger = 12
* extension[=].extension[+].url = "daysDispensed"
* extension[=].extension[=].valueInteger = 12
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
* extension[=].extension[0].url = "reimbursementRate"
* extension[=].extension[=].valueCodeableConcept = $retsepti-soodustuse-maar#075 "75%"
* extension[=].extension[+].url = "reimbursementCondition"
* extension[=].extension[=].valueCodeableConcept.coding.code = #75_1
* extension[=].extension[=].valueCodeableConcept.coding.display = "siia tuleb kirjeldus vajalikud-tingimused-loendist"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization"
* extension[=].valueCodeableConcept = $retsepti-volituse-liik#v "Volitatud"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-prescription-intent"
* extension[=].valueCode = #order
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-cancelled-status-reason"
* extension[=].valueCodeableConcept = $retsepti-annulleerimise-pohjus#AN01 "Raviskeemi muudatus: soovimatu koos- või kõrvaltoime"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-verification"
* extension[=].extension[0].url = "verificationTime"
* extension[=].extension[=].valueDateTime = "2023-11-09"
* extension[=].extension[+].url = "verificationAuthor"
* extension[=].extension[=].valueReference = Reference(PractRoleD12345)
* status = #recorded
* category[0] = $ravikuuri-tyyp#F "Fikseeritud"
* category[=].text = "fikseeritud"
* category[+] = $statement-origin-category#123 "ei ole patsiendi ytluse põhjal"
* category[+] = $retsepti-liik#1 "tavaretsept"
* category[=].text = "tavaretsept"
* category[+] = $retsepti-kordsus#1 "1-kordne"
* category[=].text = "1-kordne"
* medication.reference = Reference(fenoksymetyylpenitsilliin)
* subject = Reference(pat1MatiMeri)
* effectivePeriod.start = "2015-02-07T13:28:17-05:00"
//* effectivePeriod.end = "2024-02-07"
* reason.concept = $rhk-10#J13 "Streptococcus pneumoniae tekkene bronhopneumoonia"
* note.authorReference = Reference(N98765)
* note.time = "2023-09-01"
* note.text = "teised antibiootikumid ei anna tulemust"
* dosage.patientInstruction = "3 korda päevas"
* dosage.timing.repeat.frequency = 3
* dosage.timing.repeat.period = 1
* dosage.timing.repeat.periodUnit = #d
* dosage.timing.repeat.boundsDuration = 7 'd' "d"
* dosage.doseAndRate.doseQuantity = 1 $retsept-annustamise-yhik#TA