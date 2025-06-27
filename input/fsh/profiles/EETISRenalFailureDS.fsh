Instance: FixedDrugFormGroupCoding
InstanceOf: Coding
Usage: #inline
Title: "Fixed Coding for Drug Form Group"
* system = "https://fhir.ee/CodeSystem/drug-form-group"

Instance: FixedFailureDegreeCoding
InstanceOf: Coding
Usage: #inline
Title: "Fixed Coding for Failure Degree"
* system = "https://fhir.ee/CodeSystem/failure-degree"

Instance: FixedAdditionalInformationCoding
InstanceOf: Coding
Usage: #inline
Title: "Fixed Coding for Additional Information"
* system = "https://fhir.ee/CodeSystem/additional-information"

Profile: EETISRenalFailureDS
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
* category ^slicing.discriminator.path = "coding" //katsetus - enne oli $this ja value
* category ^slicing.rules = #open
* category ^short = "RenBase drugFormGroup ja failureDegree"
* category contains
    drugFormGroup 0..1 and
    failureDegree 0..1 and
    additionalInformation 0..1
* category[drugFormGroup].coding ^short = "0 | 1 | 2 | 3 | 4 | 5| This is a fake CS for example. Do NOT use it!"
//* category[drugFormGroup].coding 1..1
* category[drugFormGroup].coding = FixedDrugFormGroupCoding //{system: "https://fhir.ee/CodeSystem/drug-form-group"} //$drug-form-group-VS
//* category[drugFormGroup].coding[0].code = "suva1"
//* category[drugFormGroup].text MS // = "free text answer"
* category[failureDegree].coding ^short = "Failure degree 0-4. Neerupuudulikkuse aste: number + selgitus. This is a fake CS for example. Do NOT use it! Sellist CS ei eksisteeri! testimiseks."
//* category[failureDegree].coding 1..1 //see on siia kunstlikult pandud. ^binding.description = "siia miskit????KAS TULEB CS?"
* category[failureDegree].coding = FixedFailureDegreeCoding //{system: "https://fhir.ee/CodeSystem/failure-degree"} //$failure-degree-VS
//* category[failureDegree].coding[0].code = "suva"
//* category[failureDegree].text MS //= "free text answer"
//* category.text[failureDegree] ^short = "Filled with information from RenBase. This is categorization of the renal failure degree and the description"
//* category[additionalInformation].coding 1..1
* category[additionalInformation].coding = FixedAdditionalInformationCoding //{system: "https://fhir.ee/CodeSystem/additional-information"} //$additional-information-VS //^binding.description = "siia miskit????KAS TULEB CS?"
//* category[additionalInformation].coding[0].code = "cas"
//* category[additionalInformation].text MS //= "ossapoiss"
* category[additionalInformation].coding ^short = "This is a fake CS for example. Do NOT use it! Sellist CS ei eksisteeri! testimiseks."
//* category.text[additionalInformation] ^short = "Filled with any additional information from RenBase"
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
* population ..0
* library ..0