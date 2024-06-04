Extension: ExtensionEETISPrescriptionValidityTime
Id: ee-tis-prescription-validity-time
Description: "Retsepti kehtivuse lõpu aeg ravimiskeemi rea kontekstis. Validity end date of a prescription in a MedicationStatement."
* ^status = #draft
* ^context.type = #element
* ^context.expression = "MedicationStatement"
* . ^short = "Validity end date of the prescription(s) in one MedicationStatement."
* . ^definition = "Retsepti kehtivuse lõpu aeg."
* value[x] only dateTime
* value[x] ^short = "Validity end date of the prescription(s) in one MedicationStatement"
* value[x] ^definition = "Ravimiskeemi reaga seotud retsepti kehtivuse lõpp kuupäeva täpsusega."