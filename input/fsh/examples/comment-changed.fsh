Instance: Comment-changed
InstanceOf: Communication
Usage: #example
Description: "Comment about alprazolam where the comment has been changed"
* meta.profile = "https://fhir.ee/base/StructureDefinition/ee-tis-communication"
* identifier.value = "080809"
* status = #completed
* category.text = "siia tuleb kommentaari tüüp. eeldatavasti loendist"
* about = Reference(MedicationStatementAlprazolam)
* sent = 2025-03-12
* sender = Reference(PractRoleD12345)
* reason.reference = Reference(alprazolam)
* payload.contentCodeableConcept.text = "vajab suuremat annust, sest väikesem ei anna soovitud tulemust"
* note.time = 2025-03-13
* note.text = "hoolimata patsiendi palvest, jääb ravimi tugevus muutmata"