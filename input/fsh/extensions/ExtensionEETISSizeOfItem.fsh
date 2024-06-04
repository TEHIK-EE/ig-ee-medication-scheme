Extension: ExtensionEETISSizeOfItem
Id: ee-tis-size-of-item
Description: "Pakkeühiku suurus. Size of medicinal product item (3ml)."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2023-10-03T10:47:00.9373224+00:00"
* ^publisher = "TEHIK"
* ^contact[0].name = "TEHIK"
* ^contact[=].telecom[0].system = #url
* ^contact[=].telecom[=].value = "https://www.tehik.ee"
* ^contact[=].telecom[+].system = #email
* ^contact[=].telecom[=].value = "fhir@tehik.ee"
* ^jurisdiction = urn:iso:std:iso:3166#EE "Estonia"
* ^context.type = #element
* ^context.expression = "Medication"
* . ^short = "Size of medicinal product item (3ml). E.g. total volume of packaged medication is 30ml but it includes 10 items 3ml each."
* . ^definition = "Pakkeühiku suurus"
* value[x] only SimpleQuantity
* value[x] ^short = "Size of medicinal product item"
* value[x] ^definition = "Pakkeühiku suurus (3ml). Näiteks pakendi kogumaht on 30ml aga see sisaldab 10 pakkeühikut suuruses 3ml."