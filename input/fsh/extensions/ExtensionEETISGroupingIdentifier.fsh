Extension: ExtensionEETISGroupingIdentifier
Id: ee-tis-grouping-identifier
Description: "Grupeerija. Used when there is a need to group several identifiers to form viasually one line of medication but afterwards lines could be separated as well."
* ^status = #draft
* ^date = "2023-10-03T10:47:00.9373224+00:00"
* ^context.type = #element
* ^context.expression = "MedicationStatement"
* . ^short = "Used when there is a need to group several identifiers to form viasually one line of medication but afterwards lines could be separated as well."
* . ^definition = "Grupeerija. Kasutatakse juhul, kui on vajadus näidata mitme erineva identifikaatoriga ravimiskeemi read ühe reana."
* value[x] 1..
* value[x] only Identifier // or Reference
* value[x] ^short = "Identifier(s) or reference of MedicationStatement which are shown as one line"
* value[x] ^definition = "Ravimiskeemi rea identifikaator või referents, mis on kokku grupeeritud."
//* value[x] ^binding.description = "Identity System"