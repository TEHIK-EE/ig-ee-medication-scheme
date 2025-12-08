Profile: EETISPrescription
Parent: MedicationRequest
Id: ee-tis-prescription
Description: "Retsept. This is a profile for medication prescription."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-21T13:56:50.8906817+00:00"
* meta.lastUpdated ^example.label = "ajanäidis"
* meta.lastUpdated ^example.valueInstant = "2023-09-25T12:12:12+00:01"
* contained 0..*
* extension contains
    ExtensionEETISDispensationAuthorization named dispensationAuthorization 1..1 and
    ExtensionEETISLockStatus named lockStatus 0..1 and
    ExtensionEETISUnauthorizedProductRequest named extensionEETISUnauthorizedProductRequest 0..* and
    ExtensionEETISTotalPrescribedAmount named extensionEETISTotalPrescribedAmount 0..* and
    ExtensionEETISReimbursementRate named extensionEETISReimbursementRate 0..* and 
    ExtensionEETISPrescriptionChange named extensionEETISPrescriptionChange 0..*
* extension[lockStatus] ^short = "Used only when requesting unauthorized medication."
* extension[lockStatus] ^definition = "Broneeritud müügiloata ravimi taotluse jaoks. Kasutatakse AINULT müügiloata ravimi taotluse retsepti broneerimise puhul."
* extension[extensionEETISUnauthorizedProductRequest] ^short = "Used for requesting marketing permit for unauthorized medication."
* extension[extensionEETISUnauthorizedProductRequest] ^definition = "Müügiloata ravimi taotluse tarvis."
* identifier ..1
* identifier.system = $retseptikeskus-retsept
* identifier.system ^short = "Identifier system uri for Estonian Prescription Centre prescriptions"
//* identifier.system ^definition = "TIS FHIR identifikaatorite süsteem"
* identifier.value ^short = "Prescription number"
* identifier ^short = "Identifier for the prescription."
* identifier ^definition = "Retsepti unikaalne identifikaator. Identifiers associated with this medication request that are defined by business processes and/or used to refer to it when a direct URL reference to the resource itself is not appropriate. They are business identifiers assigned to this resource by the performer or other systems and remain constant as the resource is updated and propagates from server to server."
* identifier.assigner only Reference($ee-organization)
* basedOn ..1
* priorPrescription ..0
* status ^definition = "Kui tegemist on müügiloata ravimi taotlusega, on status siiski \"active\" , sest retsept on aktiivne ning kui müügiloa otsus on positiivne ja \"intent\" muutunud \"proposal\"-st \"order\"-ks extension lockStatus alt täpsustus, milline apteek retesepti broneeris ja retsept staatusesse \"on-hold. \r\n\r\nA code specifying the current state of the order. Generally, this will be active or completed state."
* statusReason from $retsepti-annulleerimise-pohjus-VS (required)
* statusReason ^short = "Reason for current status. Used only when prescription is \"cancelled\"."
* statusReason ^definition = "ANNULLEERIMISE PÕHJUS. LOEND. Kui retsept annulleeritakse, kasutatakse statust \"cancelled\" ning valitakse põhjus loendist \"Annulleerimise põhjuse\".\r\n\r\nCaptures the reason for the current state of the MedicationRequest."
* statusReason ^binding.description = "Annulleerimise põhjus loend"
* intent ^short = "By default all requests are \"order\", unauthorized medication requests are initially \"proposal\" and when positively solved change to \"order\""
* intent ^definition = "Tavaline retsept on \"order\", müügiloata ravimi retsept on alguses \"proposal\"."
* category ..*
* category ^slicing.discriminator.type = #value
* category ^slicing.discriminator.path = "coding.system"
* category ^slicing.rules = #open
* category ^short = "Grouping or category of medication request"
* category ^definition = "RETSEPTI LIIK/DOK TYYP."
* category contains
    prescriptionCategory 0..1 and
    repeatCategory 0..1
* category[prescriptionCategory] from $retsepti-liik-VS (required)
* category[prescriptionCategory] ^short = "tavaretsept | narkootilise ravimi retsept | meditsiiniseadme retsept"
* category[prescriptionCategory].coding.system = $retsepti-liik 
* category[prescriptionCategory] ^definition = "RETSEPTI LIIK."
* category[prescriptionCategory] ^binding.description = "RETSEPTI LIIK. LOEND."
* category[repeatCategory] from $retsepti-kordsus-VS (required)
* category[repeatCategory].coding.system = $retsepti-kordsus
* category[repeatCategory] ^short = "1-kordne | 2-kordne | 3-kordne| 6-kordne"
* category[repeatCategory] ^definition = "KORDSUS. LOEND."
* category[repeatCategory] ^binding.description = "Retsepti kordsuse loend"
* priority ..0
* doNotPerform ..0
* medication only CodeableReference(EETISMedicationEPC or EETISMedicationExtemporal)
* medication ^type.aggregation = #referenced
//* medication.concept ..0
* medication only CodeableReference(EETISMedicationEPC or EETISMedicationExtemporal)
* subject only Reference($ee-mpi-patient)
* subject ^short = "Patient for who is the request made for."
* subject ^definition = "Patsient, kellele retsept on välja kirjutatud."
* subject ^type.aggregation = #referenced
* informationSource 0..*
* informationSource ^short = "If prescription is cancelled by someone else than original prescriber it must be filled here. Original prescriber remains in requester field."
* informationSource ^definition = "Juhul kui retsept on annulleeritud kellegi teise poolt kui algne väljakirjutaja, tuleb annulleerija info siia tuua."
* informationSource only Reference(EETISPractitionerRole or $ee-practitioner)
* encounter ..0
* authoredOn 1..
* authoredOn ^short = "When the prescription was made."
* authoredOn ^definition = "Koostamise aeg"
* requester only Reference(EETISPractitionerRole or $ee-practitioner)
* requester ^short = "Who/What requested the Request. Initial author of the request. NB! See also the differenece between informationSource"
* requester ^definition = "Kes tegi retsepti. Retsepti algne koostaja."
* requester ^type.aggregation = #contained
* reported ..0
* performerType ..0
* performer ..0
* device ..0
* recorder ..0
* reason 1..1
* reason ^short = "Diagnosis according to ICD-10. Reason or indication for ordering or not ordering the medication"
* reason ^definition = "Diagnoosikood RHK-10 järgi."
* reason from $rhk-10-VS (preferred)
* reason ^binding.description = "RHK-10"
//* reason.reference ..0
* courseOfTherapyType from $ravikuuri-tyyp-VS (required)
* courseOfTherapyType ^short = "pidev | fikseeritud | vajadusel | muutuv | ühekordne"
* courseOfTherapyType ^definition = "The description of the overall pattern of the administration of the medication to the patient."
* courseOfTherapyType ^binding.description = "RAVIKUURI TÜÜP. Loend"
* courseOfTherapyType.coding ^short = "pidev | fikseeritud | vajadusel | muutuv | ühekordne"
* insurance ..0
* note ..1
* note ^short = "Comment from the request author only."
* note ^definition = "Kommentaari saab lisada ainult sama inimene, kes koostas retsepti.\r\n\r\nExtra information about the prescription that could not be conveyed by the other attributes."
* note.author[x] ..0
* note.time ..0
* renderedDosageInstruction ..0
* effectiveDosePeriod ..0
* dosageInstruction 1..
* dosageInstruction only EETISDosage
* dosageInstruction ^short = "Specific instructions for how the medication should be taken"
* dosageInstruction ^definition = "ANNUSTAMINE. Täpne annustamisjuhis, kuidas määratud ravimit tuleb võtta."
* dosageInstruction.sequence ..0
* dosageInstruction.additionalInstruction ..0
* dosageInstruction.timing.event ..0
* dosageInstruction.timing.repeat.countMax ..0
* dosageInstruction.timing.repeat.duration ..0
* dosageInstruction.timing.repeat.durationMax ..0
* dosageInstruction.timing.repeat.frequency ^short = "Mitu korda (ajaühikus)."
* dosageInstruction.timing.repeat.frequency ^definition = "Indicates the number of repetitions that should occur within a period. I.e. Event occurs frequency times per period."
* dosageInstruction.timing.repeat.frequencyMax ..0
* dosageInstruction.timing.repeat.period ^short = "The duration to which the frequency applies. I.e. Event occurs frequency times per period"
* dosageInstruction.timing.repeat.period ^definition = "(mitu korda) aja(ühikus)."
* dosageInstruction.timing.repeat.periodMax ..0
* dosageInstruction.timing.repeat.periodUnit ^short = "The units of time for the period in UCUM units"
* dosageInstruction.timing.repeat.periodUnit ^definition = "T(mitu korda aja)ühikus.\nNormal practice is to use the 'mo' code as a calendar month when calculating the next occurrence."
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
* dosageInstruction.doseAndRate.doseQuantity ^short = "Amount of medication per dose"
* dosageInstruction.doseAndRate.doseQuantity ^definition = "RAVIMI KOGUS ÜHE KASUTUSKORRA AJAL." 
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
* dispenseRequest ^short = "Indicates the specific details for the dispense or medication supply part of a medication request."
* dispenseRequest ^definition = "Täpne info ravimi väljamüügi kohta."
* dispenseRequest.id ..0
* dispenseRequest.initialFill ..0
* dispenseRequest.dispenseInterval ..0
* dispenseRequest.validityPeriod 1..
* dispenseRequest.validityPeriod ^short = "Time period supply is authorized for"
* dispenseRequest.validityPeriod ^definition = "RETSEPTI KEHTIVUS AEG. Periood väljakirjutamise hetkest alates, mil on võimalik ravimit välja osta."
* dispenseRequest.numberOfRepeatsAllowed ..0
* dispenseRequest.quantity ..0
* dispenseRequest.expectedSupplyDuration ..0
* dispenseRequest.dispenser only Reference($ee-organization)
* dispenseRequest.dispenser ^definition = "KASUTATAKSE AINULT MÜÜGILOATA RAVIMI APTEEGI BRONEERIMISE PUHUL. Indicates the intended performing Organization that will dispense the medication as specified by the prescriber."
* dispenseRequest.dispenser ^type.aggregation = #referenced
* dispenseRequest.dispenserInstruction ..0
* dispenseRequest.doseAdministrationAid ..0
* substitution ^short = "Asendamine. Any restrictions on medication substitution"
* substitution.allowed[x] only boolean
//* substitution.allowed[x] ^slicing.discriminator.type = #type
//* substitution.allowed[x] ^slicing.discriminator.path = "$this"
//* substitution.allowed[x] ^slicing.rules = #open
* substitution.allowed[x] ^short = "True if the prescriber allows a different drug to be dispensed from what was prescribed."
* substitution.allowed[x] ^definition = "Kas asendamine on keelatud."
//* substitution.allowedBoolean only boolean
//* substitution.allowedBoolean ^sliceName = "allowedBoolean"
* substitution.reason from $ravimi-asendamatuse-pohjus-VS (preferred)
* substitution.reason ^short = "Why should (not) substitution be made"
* substitution.reason ^definition = "Asendamatuse põhjus (loend). \r\n\r\nIndicates the reason for the substitution, or why substitution must not be performed."
* substitution.reason ^binding.description = "Asendamatuse põhjus. Loend"
//* substitution.reason.coding from $ravimi-asendamatuse-pohjus-VS (preferred)
//* substitution.reason.coding ^binding.description = "Asendamise keelamise loend"
* eventHistory ..0