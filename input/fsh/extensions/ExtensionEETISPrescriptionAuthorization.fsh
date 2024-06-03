Extension: ExtensionEETISDispensationAuthorization
Id: ee-tis-dispensation-authorization
Description: "Volituse liik. Defines the authorization of the prescription."
* ^status = #draft
* ^date = "2024-02-21T12:23:02.5700529+00:00"
* ^context[0].type = #element
* ^context[=].expression = "MedicationStatement"
* ^context[+].type = #element
* ^context[=].expression = "MedicationRequest"
* . ^short = "Volituse liik."
* . ^definition = "Defines the authorization of the prescription."
* value[x] 1..
* value[x] only CodeableConcept
* value[x] from $retsepti-volituse-liik-VS (required)
* value[x] ^label = "VOLITUSE LIIK"
* value[x] ^short = "avalik | privaatne | volitatud"
* value[x] ^definition = "Prescription can be public, private or authorized."
* value[x] ^binding.description = "Volituse liik"