Extension: ExtensionEETISMedicationSchemeVerificationTime
Id: ee-tis-medication-scheme-verification-time
Description: "See extension on vajalik väljendamaks seda, kui patsiendil on kunagi varasemalt tehtud ravimiskeemi kinnitamine. Kui ravimiskeem on koostatud AINULT Retseptikeskuse andmete pealt, siis see extension puudub. This extension is needed to express that the patient has medication scheme verification at some point of time in the past. If the medication scheme has been compiled ONLY from Prescription Centre data, this extension is absent."
* ^status = #draft
* ^context.type = #element
* ^context.expression = "List"
* . ^short = "Date when medication scheme was confirmed. If absent then scheme is based on prescription centre data only."
* . ^definition = "Ravimiskeemi kinnitamise aeg."
* value[x] only dateTime
* value[x] ^short = "Date of confirmed medication scheme."
* value[x] ^definition = "Ravimiskeemi kinnitamise aeg."