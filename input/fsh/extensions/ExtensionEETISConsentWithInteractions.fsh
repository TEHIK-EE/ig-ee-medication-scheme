Extension: ExtensionEETISConsentWithInteractions
Id: ee-tis-consent-with-interactions
Description: "Nõusolek koostoimetega ning neerufunktsiooni hiatustega. This extension is used in EETISMedicationList profile to express whether or not the practitioner adding medicines considered the interactions (or renal function failure warnings) and consented with them."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-23T08:41:33.7774358+00:00"
* ^context.type = #element
* ^context.expression = "List"
* . ^short = "Consent with medication interactions and renal function warnings."
* value[x] only boolean
* value[x] ^short = "Whether or not practitioner agrees with interactions or renal function warnings. \r\n\r\nIf true indicates that practitioner is aware and agrees with medication interactions or warnings about renal function failure."
* value[x] ^definition = "Ravimi väljakirjutaja nõusolek koostoimetega või neerufunktsiooni hoiatusega."