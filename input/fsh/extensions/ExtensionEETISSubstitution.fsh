Extension: ExtensionEETISSubstitution
Id: ee-tis-substitution
Description: "Asendamine lubatud. Reason for not allowing the substitution of medication."
* ^status = #draft
* ^date = "2024-02-21T07:24:08.5899288+00:00"
* ^context.type = #element
* ^context.expression = "MedicationStatement"
* . ^short = "Asendamise mitte-lubamine"
* . ^definition = "Reason for not allowing the substitution of medication."
* extension contains
    substitutionAllowed 0..1 and
    substitutionAllowedReason 0..1
* extension[substitutionAllowed].value[x] 1..
* extension[substitutionAllowed].value[x] only boolean
* extension[substitutionAllowed].value[x] ^definition = "Substitution is by default allowed (true). If substitution is not allowed the reason must be defined."
* extension[substitutionAllowedReason].value[x] only CodeableConcept
* extension[substitutionAllowedReason].value[x] from $ravimi-asendamatuse-pohjus-VS (required)
* extension[substitutionAllowedReason].value[x] ^definition = "If substitution is not allowed one must choose the reason for it from the ValueSet."
* extension[substitutionAllowedReason].value[x] ^binding.description = "Reason for NOT allowing substitution"