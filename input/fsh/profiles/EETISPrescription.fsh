Profile: EETISPrescription
Parent: MedicationRequest
Id: ee-tis-prescription
Description: "Retsept. This is a prescription of a medicine."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-21T13:56:50.8906817+00:00"
* meta.lastUpdated ^example.label = "ajanäidis"
* meta.lastUpdated ^example.valueInstant = "2023-09-25T12:12:12+00:01"
* contained ..0
* extension contains
    ExtensionEETISDispensationAuthorization named dispensationAuthorization 0..* and
    ExtensionEETISLockStatus named lockStatus 0..* and
    ExtensionEETISUnauthorizedProductRequest named extensionEETISUnauthorizedProductRequest 0..* and
    ExtensionEETISTotalPrescribedAmount named extensionEETISTotalPrescribedAmount 0..* and
    ExtensionEETISReimbursementRate named extensionEETISReimbursementRate 0..*
* extension[lockStatus] ^short = "Broneeritud müügiloata ravimi taotluse jaoks."
* extension[lockStatus] ^definition = "Kasutatakse AINULT müügiloata ravimi taotluse retsepti broneerimise puhul."
* extension[extensionEETISUnauthorizedProductRequest] ^short = "Müügiloata ravimi taotluse tarvis."
* identifier ..1
* identifier ^short = "Retsepti number."
* identifier ^definition = "Retsepti unikaalne identifikaator. Identifiers associated with this medication request that are defined by business processes and/or used to refer to it when a direct URL reference to the resource itself is not appropriate. They are business identifiers assigned to this resource by the performer or other systems and remain constant as the resource is updated and propagates from server to server."
* identifier.assigner only Reference(EETISOrganization)
* basedOn ..1
* priorPrescription ..0
* status ^definition = "Kui tegemist on müügiloata ravimi taotlusega, on status \"on-hold\" ning extension lockStatus alt täpsustus, milline apteek retesepti broneeris. \r\n\r\nA code specifying the current state of the order.  Generally, this will be active or completed state."
* statusReason from $retsepti-annulleerimise-pohjus-VS (required)
* statusReason ^short = "ANNULLEERIMISE PÕHJUS. LOEND. Reason for current status"
* statusReason ^definition = "Kui retsept annulleeritakse, kasutatakse statust \"cancelled\" ning valitakse põhjus loendist \"Annulleerimise põhjuse\".\r\n\r\nCaptures the reason for the current state of the MedicationRequest."
* statusReason ^binding.description = "Annulleerimise põhjus"
* intent ^definition = "Tavaline retsept on \"order\", müügiloata ravimi retsept on alguses \"proposal\". \r\n\r\nWhether the request is a proposal, plan, or an original order."
* category ..*
* category ^slicing.discriminator.type = #value
* category ^slicing.discriminator.path = "coding.system"
* category ^slicing.rules = #open
* category ^short = "RETSEPTI LIIK/DOK TYYP. Grouping or category of medication request"
* category contains
    prescriptionCategory 0..1 and
    repeatCategory 0..1
* category[prescriptionCategory] from $retsepti-liik-VS (required)
* category[prescriptionCategory] ^short = "tavaretsept | narkootilise ravimi retsept | meditsiiniseadme retsept"
* category[prescriptionCategory].coding.system = $retsepti-liik 
* category[prescriptionCategory] ^definition = "RETSEPTI LIIK. An arbitrary categorization or grouping of the medication request.  It could be used for indicating where meds are intended to be administered, eg. in an inpatient setting or in a patient's home, or a legal category of the medication."
* category[prescriptionCategory] ^binding.description = "RETSEPTI LIIK. LOEND."
* category[repeatCategory] from $retsepti-kordsus-VS (required)
* category[repeatCategory].coding.system = $retsepti-kordsus
* category[repeatCategory] ^short = "1-kordne | 2-kordne | 3-kordne| 6-kordne"
* category[repeatCategory] ^definition = "KORDSUS. LOEND.  An arbitrary categorization or grouping of the medication request.  It could be used for indicating where meds are intended to be administered, eg. in an inpatient setting or in a patient's home, or a legal category of the medication."
* category[repeatCategory] ^binding.description = "Retsepti kordsuse loend"
* priority ..0
* doNotPerform ..0
* medication only CodeableReference(EETISMedicationEPC)
* medication ^type.aggregation = #referenced
//* medication.concept ..0
* medication only CodeableReference(EETISMedicationEPC)
* subject only Reference(EETISPatient)
* subject ^short = "Patsient, kellele retsept on välja kirjutatud"
* subject ^type.aggregation = #referenced
* informationSource ..0
* encounter ..0
* authoredOn 1..
* authoredOn ^short = "Koostamise aeg"
* requester only Reference(EETISPractitionerRole or EETISPractitioner)
* requester ^short = "Kes tegi retsepti."
* requester ^definition = "Who/What requested the Request. The individual, organization, or device that initiated the request and has responsibility for its activation."
* requester ^type.aggregation = #contained
* reported ..0
* performerType ..0
* performer ..0
* device ..0
* recorder ..0
* reason 1..1
* reason ^short = "DIAGNOOS. Reason or indication for ordering or not ordering the medication"
* reason ^definition = "Diagnoosikood RHK-10 järgi. \r\n\r\nThe reason or the indication for ordering or not ordering the medication."
* reason from $rhk-10-VS (preferred)
* reason ^binding.description = "RHK-10"
//* reason.reference ..0
* courseOfTherapyType from $ravikuuri-tyyp-VS (required)
* courseOfTherapyType ^short = "Väärtus loendist pidev | fikseeritud | vajadusel | muutuv | ühekordne"
* courseOfTherapyType ^definition = "The description of the overall pattern of the administration of the medication to the patient."
* courseOfTherapyType ^binding.description = "RAVIKUURI TÜÜP"
* courseOfTherapyType.coding ^short = "pidev | fikseeritud | vajadusel | muutuv | ühekordne"
* insurance ..0
* note ..1
* note ^short = "Kommentaar"
* note ^definition = "Kommentaari saab lisada ainult sama inimene, kes koostas retsepti.\r\n\r\nExtra information about the prescription that could not be conveyed by the other attributes."
* note.author[x] ..0
* note.time ..0
* renderedDosageInstruction ..0
* effectiveDosePeriod ..0
* dosageInstruction 1..
* dosageInstruction only EETISDosage
* dosageInstruction ^short = "ANNUSTAMINE. Specific instructions for how the medication should be taken"
* dosageInstruction ^definition = "Täpne annustamisjuhis, kuidas määratud ravimit tuleb võtta.\r\n\r\nIndicates how the medication is/was taken or should be taken by the patient."
* dosageInstruction.sequence ..0
* dosageInstruction.additionalInstruction ..0
* dosageInstruction.timing.event ..0
* dosageInstruction.timing.repeat.countMax ..0
* dosageInstruction.timing.repeat.duration ..0
* dosageInstruction.timing.repeat.durationMax ..0
* dosageInstruction.timing.repeat.frequency ^short = "Mitu korda (ajaühikus). Indicates the number of repetitions that should occur within a period. I.e. Event occurs frequency times per period"
* dosageInstruction.timing.repeat.frequencyMax ..0
* dosageInstruction.timing.repeat.period ^short = "(mitu korda) aja(ühikus). The duration to which the frequency applies. I.e. Event occurs frequency times per period"
* dosageInstruction.timing.repeat.periodMax ..0
* dosageInstruction.timing.repeat.periodUnit ^definition = "T(mitu korda aja)ühikus. he units of time for the period in UCUM units\nNormal practice is to use the 'mo' code as a calendar month when calculating the next occurrence."
* dosageInstruction.timing.repeat.dayOfWeek ..0
* dosageInstruction.timing.repeat.when ..0
* dosageInstruction.timing.repeat.offset ..0
* dosageInstruction.timing.code ..0
* dosageInstruction.asNeeded ..0
* dosageInstruction.site ..0
* dosageInstruction.route ..0
* dosageInstruction.method ..0
* dosageInstruction.doseAndRate 1..1
* dosageInstruction.doseAndRate.type ..0
* dosageInstruction.doseAndRate.dose[x] only SimpleQuantity
//* dosageInstruction.doseAndRate.dose[x] ^slicing.discriminator.type = #type
//* dosageInstruction.doseAndRate.dose[x] ^slicing.discriminator.path = "$this"
//* dosageInstruction.doseAndRate.dose[x] ^slicing.rules = #open
//* dosageInstruction.doseAndRate.doseQuantity only Quantity
//* dosageInstruction.doseAndRate.doseQuantity ^sliceName = "doseQuantity"
* dosageInstruction.doseAndRate.doseQuantity ^short = "RAVIMI KOGUS ÜHE KASUTUSKORRA AJAL. Amount of medication per dose"
//* dosageInstruction.doseAndRate.doseQuantity.value 1..
//* dosageInstruction.doseAndRate.doseQuantity.unit ..0
//* dosageInstruction.doseAndRate.doseQuantity.system 1..
//* dosageInstruction.doseAndRate.doseQuantity.code 1..
//* dosageInstruction.doseAndRate.doseRange ..0
//* dosageInstruction.doseAndRate.doseRange only Range
//* dosageInstruction.doseAndRate.doseRange ^sliceName = "doseRange"
* dosageInstruction.doseAndRate.rate[x] ..0
* dosageInstruction.maxDosePerPeriod ..0
* dosageInstruction.maxDosePerAdministration ..0
* dosageInstruction.maxDosePerLifetime ..0
* dispenseRequest ^definition = "Täpne info ravimi väljamüügi kohta. \r\n\r\nIndicates the specific details for the dispense or medication supply part of a medication request (also known as a Medication Prescription or Medication Order).  Note that this information is not always sent with the order.  There may be in some settings (e.g. hospitals) institutional or system support for completing the dispense details in the pharmacy department."
* dispenseRequest.id ..0
* dispenseRequest.initialFill ..0
* dispenseRequest.dispenseInterval ..0
* dispenseRequest.validityPeriod 1..
* dispenseRequest.validityPeriod ^short = "RETSEPTI KEHTIVUS AEG. Time period supply is authorized for"
* dispenseRequest.validityPeriod ^definition = "Periood väljakirjutamise hetkest alates, mil on võimalik ravimit välja osta.\r\n\r\nThis indicates the validity period of a prescription (stale dating the Prescription)."
* dispenseRequest.numberOfRepeatsAllowed ..0
* dispenseRequest.quantity ..0
* dispenseRequest.expectedSupplyDuration ..0
//* dispenseRequest.dispenser only Reference(EETISOrganization or EETISPharmacyLocation)
// Kommentaar: eemaldasin Locationi, sest see ei ole lubatud andmetüüp siin
* dispenseRequest.dispenser only Reference(EETISOrganization)
* dispenseRequest.dispenser ^definition = "KASUTATAKSE AINULT MÜÜGILOATA RAVIMI APTEEGI BRONEERIMISE PUHUL. Indicates the intended performing Organization that will dispense the medication as specified by the prescriber."
* dispenseRequest.dispenser ^type.aggregation = #referenced
* dispenseRequest.dispenserInstruction ..0
* dispenseRequest.doseAdministrationAid ..0
* substitution ^short = "Asendamine. Any restrictions on medication substitution"
* substitution.allowed[x] only boolean
//* substitution.allowed[x] ^slicing.discriminator.type = #type
//* substitution.allowed[x] ^slicing.discriminator.path = "$this"
//* substitution.allowed[x] ^slicing.rules = #open
* substitution.allowed[x] ^definition = "Kas asendamine on keelatud.\r\n\r\nTrue if the prescriber allows a different drug to be dispensed from what was prescribed."
//* substitution.allowedBoolean only boolean
//* substitution.allowedBoolean ^sliceName = "allowedBoolean"
* substitution.reason from $ravimi-asendamatuse-pohjus-VS (preferred)
* substitution.reason ^short = "LOEND. Why should (not) substitution be made"
* substitution.reason ^definition = "Asendamatuse põhjus (loend). \r\n\r\nIndicates the reason for the substitution, or why substitution must or must not be performed."
* substitution.reason ^binding.description = "Asendamine keelatud loend"
* substitution.reason.coding from $ravimi-asendamatuse-pohjus-VS (preferred)
* substitution.reason.coding ^binding.description = "Asendamise keelamise loend"
* eventHistory ..0