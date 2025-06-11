Extension: ExtensionEETISDosageModification
Id: ee-tis-dosage-modification
Description: "Annustamise soovitused. Recommendation for dosaging"
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-08-23T08:41:33.7774358+00:00"
* ^context.type = #element
* ^context.expression = "ClinicalUseDefinition"
* . ^short = "Recommendation for dosaging"
* . ^definition = "Annustamise soovitused."
* extension contains
    dosageIntervalMin 0..1 and
    dosageIntervalMax 0..1 and
    recommendation 0..1
* extension[dosageIntervalMin].value[x] only SimpleQuantity
* extension[dosageIntervalMin].value[x] ^short = "Minimum dosage interval in hours"
* extension[dosageIntervalMin].value[x] ^definition = "Minimaalne annustamiseintervall tundides"
* extension[dosageIntervalMax].value[x] only SimpleQuantity
* extension[dosageIntervalMax].value[x] ^short = "Maximum dosage interval in hours"
* extension[dosageIntervalMax].value[x] ^definition = "Maksimaalne annustamiseintervall tundides"
* extension[recommendation].value[x] only string
* extension[recommendation].value[x] ^short = "Recommendation how to reduce undesired effect of medication"
* extension[recommendation].value[x] ^definition = "Soovitused annustamiseks"


