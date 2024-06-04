Extension: ExtensionEETISSubstitution
Id: ee-tis-substitution
Description: "Asendamine lubatud. Reason for not allowing the substitution of medication."
* ^status = #draft
* ^date = "2024-02-21T07:24:08.5899288+00:00"
* ^context.type = #element
* ^context.expression = "MedicationStatement"
* . ^short = "Reason for not allowing the substitution of medication."
* . ^definition = "Asendamise mitte-lubamine"
* extension contains
    substitutionAllowed 0..1 and
    substitutionAllowedReason 0..1
* extension[substitutionAllowed].value[x] 1..
* extension[substitutionAllowed].value[x] only boolean
* extension[substitutionAllowed].value[x] ^short = "true - substitution is allowed\r\nfalse -substitution NOT allowed, provide reason"
* extension[substitutionAllowed].value[x] ^definition = "Vaikimisi on asendamine lubatud kõikide ravimite puhul"
* extension[substitutionAllowedReason].value[x] only CodeableConcept
* extension[substitutionAllowedReason].value[x] from $ravimi-asendamatuse-pohjus-VS (required)
* extension[substitutionAllowedReason].value[x] ^short = "If substitution is not allowed one must choose the reason for it from the ValueSet."
* extension[substitutionAllowedReason].value[x] ^definition = "Juhul kui asendamine pole lubatud peab loendist valima põhjuse, miks."
* extension[substitutionAllowedReason].value[x] ^binding.description = "Reason for NOT allowing substitution"