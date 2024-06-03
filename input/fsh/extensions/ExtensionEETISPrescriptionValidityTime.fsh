Extension: ExtensionEETISPrescriptionValidityTime
Id: ee-tis-prescription-validity-time
Description: "Retsepti kehtivuse lõpu aeg ravimiskeemi rea kontekstis. Validity end date of a prescription in a MedicationStatement."
* ^status = #draft
* ^context.type = #element
* ^context.expression = "MedicationStatement"
* . ^short = "Retsepti kehtivuse lõpu aeg."
* . ^definition = "For expressing the validity end date of the prescription(s) in one MedicationStatement."
* value[x] only dateTime
* value[x] ^short = "Retsepti kehtivuse lõpp kuupäeva täpsusega"
* value[x] ^definition = "Ravimiskeemi reaga seotud retsepti kehtivuse lõpp."