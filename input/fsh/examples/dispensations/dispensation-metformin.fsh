Instance: dispensation-metformin
InstanceOf: MedicationDispense
Usage: #example
Description: "Dispensation of metformin prescription for other buyer"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-prescription-dispense"
* implicitRules = "https://build.fhir.org/ig/HL7EE/ig-ee-base"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
* extension[=].extension[0].url = "reimbursementRate"
* extension[=].extension[=].valueCodeableConcept = $retsepti-soodustuse-maar#90 "90%"
* extension[=].extension[+].url = "reimbursementReason"
* extension[=].extension[=].valueString = "elu on"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-buyer-epc"
* extension[=].valueString = "42002230000"
* status = #completed
* medication.reference = Reference(metformin)
* subject = Reference(pat1MatiMeri)
* performer.actor = Reference(pharmacistKristiina)
* authorizingPrescription = Reference(prescription-metformin)
* quantity.value = 100
* whenHandedOver = "2023-11-07"
* note.text = "ravim väljastatud ainult osaliselt, sest puudus õige suurusega pakend"