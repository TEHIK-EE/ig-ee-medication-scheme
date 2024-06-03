Extension: ExtensionEETISMedicationRemainder
Id: ee-tis-medication-remainder
Description: "Jääk. Extension describing how much medication is left on prescription."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2023-10-03T10:47:00.9373224+00:00"
* ^context.type = #element
* ^context.expression = "MedicationStatement"
* . ^short = "How much medication is left on prescription."
* . ^definition = "Jääk. "
* value[x] only integer
* value[x] ^short = "How much medication is left on one MedicationStatement. Value is to be calculated."
* value[x] ^definition = "Ravimi jääk ravimiskeemi real."