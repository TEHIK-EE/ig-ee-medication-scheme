Profile: EETISMedicationInteraction
Parent: ClinicalUseDefinition
Id: ee-tis-medication-interaction
Description: "This profile is for the representation of the interactions between medication A and medication B in order to display warnings related to medications."  
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-22T14:32:30.0668499+00:00"
* contained 2..2
* contained only Medication
* type = #interaction (exactly)
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
* indication ..0
* interaction.interactant.item[x] only Reference(Medication)
//* interaction.interactant.item ^type.aggregation = #contained
//* interaction.interactant.itemCodeableConcept from $toimeained-VS (required)
* interaction.interactant.item[x] ^short = "medication B"
* interaction.type = $interaction-type#drug-drug "drug to drug interaction" (exactly)
* interaction.type ^fixedCodeableConcept.text = "drug to drug interaction"
* interaction.effect ^short = "Consequences (SYNBASE VÄLJUNDIS)"
* interaction.effect.concept ^short = "Consequences"
* interaction.effect.concept.text ^short = "KUI POLE KODEERITAV"
* interaction.effect.reference ..0
* interaction.incidence ^short = "Classification (e.g. D0)"
* interaction.incidence ^definition = "Kombinatsioon category all olevatest numbritest ja tähtedest. The incidence of the interaction, e.g. theoretical, observed."
* interaction.incidence.text ^short = "Classification"
* interaction.management ..1
* interaction.management ^short = "RECOMMENDATION (SYNBASE VÄLJUNDIS)"
* interaction.management.text ^short = "KUI POLE KODEERITAV"
* population ..0
* library ^short = "SYNBASE? Logic used by the clinical use definition"
* library ^definition = "Logic used by the clinical use definition. SYNBASE?"
* undesirableEffect ..0
* warning ..0