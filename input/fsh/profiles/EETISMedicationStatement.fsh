Profile: EETISMedicationStatement
Parent: MedicationStatement
Id: ee-tis-medication-statement
Description: "Ravimiskeemi rida. One or more Medication Statements form patient's Medication Scheme."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-23T10:56:02.4427313+00:00"
* text ^short = "MedicationStatement is part of Medication Scheme representing one treatmentline"
* contained 0..*
* extension contains
    ExtensionEETISPrescriptionValidityTime named extensionEETISPrescriptionValidityTime 0..1 and
    ExtensionEETISMedicationRemainder named extensionEETISMedicationRemainder 0..1 and
    ExtensionEETISTotalPrescribedAmount named extensionEETISTotalPrescribedAmount 0..* and //reaalselt RKs 0..1 võimalik
//    ExtensionEETISLockStatus named extensionEETISLockStatus 0..* and
    ExtensionEETISDispensationAuthorization named extensionEETISDispensationAuthorization 1..1 and
    ExtensionEETISCancelledStatusReason named extensionEETISCancelledStatusReason 0..1 and // täidetakse ainult ravimiskeemi rea kustutamisel
    ExtensionEETISReimbursementRate named extensionEETISReimbursementRate 0..1 and //selected Reimbursement rate
    ExtensionEETISUnauthorizedProductRequest named extensionEETISUnauthorizedProductRequest 0..1 and //Ravimiametilt küsida nimi
    ExtensionEETISSubstitution named extensionEETISSubstitution 0..1 and
    ExtensionEETISVerification named extensionEETISVerification 0..* and
    ExtensionEETISPrescriptionIntent named extensionEETISPrescriptionIntent 0..* and
    ExtensionEETISPrescriptionChange named ExtensionEETISPrescriptionChange 0..* and
    ExtensionEETISGroupedItems named ExtensionEETISGroupedItems 0..*
* extension[extensionEETISVerification] ^definition = "Optional Extension Element - found in all resources."
* partOf only Reference(EETISMedicationStatement)
* status ^definition = "recorded = Kinnitatud; draft = Kinnitamata. Retseptikeskuse retsepti põhjal genereeritud kinnitamata rida on staatuses recorded/kinnitatud."
* status ^short = "A code representing the status of recording the medication statement. recorded = KINNITATUD; draft = KINNITAMATA"
* identifier ^short = "Identifier is prescription number (ee RETSEPTINUMBER), if the MedicationStatement is generated from RETSEPTIKESKUS prescriptions. In history view identifier system, must use https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid#ravimiskeemi-rea-ajajoone-grupp as system in order to group medications in same form (eg. tablets and capsules are grouped together)"
* identifier.system ^binding.description = "Use https://fhir.ee/ravimiskeemi-rea-ajajoone-grupp as system when grouping medication statements in history view." //from $tis-fhir-identifikaatorid (preferred)
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains
    courseOfTherapyType 1..* and
    statementOriginCategory 0..* and
    prescriptionCategory 1..* and
    repeatCategory 1..*
* category[courseOfTherapyType] from $ravikuuri-tyyp-VS (required)
* category[courseOfTherapyType] ^short = "What type of medication course is. RAVIKUURI TÜÜP. LOEND. pidev | fikseeritud | vajadusel | muutuv | ühekordne |"
* category[courseOfTherapyType] ^definition = "RAVIKUURI TÜÜP. LOEND. pidev | fikseeritud | vajadusel | muutuv | ühekordne |"
* category[statementOriginCategory] from $ravimi-andmete-tyyp-VS (required)
* category[statementOriginCategory] ^short = "Category defining the origin of MedicationStatement. USED ONLY when medication scheme line is based on patient's statement."
* category[statementOriginCategory] ^definition = "Seda kategooriat kasutada AINULT juhul, kui ravimiskeemi rida genereeritakse patsiendi sõnul. Kasutada koodi |ASK| loendist ravimi-andmete-tyyp. Retseptikeskuse retseptidest loodud ravimiskeemi rea puhul jääb see kategooria TÜHJAKS."
//* category[statementOriginCategory] ^binding.d = "Category defining the origin of MedicationStatement. Use only code |ASK| from ValueSet ravimi-andmete-tyyp."
//* category[statementOriginCategory] = $ravimi-andmete-tyyp-VS#ASK "ütluspõhine ravim" (exactly)
//* category[statementOriginCategory] ^fixedCodeableConcept.text = "|ASK| ütluspõhine ravim"
* category[prescriptionCategory] from $retsepti-liik-VS (required)
* category[prescriptionCategory] ^short = "Whether the prescription is for regular medication, narcotics or medical device.RETSEPTI LIIK. LOEND. tavaretsept | narkootilise ravimi retsept | meditsiiniseadme retsept"
* category[prescriptionCategory] ^definition = "RETSEPTI LIIK. LOEND. tavaretsept | narkootilise ravimi retsept | meditsiiniseadme retsept"
* category[repeatCategory] from $retsepti-kordsus-VS (required)
* category[repeatCategory] ^short = "Whether the prescription is one-time prescription or multiple.RETSEPTI KORDSUS. LOEND. 1-kordne | 2-kordne | 3-kordne | 6-kordne"
* category[repeatCategory] ^definition = "RETSEPTI KORDSUS. LOEND. 1-kordne | 2-kordne | 3-kordne | 6-kordne"
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
* effective[x] ^short = "Time period when the treatment line begins and ends"
* effective[x] ^definition = "Ravimiskeemi rea kehtivuse algus"
* informationSource only Reference(EETISPractitioner or EETISPractitionerRole)
* informationSource ^short = "Initial author of the MedicationStatement. The person or organization that provided the information about the taking of this medication. Note: Use derivedFrom when a MedicationStatement is derived from other resources, e.g. Claim or MedicationRequest."
* informationSource ^definition = "AUTOR KES KOOSTAB RAVIMISKEEMI REA (arst). Ravimiskeemi rea (algne) koostaja."
* derivedFrom only Reference(EETISPrescription)
* derivedFrom ^short = "Prescriptions created elsewhere than in TJT. Link to information used to derive the MedicationStatement"
* derivedFrom ^definition = "SEOTUD RETSEPTID."
* derivedFrom ^type.aggregation = #referenced
* reason ^definition = "Diagnoosikoodid (RHK-10)\r\nDIAGNOOSIKOOD retseptikeskusest"
* reason from $rhk-10-VS (preferred)
* reason ^short = "Diagnose for medication. ICD-10 codes from Estonian Prescription Centre. Reimbursement of medication depends on which ICD-10 code is used."
//* reason ^binding.description = "Diagnoosikood RHK-10"
//* reason.reference ..0
* note ^definition = "Provides extra information about the Medication Statement that is not conveyed by the other attributes."
* note ^short = "Siia saab kirjutada märkusi ravimiskeemi rea kohta."
* note.author[x] 1..
//y* note.author[x] only string or Reference(EETISPractitionerRole or EETISPractitioner)
* relatedClinicalInformation ..0
* dosage only EETISDosage
* dosage ^short = "Indicates how the medication is/was or should be taken by the patient."
* dosage ^definition = "ANNUSTAMISEJUHIS"
* dosage.additionalInstruction ^definition = "VALMISTAMISEJUHIS"
* dosage.additionalInstruction ^short = "Supplemental instructions to the patient on how to take the medication  (e.g. \"with meals\" or\"take half to one hour before food\") or warnings for the patient about the medication (e.g. \"may cause drowsiness\" or \"avoid exposure of skin to direct sunlight or sunlamps\")."
* dosage.maxDosePerAdministration.unit ..0
* adherence ..0