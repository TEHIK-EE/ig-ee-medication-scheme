Profile: EETISMedicationStatement
Parent: MedicationStatement
Id: ee-tis-medication-statement
Description: "Ravimiskeemi rida. One or more Medication Statements form patient's Medication Overview."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-23T10:56:02.4427313+00:00"
* text ^short = "MedicationStatement is part of MedicationOverview representing one treatmentline"
* contained ..0
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
    ExtensionEETISPrescriptionIntent named extensionEETISPrescriptionIntent 0..*
* extension[extensionEETISVerification] ^definition = "Optional Extension Element - found in all resources."
* partOf only Reference(MedicationStatement)
* status ^definition = "recorded = Kinnitatud; draft = Kinnitamata. Retseptikeskuse retsepti põhjal genereeritud kinnitamata rida on staatuses recorded/kinnitatud. A code representing the status of recording the medication statement."
* status ^short = "recorded = KINNITATUD; draft = KINNITAMATA"
* category ^slicing.discriminator.type = #value
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains
    courseOfTherapyType 0..* and
    statementOriginCategory 0..* and
    prescriptionCategory 0..* and
    repeatCategory 0..*
* category[courseOfTherapyType] from $ravikuuri-tyyp-VS (required)
* category[courseOfTherapyType] ^short = "pidev | fikseeritud | vajadusel | muutuv | ühekordne |"
* category[courseOfTherapyType] ^binding.description = "RAVIKUURI TÜÜP. LOEND"
* category[statementOriginCategory] from $ravimi-andmete-tyyp-VS (required)
* category[statementOriginCategory] ^short = "Category defining the origin of MedicationStatement. USED ONLY when medication scheme line is based on patient's statement."
* category[statementOriginCategory] ^definition = "Seda kategooriat kasutada AINULT juhul, kui ravimiskeemi rida genereeritakse patsiendi sõnul. Kasutada koodi |ASK| loendist ravimi-andmete-tyyp. Retseptikeskuse retseptidest loodud ravimiskeemi rea puhul jääb see kategooria TÜHJAKS."
* category[statementOriginCategory] ^binding.description = "Category defining the origin of MedicationStatement. Use only code |ASK| from ValueSet ravimi-andmete-tyyp."
//* category[statementOriginCategory] = $ravimi-andmete-tyyp-VS#ASK "ütluspõhine ravim" (exactly)
//* category[statementOriginCategory] ^fixedCodeableConcept.text = "|ASK| ütluspõhine ravim"
* category[prescriptionCategory] from $retsepti-liik-VS (required)
* category[prescriptionCategory] ^short = "tavaretsept | narkootilise ravimi retsept | meditsiiniseadme retsept"
* category[prescriptionCategory] ^binding.description = "RETSEPTI LIIK. LOEND."
* category[repeatCategory] from $retsepti-kordsus-VS (required)
* category[repeatCategory] ^short = "1-kordne | 2-kordne | 3-kordne | 6-kordne"
* category[repeatCategory] ^binding.description = "Retsepti kordsus. LOEND."
* medication only CodeableReference(EETISMedicationEPC)
//* medication ^type.aggregation = #referenced
//* medication.concept ..0
//* medication.reference only Reference(EETISMedicationEPC)
//* medication.reference ^type.aggregation = #referenced
* subject only Reference(EETISPatient)
* subject ^type.aggregation = #referenced
* encounter ..0
* effective[x] only Period
* effective[x] ^short = "Ravimiskeemi rea kehtivuse algus"
* informationSource only Reference(EETISPractitioner or EETISPractitionerRole)
* informationSource ^short = "Ravimiskeemi rea (algne) koostaja"
* informationSource ^definition = "AUTOR KES KOOSTAB RAVIMISKEEMI REA (arst). Initial author of the MedicationStatement. The person or organization that provided the information about the taking of this medication. Note: Use derivedFrom when a MedicationStatement is derived from other resources, e.g. Claim or MedicationRequest."
* derivedFrom only Reference(EETISPrescription)
* derivedFrom ^short = "SEOTUD RETSEPTID. Link to information used to derive the MedicationStatement"
* derivedFrom ^type.aggregation = #referenced
* reason ^definition = "A concept, Condition or observation that supports why the medication is being/was taken.\r\nDIAGNOOSIKOOD retseptikeskusest"
* reason from $rhk-10-VS (preferred)
* reason ^short = "Diagnoosikoodid (RHK-10)"
//* reason ^binding.description = "Diagnoosikood RHK-10"
//* reason.reference ..0
* note ^definition = "Provides extra information about the Medication Statement that is not conveyed by the other attributes.\r\nSiia saab kirjutada märkusi ravimiskeemi rea kohta."
* note.author[x] 1..
* note.author[x] only string or Reference(EETISPractitionerRole or EETISPractitioner)
* relatedClinicalInformation ..0
* dosage only EETISDosage
* dosage ^definition = "Indicates how the medication is/was or should be taken by the patient.\r\nANNUSTAMISEJUHIS"
* dosage.additionalInstruction ^definition = "VALMISTAMISEJUHIS\r\nSupplemental instructions to the patient on how to take the medication  (e.g. \"with meals\" or\"take half to one hour before food\") or warnings for the patient about the medication (e.g. \"may cause drowsiness\" or \"avoid exposure of skin to direct sunlight or sunlamps\")."
* dosage.maxDosePerAdministration.unit ..0
* adherence ..0