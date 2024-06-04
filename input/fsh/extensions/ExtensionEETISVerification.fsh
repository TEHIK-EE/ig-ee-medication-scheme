Extension: ExtensionEETISVerification
Id: ee-tis-verification
Description: "Kinnitamine. This extension is used for the verification of the MedicationStatement - when practitioner changes, adds or deletes anything in patient's medication scheme it must be verified with date and id of the practitioner."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-23T08:41:33.7774358+00:00"
* ^context.type = #element
* ^context.expression = "MedicationStatement"
* . ^short = "Verification of medication scheme"
* . ^definition = "Ravimiskeemi rea kinnitamine"
* extension contains
    verificationTime 0..* and
    verificationAuthor 0..*
* extension[verificationTime].value[x] only dateTime
* extension[verificationTime].value[x] ^short = "Verification time"
* extension[verificationTime].value[x] ^definition = "Kinnitamise aeg. Time when practitioner confirms the changes he/she makes in MedicationStatement."
* extension[verificationAuthor].value[x] only Reference(EETISPractitionerRole)
* extension[verificationAuthor].value[x] ^short = "Verification author"
* extension[verificationAuthor].value[x] ^definition = "Ravimiskeemi kinnitaja. The author who verifies the changes made in MedicationStatement."