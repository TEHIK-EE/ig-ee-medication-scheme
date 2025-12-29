Extension: ExtensionEETISMedicationRemainder
Id: ee-tis-medication-remainder
Description: "Jääk. Extension describing how many days worth medication is left on prescription."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2023-10-03T10:47:00.9373224+00:00"
* ^context[0].type = #element
* ^context[=].expression = "MedicationStatement"
* ^context[+].type = #element
* ^context[=].expression = "MedicationDispense"
* . ^short = "Medication left on prescription calculated in days."
* . ^definition = "Arvutuslik ravimi jääk päevades."
* extension contains
    daysAvailable 0..* and
    daysDispensed 0..*
* extension[daysAvailable].value[x] only integer
* extension[daysAvailable].value[x] ^short = "How much medication calculated in days is on MedicationStatement initially before dispense. Value is to be calculated. Number of medication available changes after every dispensation."
* extension[daysAvailable].value[x] ^definition = "Ravimi algne seis ravimiskeemi real enne väljamüüki. Väärtus kuvatakse päevades. Arvutatakse taustal. Päevade arv muutub peale iga väljamüüki."
* extension[daysDispensed].value[x] only integer
* extension[daysDispensed].value[x] ^short = "How many days of medication is dispensed. Value is to be calculated. Value in days."
* extension[daysDispensed].value[x] ^definition = "Väljamüüdud ravimi kogus päevades."