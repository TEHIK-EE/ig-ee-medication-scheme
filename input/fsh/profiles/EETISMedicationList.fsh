Profile: EETISMedicationList
Parent: List
Id: ee-tis-medication-list
Description: "This profile gathers patient's medications in one list for better overview of the whole medication schema"
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-01-19T13:17:15.4473399+00:00"
* . ^short = "RAVIMISKEEM"
* . ^definition = "List of patient's medication. A List is a curated collection of resources, for things such as problem lists, allergy lists, facility list, organization list, etc."
* extension contains
    ExtensionEETISConsentWithInteractions named consent 0..1
* status = #current (exactly)
* mode = #snapshot (exactly)
* contained 0..*
* title ^short = "Ravimiskeem"
* code = $list-example-codes#medications "Medication List" (exactly)
* code ^short = "Ravimiskeem - kas on vaja teha oma koodisüsteem?"
* code ^fixedCodeableConcept.text = "Medication List"
* subject 1..1
* subject only Reference(EETISPatient)
//* subject ^type.aggregation = #referenced
* encounter ..0
* source 1..
* source only Reference(EETISPractitioner or EETISPractitionerRole)
//* source ^type.aggregation = #contained
* entry.item only Reference(EETISMedicationStatement)
* entry.deleted ..0
* entry.date ^short = "When entry flag is unchanged entry date does not change. When entry flag is something else than ´unchanged´ the entry date is also changed"
* entry.date ^definition = "Entry.date kuupäev näitab seda kuupäeva, millal muudatus jõudis sinna seisu kus ta täna on. Entry.date displays the date when the entry changed."
//* entry.item ^type.aggregation = #referenced
* emptyReason ..0