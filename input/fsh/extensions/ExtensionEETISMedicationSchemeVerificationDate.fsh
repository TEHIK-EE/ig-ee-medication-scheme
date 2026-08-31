Extension: ExtensionEETISMedicationSchemeVerificationTime
Id: ee-tis-medication-scheme-verification-time
Description: "Kas patsiendil on KUNAGI tehtud ravimiskeemi kinnitamine (aeg) või on ravimiskeem koostatud AINULT retseptikeskuse andmete pealt. Whether patient has ever had confirmed medication scheme or is the scheme compiled based on prescription centre's prescriptions."
* ^status = #draft
* ^context.type = #element
* ^context.expression = "List"
* . ^short = "Date when medication scheme was confirmed."
* . ^definition = "Ravimiskeemi kinnitamise aeg."
* value[x] only dateTime
* value[x] ^short = "Date of confirmed medication scheme."
* value[x] ^definition = "Ravimiskeemi kinnitamise aeg."