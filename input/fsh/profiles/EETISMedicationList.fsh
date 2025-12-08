Profile: EETISMedicationList
Parent: List
Id: ee-tis-medication-list
Description: "Ravimiskeem. This profile gathers patient's medications in one list for better overview of the whole medication scheme"
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-01-19T13:17:15.4473399+00:00"
* . ^short = "Medication scheme. List of patient's medication."
* . ^definition = "RAVIMISKEEM"
* extension contains
    ExtensionEETISConsentWithInteractions named consent 0..1 and
    ExtensionEETISRenalFailureWarning named renalFailureWarning 0..1
* status = #current (exactly)
* mode = #snapshot (exactly)
* contained 0..*
* title ^short = "Medication Scheme"
* title ^definition = "Ravimiskeem"
* code = $list-example-codes#medications "Medication List" (exactly)
* code ^short = "Ravimiskeem"
* code ^definition = "kas on vaja teha oma koodisüsteem? Lahtine küsimus tuleviku aruteludeks"
* code ^fixedCodeableConcept.text = "Medication List"
* subject 1..1
* subject only Reference($ee-mpi-patient)
//* subject ^type.aggregation = #referenced
* encounter ..0
* source 1..
* source only Reference($ee-practitioner or EETISPractitionerRole)
//* source ^type.aggregation = #contained
* note 0..1
* note only EETISAnnotation
* entry 0..*
* entry.item only Reference(EETISMedicationStatement)
* entry.deleted ..0
* entry.flag only CodeableConcept
* entry.flag from $list-item-flag-VS (preferred)
* entry.flag ^short = "Entry flag VS is a combination of two CS (HL7 and local CS). Use flag to indicate whether the medication schema line is changed, unchanged, grouped etc."
* entry.date ^short = "When entry flag is unchanged entry date does not change. When entry flag is something else than ´unchanged´ the entry date is also changed"
* entry.date ^definition = "Entry.date kuupäev näitab seda kuupäeva, millal muudatus jõudis sinna seisu kus ta täna on. Entry.date displays the date when the entry changed."
//* entry.item ^type.aggregation = #referenced
* emptyReason ..0
