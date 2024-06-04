Extension: ExtensionEETISPrescriptionIntent
Id: ee-tis-prescription-intent
Description: " Kas retsept on \"order\" või \"proposal\". Viimane on müügiloata ravimite puhul. Intent of prescription."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-23T10:56:02.4427313+00:00"
* ^context.type = #element
* ^context.expression = "MedicationStatement"
* value[x] only code
* value[x] from $medicationrequest-intent-VS (preferred)
* value[x] ^short = "proposal | plan | order | original-order | reflex-order | filler-order | instance-order | option\r\n\r\nWhether the request is a proposal, plan, or an original order."
* value[x] ^definition = "Tavaline retsept on \"order\", müügiloata ravimi retsept on alguses \"proposal\". "