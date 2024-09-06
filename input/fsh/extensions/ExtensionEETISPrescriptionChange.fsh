Extension: ExtensionEETISPrescriptionChange
Id: ee-tis-prescription-change
Description: "Retsepti muutmise aeg, muutja ja põhjus."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-09-06T08:41:33.7774358+00:00"
* ^context[0].type = #element
* ^context[=].expression = "MedicationStatement"
* ^context[+].type = #element
* ^context[=].expression = "MedicationRequest"
* . ^short = "Changes on prescription - who changed, when and reason."
* . ^definition = "Retsepti muutmine, kes muutis, millal ja põhjus loendist."
* extension contains
    changeTime 0..* and
    changeAuthor 0..* and
    changeReason 0..*
* extension[changeTime].value[x] only dateTime
* extension[changeTime].value[x] ^short = "Change time. Time when practitioner made the changes."
* extension[changeTime].value[x] ^definition = "Muutmise aeg."
* extension[changeAuthor].value[x] only Reference(EETISPractitionerRole)
* extension[changeAuthor].value[x] ^short = "Change author. The author who made the changes"
* extension[changeAuthor].value[x] ^definition = "Muutja."
* extension[changeReason].value[x] only CodeableConcept
* extension[changeReason].value[x] ^binding.strength = #preferred
* extension[changeReason].value[x] ^binding.description = "\"Muutmise põhjendus\"-loend retseptikeskusest"
* extension[changeReason].value[x] ^short = "Reason for changes. Code from Retseptikeskus ValueSet."
* extension[changeReason].value[x] ^definition = "Muutmise põhjendus loendist."