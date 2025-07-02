Extension: ExtensionEETISRelatedObservationOrCondition
Id: ee-tis-related-observation-or-condition
Description: "Seotud analüüs/test/uuring, mis on võib mõjutada neerufunktsiooni.This extension is used in to express renal function related observation/condition."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-23T08:41:33.7774358+00:00"
* ^context.type = #element
* ^context.expression = "ClinicalUseDefinition"
* . ^short = "Observation/Condition which triggers renal function alert."
* . ^definition = "Kasutusel viitamaks observationile/conditionile, mis mõjutavad neerufunktsiooni."
* value[x] only Reference(EETISObservationEGFR or Condition)
* value[x] ^short = "Observation/Condition which may trigger renal function alerts"
* value[x] ^definition = "Observation/condition, mis kutsub esile neerufunktisooni muutuse languse ning määratud ravim võib vajada korrigeerimist"