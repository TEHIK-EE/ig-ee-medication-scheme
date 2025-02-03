Instance: MedicationStatementPatientReportedRaud
InstanceOf: MedicationStatement
Usage: #example
Description: "Ravimiskeemi rida patsiendi sõnul ravimile. Treatment line for patient reported iron"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-statement-patient-reported"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-verification"
* extension[=].extension[0].url = "verificationTime"
* extension[=].extension[=].valueDateTime = "2023-11-09"
* extension[=].extension[+].url = "verificationAuthor"
* extension[=].extension[=].valueReference = Reference(PractRoleD12345)
* status = #recorded
* category[0] = $ravikuuri-tyyp#P "Pidev"
* category[=].text = "pidev"
* medication.reference = Reference(raud-patient-reported)
* subject = Reference(pat1MatiMeri)
* effectivePeriod.start = "2015-02-07T13:28:17-05:00"
//* effectivePeriod.end = "2027-10-01"
* note.authorReference = Reference(N98765)
* note.time = "2023-09-01"
* note.text = "patsient võtab igapäevaselt rauda, türoksiiniga kokku ei sobi ning tuleb tähelepanu pöörata!"
* dosage.timing.repeat.frequency = 1
* dosage.timing.repeat.period = 24
* dosage.timing.repeat.periodUnit = #h
* dosage.doseAndRate.doseQuantity = 1 $retsept-annustamise-yhik#TA "tablett"