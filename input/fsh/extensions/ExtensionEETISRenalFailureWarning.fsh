Extension: ExtensionEETISRenalFailureWarning
Id: ee-tis-renal-failure-warning
Description: "Nõusolek neerufunktsiooni hoiatustega. This extension is used in EETISMedicationList profile to express whether or not the practitioner adding medicines considered renal function failure warnings and consented with them."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-23T08:41:33.7774358+00:00"
* ^context.type = #element
* ^context.expression = "List"
* . ^short = "Consent with renal function warnings."
* value[x] only boolean
* value[x] ^short = "Whether or not practitioner agrees with renal function warnings. \r\n\r\nIf true indicates that practitioner is aware and agrees with warnings about renal function failure."
* value[x] ^definition = "Ravimi väljakirjutaja nõusolek neerufunktsiooni hoiatusega."