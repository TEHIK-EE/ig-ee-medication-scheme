Profile: EETISCommunication
Parent: Communication
Id: ee-tis-communication
Description: "Ravimiskeemi kommentaar. Comment about one treatment line in mediction list." 
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2025-03-12T13:55:03.1985103+00:00"
* . ^short = "Comment"
* . ^definition = "Kommentaar"
* identifier ^short = "ID of the comment"
* identifier ^definition = "Kommentaari ID"
* status ^short = "Status of the comment can be completed(LISATUD) or stopped(KUSTUTATUD). If comment is changed the note element is used."
* status ^definition = "Kasutusel 2 staatust LISATUD=completed, KUSTUTATUD=stopped. Kui tegu on muutmisega, tuleb see välja note.time elemendi muutmise aja ja teksti kaudu. " 
* category 1..1
//* category from http://hl7.org/fhir/ValueSet/communication-category (example)
* category ^binding.description = "|alert| is used when there is a renal failure of some degree and the health care professional needs to pay more attention to dosage"
* category ^short = "The type of comment this is. Codes |alert| or |notification| are used"
* category ^definition = "Kommentaari tüüp, nt neerufunktsiooni mõjutav ravimi puhul on koodiks |alert|"
* category.text ^short = "Description of the alert"
* category.text ^definition = "C/D. Siia tuleb hoiatus, kui ravim on neerutoksiline. Kui on tegu muu kommentaariga siis see väli on tühi"
* about only Reference(MedicationStatement)
* about 1..1
* about ^short = "Related MedicationStatement the comment is about"
* about ^definition = "Ravimiskeemi rida, mille kohta kommentaar on tehtud" 
* sent 1..1
* sent ^short = "When the comment was added to the MedicationStatement"
* sent ^definition = "Kommentaari lisamise aeg"
* sender only Reference(EETISPractitioner or EETISPractitionerRole)
* sender 1..1
* sender ^short = "Practitioner who added the comment"
* sender ^definition = "Tervishoiutöötaja, kes lisas ravimiskeemi reale kommentaari" 
* reason only CodeableReference(Medication)
* reason ^short = "Reference to a certain medication, its strenght and active ingredient this comment is about" 
* reason ^definition = "Viide ravimile, ka toimeaine ja tugevus, mille kohta kommentaar on tehtud"
* payload 1..1 
* payload.contentCodeableConcept.text 1..1
* payload.contentCodeableConcept.text ^short = "Comment about the MedicationStatement in free form text"
* payload.contentCodeableConcept.text ^definition = "Kommentaari sisu vabatekstina"
* note.time 1..1 
* note.time ^short = "Time when the comment was changed."
* note.time ^definition = "Kommentaari muutmise aeg"
* note.text ^short = "Why the comment was changed"
* note.text ^definition = "Kommentaari muutmise põhjendus"
