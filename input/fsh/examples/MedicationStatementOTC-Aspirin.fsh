Instance: MedicationStatementOTC-Aspirin
InstanceOf: MedicationStatement
Usage: #example
Description: "Ravimiskeemi rida käsimüügiravimile. Schema line for over-the-counter Aspirin" 
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-statement-otc"
* language = #et
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-verification"
* extension[=].extension[0].url = "verificationTime"
* extension[=].extension[=].valueDateTime = "2023-11-09"
* extension[=].extension[+].url = "verificationAuthor"
* extension[=].extension[=].valueReference = Reference(PractRoleD12345)
* status = #recorded
* category[0] = $ravikuuri-tyyp#P "Pidev"
//* category[=].text = "pidev"
* category[+] = $ravimi-andmete-tyyp#ASK "ütluspõhine ravim"
* medication.reference = Reference(aspirin)
* subject = Reference(pat1MatiMeri)
* effectivePeriod.start = "2015-02-07T13:28:17-05:00"
//* effectivePeriod.end = "2024-02-07"
* reason.concept.coding = $rhk-10-VS#I10 "Hüpertooniatõbi e essentsiaalne e primaarne arteriaalne hüpertensioon e kõrgvererõhktõbi"
* note.authorReference = Reference(N98765)
* note.time = "2023-09-01"
* note.text = "igapäevaselt võtta südameaspiriini toetamaks veresoonkonna tervist"
* dosage.timing.repeat.frequency = 1
* dosage.timing.repeat.period = 24
* dosage.timing.repeat.periodUnit = #h
* dosage.doseAndRate.doseQuantity = 1 $retsept-annustamise-yhik#TA "tablett"