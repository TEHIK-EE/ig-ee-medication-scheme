Profile: EETISPatient
Parent: $ee-patient
Id: ee-tis-patient
Description: "Patsient. Patient is the subject of the medication overview."
* ^status = #draft
* ^date = "2024-01-03T14:03:13.5276379+00:00"
* contact.relationship 1..1
* contact.relationship from $patsiendi-kontaktisikute-liigid-VS (extensible)