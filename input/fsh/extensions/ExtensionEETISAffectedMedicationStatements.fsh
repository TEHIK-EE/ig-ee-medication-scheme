Extension: ExtensionEETISAffectedMedicationStatements
Id: ee-tis-affected-medication-statements
Description: "Koostoimest mõjutatud ravimiskeemi rida.This extension is used in EETISMedicationInteraction profile to identify all medication statements which are related to interaction."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-23T08:41:33.7774358+00:00"
* ^context.type = #element
* ^context.expression = "ClinicalUseDefinition"
* . ^short = "EETIS Extension "
* . ^definition = "Kasutusel viitamaks ravimiskeemi ridadele, millel on koostoimeid."
* value[x] only Reference(EETISMedicationStatement)
* value[x] ^short = "MedicationStatement including medication which interacts with other medication"
* value[x] ^definition = "Ravimiskeemi rida, millel oleval ravimil esineb koostoime mõne teise ravimiskeemi rea ravimiga"