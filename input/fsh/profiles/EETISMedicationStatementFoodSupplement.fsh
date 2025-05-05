Profile: EETISMedicationStatementFoodSupplement
Parent: MedicationStatement
Id: ee-tis-medication-statement-food-supplement
Description: "Ravimiskeemi rida toidulisandile. Medication Statement for (patient reported) food supplements."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-23T10:56:02.4427313+00:00"
* text ^short = "MedicationStatement is part of Medication Scheme representing one treatmentline"
* contained 0..*
* extension contains
    ExtensionEETISCancelledStatusReason named extensionEETISCancelledStatusReason 0..1 and // täidetakse ainult ravimiskeemi rea kustutamisel
    ExtensionEETISVerification named extensionEETISVerification 0..* and
    ExtensionEETISPrescriptionChange named ExtensionEETISPrescriptionChange 0..* and
    ExtensionEETISGroupedItems named ExtensionEETISGroupedItems 0..*
* extension[extensionEETISVerification] ^definition = "Optional Extension Element - found in all resources."
* partOf only Reference(EETISMedicationStatement)
* status ^definition = "recorded = Kinnitatud; draft = Kinnitamata. Retseptikeskuse retsepti põhjal genereeritud kinnitamata rida on staatuses recorded/kinnitatud."
* status ^short = "A code representing the status of recording the medication statement. recorded = KINNITATUD; draft = KINNITAMATA"
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains
    courseOfTherapyType 0..1
* category[courseOfTherapyType] from $ravikuuri-tyyp-VS (required)
* category[courseOfTherapyType] ^short = "What type of medication course is"
* category[courseOfTherapyType] ^binding.description = "RAVIKUURI TÜÜP. LOEND. pidev | fikseeritud | vajadusel | muutuv | ühekordne |"
* medication only CodeableReference(Medication or EETISMedicationEPC)
//* medication ^type.aggregation = #referenced
//* medication.concept ..0
//* medication.reference only Reference(EETISMedicationEPC or EETISMedicationExtemporal)
//* medication.reference ^type.aggregation = #referenced
* medication.reference.display ^short = "Patient reported food supplement in free form text. This is in use until there is no integration with food supplement database jvis.agri.ee"
* medication.reference.display ^definition = "Patsiendi sõnul toidulisandid on vabatekstina kuniks pole liidestust toidulisandite andmebaasiga jvis.argri.ee"
* subject only Reference($ee-mpi-patient)
//* subject ^type.aggregation = #referenced
* encounter ..0
* effective[x] 0..1
* effective[x] only Period
* effective[x] ^short = "Time period when the treatment line begins and ends"
* effective[x] ^definition = "Ravimiskeemi rea kehtivuse algus"
* informationSource only Reference(EETISPractitioner or EETISPractitionerRole)
* informationSource ^short = "Initial author of the MedicationStatement. The person or organization that provided the information about the taking of this medication. Note: Use derivedFrom when a MedicationStatement is derived from other resources, e.g. Claim or MedicationRequest."
* informationSource ^definition = "AUTOR KES KOOSTAB RAVIMISKEEMI REA (arst). Ravimiskeemi rea (algne) koostaja."
* note ^definition = "Provides extra information about the Medication Statement that is not conveyed by the other attributes."
* note ^short = "Siia saab kirjutada märkusi ravimiskeemi rea kohta."
* note.author[x] 0..
* note.author[x] only string or Reference(EETISPractitionerRole or EETISPractitioner)
* relatedClinicalInformation ..0
* dosage only EETISDosage
* dosage.patientInstruction ^short = "Comments or remarks about the food supplements that patient reports."
* dosage.patientInstruction ^definition = "Märkused ja kommentaarid patsiendi sõnul toidulisandite kohta."
* adherence ..0