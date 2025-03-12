Instance: Comment1
InstanceOf: Communication
Usage: #example
Description: "Comment about alprazolam"
* meta.profile = "https://fhir.ee/base/StructureDefinition/ee-tis-communication"
* identifier.value = "080808"
* status = #completed
* category.text = "siia tuleb kommentaari tüüp"
* about = Reference(MedicationStatementAlprazolam)
* sent = 2025-03-12
* sender = Reference(PractRoleD12345)
* reason.reference = Reference(alprazolam)
* payload.contentCodeableConcept.text = "vajab suuremat annust, sest väikesem ei anna soovitud tulemust"

