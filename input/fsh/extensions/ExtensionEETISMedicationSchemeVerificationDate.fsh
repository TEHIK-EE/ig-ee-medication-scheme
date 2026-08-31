Extension: ExtensionEETISMedicationSchemeVerificationDate
Id: ee-tis-medication-scheme-verification-date
Description: "Kas patsiendil on üldse KUNAGI tehtud ravimiskeemi kinnitamine või on ravimiskeem koostatud AINULT retseptikeskuse andmete pealt. Whether patient has ever had confirmed medication scheme or is the scheme compiled based on prescription centre's prescriptions."
* ^status = #draft
* ^context.type = #element
* ^context.expression = "List"
* . ^short = "Date when medication scheme was confirmed."
* . ^definition = "Ravimiskeemi kinnitamise kuupäev."
* value[x] only dateTime
* value[x] ^short = "Date of confirmed medication scheme."
* value[x] ^definition = "Ravimiskeemi kinnitamise kuupäev."