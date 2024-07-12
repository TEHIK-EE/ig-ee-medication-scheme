/*Instance: MedicationStatement-ospen
InstanceOf: MedicationStatement
Usage: #example
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
* implicitRules = "https://build.fhir.org/ig/HL7EE/ig-ee-base"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-substitution"
* extension[=].valueCodeableConcept = $ravimi-asendamatuse-pohjus#KP03 "Patsiendil esineb ülitundlikkus abiaine vastu, mis esineb kõigis teistes sarnastes ja sama toimeainega ravimites"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount"
* extension[=].valueInteger = 12
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time"
* extension[=].valueDateTime = "2023-11-07"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-medication-remainder"
* extension[=].extension[0].url = "daysAvailable"
* extension[=].extension[=].valueInteger = 100
* extension[=].extension[+].url = "daysDispensed"
* extension[=].extension[=].valueInteger = 30
//* modifierExtension.url = "https://fhir.ee/StructureDefinition/ee-tis-verification"
//* modifierExtension.extension[0].valueDateTime = "2023-11-07"
//* modifierExtension.extension[+].valueReference = Reference(PractRoleD98765)
* status = #recorded
* category[0] = $ravikuuri-tyyp#F "Fikseeritud"
* category[=].text = "fikseeritud"
* category[+] = $patient-reported#false "ei ole patsiendi ytluse põhjal"
* medication.reference = Reference(fenoksymetyylpenitsilliin)
* subject = Reference(pat1MatiMeri)
* effectivePeriod.start = "2023-11-07"
* effectivePeriod.end = "2024-02-07"
* reason.concept = $rhk-10#J20.2 "Streptokokitekkene äge bronhiit"
* note.authorReference = Reference(PractRoleD98765)
* note.time = "2023-09-01"
* note.text = "patsient jälgib ilusti ravimiskeemi"
* dosage.patientInstruction = "3 korda päevas"
* dosage.timing.repeat.frequency = 3
* dosage.timing.repeat.period = 1
* dosage.timing.repeat.periodUnit = #d
* dosage.timing.repeat.boundsDuration = 7 'd' "d"
* dosage.doseAndRate.doseQuantity = 1 $retsept-annustamise-yhik#TA
*/