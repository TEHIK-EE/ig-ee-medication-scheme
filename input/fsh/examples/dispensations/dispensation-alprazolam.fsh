Instance: dispensation-alprazolam
InstanceOf: MedicationDispense
Usage: #example
Description: "Alprasolaami väljamüük teise soodustusega kui mida arst on retseptile pannud. Dispensation of alprazolam prescription with 0 reinbursement rate in pharmacy"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-prescription-dispense"
* implicitRules = "https://build.fhir.org/ig/HL7EE/ig-ee-base"
* language = #et
* extension.url = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
* extension.extension[0].url = "reimbursementRate"
* extension.extension[=].valueCodeableConcept = $retsepti-soodustuse-maar#000 "0%"
* extension.extension[+].url = "reimbursementCondition"
* extension.extension[=].valueCodeableConcept = https://fhir.ee/CodeSystem/ravimi-soodustuse-vajalikud-tingimused#90_1 "vajalikud tingimused sellise soodustuse saamiseks"
//* extension.extension[=].valueCodeableConcept.coding.display = "siia tuleb kirjeldus vajalikud-tingimused-loendist"
* status = #completed
* medication.reference = Reference(alprazolam-dispensed)
* subject = Reference(pat1MatiMeri)
* performer.actor = Reference(pharmacistKristiina)
* authorizingPrescription = Reference(prescription-alprazolam)
* quantity.value = 30
* daysSupply.value = 30
* whenHandedOver = "2023-11-07"
* note.text = "ei ole võimalik väljastada arsti kirjutatud soodustusega"