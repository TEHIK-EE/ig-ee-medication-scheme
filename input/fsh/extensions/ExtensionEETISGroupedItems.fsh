Extension: ExtensionEETISGroupedItems
Id: ee-tis-grouped-items
Description: "Grupeerija. Used when there is a need to group several items that contain data about the same line of medication prescribed to the patient."
* ^status = #draft
* ^date = "2023-10-03T10:47:00.9373224+00:00"
* ^context.type = #element
* ^context.expression = "MedicationStatement"
* . ^short = "Used when there is a need to group several items that contain data about the same line of medication prescribed to the patient."
* . ^definition = "Grupeerija. Viide ravimiskeemi reale, kus mitu ravimiskeemi rida on kokku grupeeritud."
* extension contains 
    groupingReference 0..* and 
    groupingIdentifier 0..*
* extension[groupingReference] ^short = "Reference(s) of MedicationStatement which are shown as one line"
* extension[groupingReference] ^definition = "Ravimiskeemi rea referents(id), mis on kokku grupeeritud."
* extension[groupingReference].value[x] only Reference(EETISMedicationStatement)
* extension[groupingIdentifier] ^short = "Identifier(s) of MedicationStatement which are shown as one line"
* extension[groupingIdentifier] ^definition = "Ravimiskeemi rea identifikaator(id), mis on kokku grupeeritud."
* extension[groupingIdentifier].value[x] only Identifier
* extension[groupingIdentifier].valueIdentifier.system = $retseptikeskus-retsept 