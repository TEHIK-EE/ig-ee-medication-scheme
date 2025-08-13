Instance: dispensation-metformin
InstanceOf: MedicationDispense
Usage: #example
Description: "Metformiini väljamüük patsiendi esindajale. Dispensation of metformin prescription for other buyer"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-prescription-dispense"
//* implicitRules = "https://build.fhir.org/ig/HL7EE/ig-ee-base"
* language = #et
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
* extension[=].extension[0].url = "reimbursementRate"
* extension[=].extension[=].valueCodeableConcept = $retsepti-soodustuse-maar#090 "90%"
* extension[=].extension[+].url = "reimbursementCondition"
* extension[=].extension[=].valueCodeableConcept = $reimbursement-condition#90_1 "vajalikud tingimused sellise soodustuse saamiseks"
* extension[=].extension[+].url = "reimbursementSpeciality"
* extension[=].extension[=].valueCodeableConcept = $erialad#E110 "dermatoveneroloogia"
//* extension[=].extension[=].valueCodeableConcept.coding.display = "siia tuleb kirjeldus vajalikud-tingimused-loendist"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-buyer-epc"
* extension[=].valueString = "42002230000"
* status = #completed
* medication.reference = Reference(metformin-dispensed)
* subject = Reference(pat1MatiMeri)
* performer.actor = Reference(pharmacistKristiina)
* authorizingPrescription = Reference(prescription-metformin)
* quantity.value = 100
* daysSupply.value = 33.3
* whenHandedOver = "2023-11-07"
* note.text = "ravim väljastatud ainult osaliselt, sest puudus õige suurusega pakend"