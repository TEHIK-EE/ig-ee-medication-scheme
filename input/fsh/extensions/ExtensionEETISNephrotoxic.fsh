Extension: ExtensionEETISNephrotoxic
Id: ee-tis-nephrotoxic
Description: "Asendamine lubatud. Reason for not allowing the substitution of medication."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-08-23T08:41:33.7774358+00:00"
* ^context.type = #element
* ^context.expression = "ClinicalUseDefinition"
* . ^short = "Is the medication nephrotoxic or not."
* . ^definition = "Nefrotoksilisus"
* value[x] only boolean
* value[x] ^short = "Nephrotoxic = true, not nephrotoxic = false"
* value[x] ^definition = "Ravim nefrotoksiline jah/ei"