Extension: ExtensionEETISMedicinalProductName
Id: ee-tis-medicinal-product-name
Description: "Ravimi nimi. Registered name for the medicinal product."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2023-10-03T10:47:00.9373224+00:00"
* ^publisher = "TEHIK"
* ^contact[0].name = "TEHIK"
* ^contact[=].telecom[0].system = #url
* ^contact[=].telecom[=].value = "https://www.tehik.ee"
* ^contact[=].telecom[+].system = #email
* ^contact[=].telecom[=].value = "fhir@tehik.ee"
* ^contact[=].telecom.use = #work
* ^jurisdiction = urn:iso:std:iso:3166#EE "Estonia"
* ^context.type = #element
* ^context.expression = "Medication"
* . ^short = "Registered name for the medicinal product."
* . ^definition = "Ravimi nimi pakendil. Näiteks 'Betaloc ZOC' või 'Sudafed' jne"
* value[x] 1..
* value[x] only string
* value[x] ^maxLength = 500