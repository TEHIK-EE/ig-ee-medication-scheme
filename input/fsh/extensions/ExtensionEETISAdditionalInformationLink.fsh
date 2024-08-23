Extension: ExtensionEETISAdditionalInformationLink
Id: ee-tis-additional-information-link
Description: "Link lisa-infole. Link which takes to another page including additional and more detailed information about the topic."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-08-23T08:41:33.7774358+00:00"
* ^context.type = #element
* ^context.expression = "ClinicalUseDefinition"
* . ^short = "Additional information from external source."
* . ^definition = "Link mis viib lehele, kus on teemast rohkem ja täpsemat informatsiooni."
* value[x] only string
* value[x] ^short = "URL of external information source."
* value[x] ^definition = "Link mis viib lehele, kus on teemast rohkem ja täpsemat informatsiooni. Näiteks SynBase lehele link."