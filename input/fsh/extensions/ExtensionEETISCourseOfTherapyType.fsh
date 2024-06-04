Extension: ExtensionEETISCourseOfTherapyType
Id: ee-tis-course-of-therapy-type
Description: "Ravikuuri tüüp. Defines the type of medication course."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2023-11-09T07:13:13.2413582+00:00"
* ^context.type = #element
* ^context.expression = "MedicationRequest"
* . ^short = "Defines whether the medication course is fixed or continuous etc."
* value[x] only CodeableConcept
* value[x] from $ravikuuri-tyyp-VS (preferred)
* value[x] ^short = "Course of therapy type. \r\npidev | fikseeritud | vajadusel | muutuv | ühekordne"
* value[x] ^definition = "Ravikuuri tüüp valitakse loendist iga retseptiravimi kohta eraldi."
//* value[x].coding from $ravikuuri-tyyp-VS (preferred)
//* value[x].coding ^binding.description = "Ravikuuri tüüp"