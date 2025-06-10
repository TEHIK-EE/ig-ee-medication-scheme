/*Profile: EETISRenalFailureDS
Parent: ClinicalUseDefinition
Id: ee-tis-renal-failure-ds
Description: "Neerufuntsiooni puudulikkuse otsustustugi. This profile is for the representation of patient's renal function failure and alerts about it so the medication can be adjusted according to failure degree."  
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-22T14:32:30.0668499+00:00"
* contained 2..2
* contained only Medication
* type = #indication (exactly)
* extension contains
    ExtensionEETISAffectedMedicationStatements named affected 0..* and
    ExtensionEETISAdditionalInformationLink named link 0..*
// * category ^slicing.discriminator.type = #value
// * category ^slicing.discriminator.path = "$this" //katsetus - enne oli $this ja value
// * category ^slicing.rules = #open
// * category ^short = "Koostoime väljendamine tähe ja numbriga"
// * category contains
//    ClinicalImportance 0..* and
//    ScientificDocumentation 0..*
//* category[sliceClinicalImportance] from $clinical-importance-category-VS (required)
// * category[ClinicalImportance] ^short = "A | B | C | D "
//* category[sliceClinicalImportance] ^binding.description = "Clinical importance code (ABCD)"
//* category[ClinicalImportance] only text //meelega vale katsetamiseks//
//* category[sliceScientificDocumentation] from $scientific-documentation-category-VS (required)
//* category[sliceScientificDocumentation] ^binding.description = "Scientific documentation code (01234)"
// * category[ScientificDocumentation] ^short = "0 | 1 | 2 | 3 | 4"
//* category[ScientificDocumentation] only text
//* extension[extensionEETISAdditionalInformationLink] ^definition = "Link to SynBase for additional information about interaction."
* subject 1..
* subject only Reference(Medication)
* subject ^short = "medication A"
* subject.identifier ..1
//* subject.identifier ^short = "siia tuleb referents toimeainete loendile?"
* subject.display = "siia toimeaine nimetus"
* contraindication ..0
* indication 1..1
* interaction.interactant.item[x] only Reference(Medication)
//* interaction.interactant.item ^type.aggregation = #contained
//* interaction.interactant.itemCodeableConcept from $toimeained-VS (required)
* interaction.interactant.item[x] ^short = "medication B"
* interaction.type = $interaction-type#drug-drug "drug to drug interaction" (exactly)
* interaction.type ^fixedCodeableConcept.text = "drug to drug interaction"
* interaction.effect ^short = "Consequences (SYNBASE)"
* interaction.effect.concept ^short = "Consequences"
* interaction.effect.concept.text ^short = "If not codeable, use text to represent consequenses"
* interaction.effect.reference ..0
* interaction.incidence ^short = "Classification (SYNBASE. e.g. D0)"
* interaction.incidence ^definition = "Kombinatsioon category all olevatest numbritest ja tähtedest. The incidence of the interaction, e.g. theoretical, observed."
* interaction.incidence.text ^short = "Classification"
* interaction.management ..1
* interaction.management ^short = "Recommendation (SYNBASE)"
* interaction.management.text ^short = "If not codeable, use text to represent recommendation"
* population ..0
* library ..0
* undesirableEffect ..0
* warning ..0
*/