Extension: ExtensionEETISVerification
Id: ee-tis-verification
Description: "This extension is used for the verification of the MedicationStatement - when practitioner changes, adds or deletes anything in patient's medication scheme it must be verified with date and id of the practitioner."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-23T08:41:33.7774358+00:00"
* ^context.type = #element
* ^context.expression = "MedicationStatement"
* extension contains
    verificationTime 0..* and
    verificationAuthor 0..*
* extension[verificationTime].value[x] only dateTime
* extension[verificationTime].value[x] ^short = "Verification time"
* extension[verificationTime].value[x] ^definition = "Time when practitioner confirms the changes he/she makes in MedicationStatement. Value of extension - must be one of a constrained set of the data types (see [Extensibility](extensibility.html) for a list)."
* extension[verificationAuthor].value[x] only Reference(EETISPractitionerRole)
* extension[verificationAuthor].value[x] ^short = "Verification author"
* extension[verificationAuthor].value[x] ^definition = "The author who verifies the changes made in MedicationStatement. Value of extension - must be one of a constrained set of the data types (see [Extensibility](extensibility.html) for a list)."