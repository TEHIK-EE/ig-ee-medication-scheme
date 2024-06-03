Extension: ExtensionEETISLockStatus
Id: ee-tis-lock-status
Description: "Broneering retseptil. When pharmacy locks the prescription for ordering unauthorized medication for patient."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2023-12-05T08:56:43.9409623+00:00"
* ^context[0].type = #element
* ^context[=].expression = "MedicationRequest"
* ^context[+].type = #element
* ^context[=].expression = "MedicationStatement"
* . ^short = "When pharmacy locks the prescription for ordering unauthorized medication for patient."
* extension contains
    lockStatus 0..* and
    lockOwner 0..*
* extension[lockStatus] ^short = "Prescription is locked in pharmacy "
* extension[lockStatus] ^definition = "Broneeritud apteegis. Kasutatakse juhul kui on tegemist müügiloata ravimi retseptiga, mis on saanud positiivse otsuse ning ootab apteegis tellitavat ravimit. "
* extension[lockStatus].value[x] only boolean
* extension[lockStatus].valueBoolean ^definition = "True - prescription is locked for certain pharmacy.\r\nFalse - prescription is not locked."
* extension[lockOwner] ^short = "Pharmacy who locked the prescription for ordering unauthorized medication."
* extension[lockOwner] ^definition = "Broneeringu teinud apteek"
* extension[lockOwner].value[x] only string
//* value[x] ^slicing.discriminator.type = #type
//* value[x] ^slicing.discriminator.path = "$this"
//* value[x] ^slicing.rules = #open