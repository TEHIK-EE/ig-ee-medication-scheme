Profile: EETISMedicationStatementOTC
Parent: MedicationStatement
Id: ee-tis-medication-statement-otc
Description: "Ravimiskeemi rida käsimüügiravimi puhul. Medication Statement for over-the-counter medications."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-23T10:56:02.4427313+00:00"
* text ^short = "MedicationStatement is part of Medication Scheme representing one treatmentline. OTC medications are also part of Medication Scheme."
* contained 0..*
* extension contains
    ExtensionEETISCancelledStatusReason named extensionEETISCancelledStatusReason 0..1 and // täidetakse ainult ravimiskeemi rea kustutamisel
    ExtensionEETISTotalPrescribedAmount named extensionEETISTotalPrescribedAmount 0..* and
    ExtensionEETISVerification named extensionEETISVerification 0..* and
    ExtensionEETISSubstitution named extensionEETISSubstitution 0..1 and
    ExtensionEETISPrescriptionIntent named extensionEETISPrescriptionIntent 0..* and
    ExtensionEETISPrescriptionChange named ExtensionEETISPrescriptionChange 0..*
* extension[extensionEETISVerification] ^definition = "Optional Extension Element - found in all resources."
* partOf only Reference(EETISMedicationStatement)
* status ^definition = "recorded = Kinnitatud; draft = Kinnitamata. Retseptikeskuse retsepti põhjal genereeritud kinnitamata rida on staatuses recorded/kinnitatud."
* status ^short = "A code representing the status of recording the medication statement. recorded = KINNITATUD; draft = KINNITAMATA"
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains
    courseOfTherapyType 1..* and
    statementOriginCategory 0..*
* category[courseOfTherapyType] from $ravikuuri-tyyp-VS (required)
* category[courseOfTherapyType] ^short = "What type of medication course is"
* category[courseOfTherapyType] ^binding.description = "RAVIKUURI TÜÜP. LOEND. pidev | fikseeritud | vajadusel | muutuv | ühekordne |"
* category[statementOriginCategory] from $ravimi-andmete-tyyp-VS (required)
* category[statementOriginCategory] ^short = "Category defining the origin of MedicationStatement. USED ONLY when medication scheme line is based on patient's statement."
* category[statementOriginCategory] ^definition = "Seda kategooriat kasutada AINULT juhul, kui ravimiskeemi rida genereeritakse patsiendi sõnul. Kasutada koodi |ASK| loendist ravimi-andmete-tyyp. Retseptikeskuse retseptidest loodud ravimiskeemi rea puhul jääb see kategooria TÜHJAKS."
* category[statementOriginCategory] ^binding.description = "Category defining the origin of MedicationStatement. Use only code |ASK| from ValueSet ravimi-andmete-tyyp."
//* category[statementOriginCategory] = $ravimi-andmete-tyyp-VS#ASK "ütluspõhine ravim" (exactly)
//* category[statementOriginCategory] ^fixedCodeableConcept.text = "|ASK| ütluspõhine ravim"
* medication only CodeableReference(EETISMedicationEPC or EETISMedicationExtemporal)
//* medication ^type.aggregation = #referenced
//* medication.concept ..0
//* medication.reference only Reference(EETISMedicationEPC or EETISMedicationExtemporal)
//* medication.reference ^type.aggregation = #referenced
* subject only Reference($ee-mpi-patient)
//* subject ^type.aggregation = #referenced
* encounter ..0
* effective[x] 1..1
* effective[x] only Period
* effective[x] ^short = "Time period when the treatment line begins and ends."
* effective[x] ^definition = "Ravimiskeemi rea kehtivuse algus"
* informationSource only Reference(EETISPractitioner or EETISPractitionerRole)
* informationSource ^short = "Initial author of the MedicationStatement. The person or organization that provided the information about the taking of this medication. Note: Use derivedFrom when a MedicationStatement is derived from other resources, e.g. Claim or MedicationRequest."
* informationSource ^definition = "AUTOR KES KOOSTAB RAVIMISKEEMI REA (arst). Ravimiskeemi rea (algne) koostaja."
* reason ^definition = "Diagnoosikoodid (RHK-10)\r\nDIAGNOOSIKOOD retseptikeskusest"
* reason from $rhk-10-VS (preferred)
* reason ^short = "Diagnose for medication. ICD-10 codes from Estonian Prescription Centre. Reimbursement of medication depends on which ICD-10 code is used."
//* reason ^binding.description = "Diagnoosikood RHK-10"
//* reason.reference ..0
* note ^definition = "Provides extra information about the Medication Statement that is not conveyed by the other attributes."
* note ^short = "Siia saab kirjutada märkusi ravimiskeemi rea kohta."
* note.author[x] 1..
* note.author[x] only string or Reference(EETISPractitionerRole or EETISPractitioner)
* relatedClinicalInformation ..0
* dosage only EETISDosage
* dosage ^short = "Indicates how the medication is/was or should be taken by the patient."
* dosage ^definition = "ANNUSTAMISEJUHIS"
* dosage.additionalInstruction ^definition = "VALMISTAMISEJUHIS"
* dosage.additionalInstruction ^short = "Supplemental instructions to the patient on how to take the medication  (e.g. \"with meals\" or\"take half to one hour before food\") or warnings for the patient about the medication (e.g. \"may cause drowsiness\" or \"avoid exposure of skin to direct sunlight or sunlamps\")."
* dosage.maxDosePerAdministration.unit ..0
* adherence ..0