Extension: ExtensionEETISDispensationAuthorization
Id: ee-tis-dispensation-authorization
Description: "Volituse liik. Defines the authorization of the prescription."
* ^status = #draft
* ^date = "2024-02-21T12:23:02.5700529+00:00"
* ^context[0].type = #element
* ^context[=].expression = "MedicationStatement"
* ^context[+].type = #element
* ^context[=].expression = "MedicationRequest"
* . ^short = "Defines the authorization of the prescription."
* . ^definition = "Volituse liik. Digiretsepti koostamisel on patsiendil võimalik piirata ravimi väljaostu õiguseid. Vaikimisi on küll kõik retseptid avalikud, kuid seda staatust saab muuta arst retsepti koostamisel või patsient terviseportaalis."
* value[x] 1..
* value[x] only CodeableConcept
* value[x] from $retsepti-volituse-liik-VS (required)
* value[x] ^short = "Prescription can be public, private or authorized.\r\n\r\navalik | privaatne | volitatud"
* value[x] ^definition = "Volituse liik"