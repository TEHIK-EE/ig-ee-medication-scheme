Instance: MedicationStatement-complex-dosaging
InstanceOf: MedicationStatement
Usage: #example
Description: "Ravimiskeemi rida muutuva annustamisega. Schema line for metformin with complex dosaging" 
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
* language = #et
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-substitution"
* extension[=].extension[0].url = "substitutionAllowed"
* extension[=].extension[=].valueBoolean = true
* extension[=].extension[+].url = "substitutionAllowedReason"
* extension[=].extension[=].valueCodeableConcept = $ravimi-asendamatuse-pohjus#KP08 "patsiendil on diagnoositud kaasuv psüühika- või käitumishäire"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount"
* extension[=].valueQuantity.value = 100
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time"
* extension[=].valueDateTime = "2023-11-07"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medication-remainder"
* extension[=].extension[0].url = "daysAvailable"
* extension[=].extension[=].valueInteger = 100
* extension[=].extension[+].url = "daysDispensed"
* extension[=].extension[=].valueInteger = 30
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
* extension[=].extension[0].url = "reimbursementRate"
* extension[=].extension[=].valueCodeableConcept = $retsepti-soodustuse-maar#090 "90%"
* extension[=].extension[+].url = "reimbursementCondition"
* extension[=].extension[=].valueCodeableConcept.coding.code = #90_1
* extension[=].extension[=].valueCodeableConcept.coding.display = "siia tuleb kirjeldus vajalikud-tingimused-loendist"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization"
* extension[=].valueCodeableConcept = $retsepti-volituse-liik#public "Avalik"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-prescription-intent"
* extension[=].valueCode = #order
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-verification"
* extension[=].extension[0].url = "verificationTime"
* extension[=].extension[=].valueDateTime = "2023-11-09"
* extension[=].extension[+].url = "verificationAuthor"
* extension[=].extension[=].valueReference = Reference(PractRoleD12345)
* status = #recorded
* category[0] = $ravikuuri-tyyp#P "Pidev"
//* category[=].text = "pidev"
* category[+] = $statement-origin-category#123 "ei ole patsiendi ytluse põhjal"
* category[+] = $retsepti-liik#1 "tavaretsept"
//* category[=].text = "tavaretsept"
* category[+] = $retsepti-kordsus#3 "3-kordne"
//* category[=].text = "3-kordne"
* medication.reference = Reference(metformin)
* subject = Reference(pat1MatiMeri)
* effectivePeriod.start = "2015-02-07T13:28:17-05:00"
//* effectivePeriod.end = "2024-02-07"
* reason.concept.coding = $rhk-10#E12 "Väärtoitumussuhkurtõbi"
* note.authorReference = Reference(N98765)
* note.time = "2023-09-01"
* note.text = "muutuv ravimiskeem"
* dosage[0].patientInstruction = "pool tabletti õhtuti"
* dosage[=].sequence = 1
* dosage[=].text = "esimene nädal"
* dosage[=].timing.repeat.boundsDuration.value = 7
* dosage[=].timing.repeat.boundsDuration.code = #d
* dosage[=].timing.repeat.boundsDuration.system = "http://unitsofmeasure.org"
* dosage[=].timing.repeat.frequency = 1
* dosage[=].timing.repeat.period = 1
* dosage[=].timing.repeat.periodUnit = #d
* dosage[=].timing.repeat.timeOfDay = "21:00:00"
* dosage[=].doseAndRate.doseQuantity = 0.5 $retsept-annustamise-yhik#TA "tablett"
* dosage[1].patientInstruction = "1 tablett õhtuti"
* dosage[=].sequence = 2
* dosage[=].text = "teine nädal"
* dosage[=].timing.repeat.boundsDuration.value = 7
* dosage[=].timing.repeat.boundsDuration.code = #d
* dosage[=].timing.repeat.boundsDuration.system = "http://unitsofmeasure.org"
* dosage[=].timing.repeat.frequency = 1
* dosage[=].timing.repeat.period = 1
* dosage[=].timing.repeat.periodUnit = #d
* dosage[=].timing.repeat.timeOfDay = "21:00:00"
* dosage[=].doseAndRate.doseQuantity = 1 $retsept-annustamise-yhik#TA "tablett"
* dosage[2].patientInstruction = "1 tablett hommikul ja 1 tablett õhtul"
* dosage[=].sequence = 3
* dosage[=].text = "kolmas nädal ja edasi"
* dosage[=].timing.repeat.boundsDuration.value = 7
* dosage[=].timing.repeat.boundsDuration.code = #d
* dosage[=].timing.repeat.boundsDuration.system = "http://unitsofmeasure.org"
* dosage[=].timing.repeat.frequency = 1
* dosage[=].timing.repeat.period = 1
* dosage[=].timing.repeat.periodUnit = #d
* dosage[=].timing.repeat.timeOfDay = "09:00:00"
* dosage[=].doseAndRate.doseQuantity = 1 $retsept-annustamise-yhik#TA "tablett"
* dosage[3].timing.repeat.frequency = 1
* dosage[=].sequence = 3
* dosage[=].timing.repeat.period = 1
* dosage[=].timing.repeat.periodUnit = #d
* dosage[=].timing.repeat.timeOfDay = "21:00:00"
* dosage[=].doseAndRate.doseQuantity = 1 $retsept-annustamise-yhik#TA "tablett"