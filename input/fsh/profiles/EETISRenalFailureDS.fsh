/*Profile: EETISRenalFailureDS
Parent: ClinicalUseDefinition
Id: ee-tis-renal-failure-ds
Description: "Neerufuntsiooni puudulikkuse otsustustoe vastus. This profile is for the representation of patient's renal function failure and alerts about it so the medication can be adjusted according to failure degree."  
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-22T14:32:30.0668499+00:00"
* contained 1..1
* contained only Medication
* type = #undesirable-effect (exactly)
* extension contains
    ExtensionEETISAffectedMedicationStatements named affected 0..* and
    ExtensionEETISAdditionalInformationLink named link 0..* and
    ExtensionEETISNephrotoxic named nephrotoxic 0..* and
    ExtensionEETISDosageModification named dosageModification 0..*
* category ^slicing.discriminator.type = #value
* category ^slicing.discriminator.path = "this" //katsetus - enne oli $this ja value
* category ^slicing.rules = #open
* category ^short = "RenBase drugFormGroup ja failureDegree"
* category contains
    drugFormGroup 0..1 and
    failureDegree 0..1 and
    additionalInformation 0..1
* category[drugFormGroup] ^short = "0 | 1 | 2 | 3 | 4 | 5| This is a list of different drug form groups."
* category[drugFormGroup] from $drug-form-group-VS
//* category[ClinicalImportance] only text //meelega vale katsetamiseks//
//* category[sliceScientificDocumentation] from $scientific-documentation-category-VS (required)
//* category[failureDegree] ^binding.description = "siia ilmselt mingi koodisüsteem?"
* category[failureDegree] ^short = "This is categorization of the renal failure degree and the description "
* category[failureDegree].text ^short = "0 | 1 | 2 | 3 | 4. Kas siia tuleb koodisüsteem? Kui ei siis tekstina"
* category[additionalInformation].text ^short = "Siia tuleb lisainfot juhul kui see failure degree texti alla ei mahu."
//* category[additionalInformation] ^short = "Any additional information"
* subject 1..
* subject only Reference(Medication)
* subject ^short = "medication that may cause renal function failure"
//* subject.identifier ..1
//* subject.identifier ^short = "siia tuleb referents toimeainete loendile?"
* subject.display = "Name of the medication/active inredient. Siia toimeaine nimetus"
* contraindication ..0
* indication 0..0
* undesirableEffect ^short = "Classification A/B/C/D and description how the dosage must be adjusted"
* undesirableEffect ^definition = "Klassifikatsioon RenBase järgi ja kirjeldus kui palju annust tuleks muuta" 
* undesirableEffect.classification ^short = "klassifikatsioon (A/B/C/D) + selle tekst nt C, text: Annust või annustamise vahemikku tuleb kohandada"
* undesirableEffect.symptomConditionEffect.reference ^short = "Reference to a eGFR as an observation"
* undesirableEffect.symptomConditionEffect.reference ^definition = "Siia tuleb referents eGFR näidule mis on hoiatuse aluseks"
* undesirableEffect.symptomConditionEffect only CodeableReference(ObservationDefinition)
//* warning.description ^short = "Additional information about renal function failure caused by this medication. LISAINFO teksti kujul (võib olla pikem tekst)"
//* warning.description ^definition = "lisainfo teksti kujul (võib olla pikem tekst)"
//* warning.code ^short = "failureDegree"
//* warning.code ^definition = "Neerupuudulikkuse aste: number + selgitus:"
//* warning.code.text = "Kuniks pole loendit, siis number ja selgitus mõlemad teksti alla. Kui tuleb loend siis number code alla ja selgitus teksti"
//* interaction.interactant.item[x] only Reference(Medication)
//* interaction.interactant.item ^type.aggregation = #contained
//* interaction.interactant.itemCodeableConcept from $toimeained-VS (required)
//* interaction.interactant.item[x] ^short = "medication B"
//* interaction.type = $interaction-type#drug-drug "drug to drug interaction" (exactly)
//* interaction.type ^fixedCodeableConcept.text = "drug to drug interaction"
//* interaction.effect ^short = "Consequences (SYNBASE)"
//* interaction.effect.concept ^short = "Consequences"
//* interaction.effect.concept.text ^short = "If not codeable, use text to represent consequenses"
//* interaction.effect.reference ..0
//* interaction.incidence ^short = "Classification (SYNBASE. e.g. D0)"
//* interaction.incidence ^definition = "Kombinatsioon category all olevatest numbritest ja tähtedest. The incidence of the interaction, e.g. theoretical, observed."
//* interaction.incidence.text ^short = "Classification"
//* interaction.management ..1
//* interaction.management ^short = "Recommendation (SYNBASE)"
//* interaction.management.text ^short = "If not codeable, use text to represent recommendation"
* population ..0
* library ..0
*/