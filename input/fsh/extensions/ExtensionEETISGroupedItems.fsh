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
* extension[groupingReference].value[x] only Reference(EETISMedicationStatement or EETISMedicationStatementOTC or EETISMedicationStatementFoodSupplement)
* extension[groupingIdentifier] ^short = "Identifier(s) of MedicationStatement which are shown as one line"
* extension[groupingIdentifier] ^definition = "Ravimiskeemi rea identifikaator(id), mis on kokku grupeeritud."
* extension[groupingIdentifier].value[x] only Identifier
* extension[groupingIdentifier].valueIdentifier.system = $retseptikeskus-retsept 
/** extension[groupingIdentifier].system = https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid
 value[x] ^short = "Identifier(s) or reference of MedicationStatement which are shown as one line"
* value[x] ^definition = "Ravimiskeemi rea identifikaator või referents, mis on kokku grupeeritud."
 value[x] ^binding.description = "Identity System"

Extension: MyExtension
Id: my-extension
Title: "My Extension"
Description: "My extension with a reference and list of strings"
Context: Patient // or whatever
* extension contains reference 0..1 and strings 0..1
* extension[reference].value[x] only Reference // or Reference(Observation), etc.
* extension[strings].extension contains string 1..*
* extension[strings].extension[string].value[x] only string

Instance: MyPatient
InstanceOf: Patient
* name.given = "Bob"
* extension[MyExtension]
  * extension[reference].valueReference = Reference(Observation/123)
  * extension[strings]
    * extension[string][+].valueString = "abc"
    * extension[string][+].valueString = "def"
    * extension[string][+].valueString = "ghi"
*/