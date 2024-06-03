Profile: EETISPrescriptionDispense
Parent: MedicationDispense
Id: ee-tis-prescription-dispense
Description: "Väljamüük. When the medication prescribed is dispensed in pharmacy."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-01-31T14:08:33.4764521+00:00"
* . ^short = "Ravimi väljamüük patsiendile."
* contained ..0
* extension contains
    ExtensionEETISBuyerEPC named extensionEETISBuyerEPC 0..* and
    ExtensionEETISReimbursementRate named extensionEETISReimbursementRate 0..*
* extension[extensionEETISBuyerEPC].value[x] ^short = "OSTJA ISIKUKOOD"
* identifier ..0
* basedOn ..0
* partOf ..0
* notPerformedReason ..0
* statusChanged ..0
* category ..0
* medication only CodeableReference(EETISMedicationEPC)
* medication ^short = "Väljastatud ravim"
//* medication ^type.aggregation = #referenced
//* medication.concept ..0
//* medication.reference only Reference(EETISMedicationEPC)
//* medication.reference ^type.aggregation = #referenced
* subject only Reference(EETISPatient)
* subject ^short = "Patsient, kellele ravim väljastatakse"
//* subject ^type.aggregation = #referenced
* encounter ..0
* supportingInformation ..0
* performer 1..1
* performer ^short = "Väljastuse teostaja"
* performer ^definition = "Kes väljastas ravimi patsiendile. Indicates who or what performed the event."
* performer.function ..0
* performer.actor only Reference(EETISPractitionerRole)
* performer.actor ^short = "Proviisor või farmatseut, kellel on õigus väljastada ravimit"
* location only Reference(EETISPharmacyLocation)
* location ^short = "Apteegi tegevuskoha kood"
* location ^definition = "APTEEK ja SELLE KOOD KUS RAVIM VÄLJASTATI. The principal physical location where the dispense was performed."
* location.identifier ^short = "APTEEGI TEGEVUSKOHA KOOD. Logical reference, when literal reference is not known"
* authorizingPrescription 1..
* authorizingPrescription only Reference(EETISPrescription)
* authorizingPrescription ^short = "Retsept, mille alusel ravim väljastati patsiendile."
* type ..0
* quantity 1..
* quantity ^short = "Väljastatud ravimi kogus"
* quantity ^definition = "Pakendite arv, mis väljastati. The amount of medication that has been dispensed. Includes unit of measure."
* quantity.unit ..0
* quantity.system ..0
* quantity.code ..0
* daysSupply ..0
* recorded ..0
* whenPrepared ..0
* whenHandedOver 1..
* whenHandedOver ^short = "Väljastamise aeg"
* whenHandedOver ^definition = "Kuupäev ja kellaaeg, millal ravim anti üle patsiendile, või tema esindajale. The time the dispensed product was provided to the patient or their representative."
* destination ..0
* receiver ..1
* receiver ^short = "KUI RAVIMI OSTAB VÄLJA KEEGI TEINE KUI SEE, KELLELE RAVIM ON VÄLJAKIRJUTATUD EI KASUTATA SEDA VAID ExtensionEETISBuyerEPC.  Who collected the medication or where the medication was delivered"
* receiver.identifier.value 1..
* receiver.identifier.value ^short = "OSTJA ISIKUKOOD. Logical reference, when literal reference is not known"
//* receiver.identifier.system 1..
//* receiver.identifier.system = $isikukood (exactly)
* note ..1
* note ^short = "Kommentaar väljastuse kohta."
* note ^definition = "Kommentaari saab lisada ainult see, kes teostas ravimi väljastuse apteegis. Extra information about the dispense that could not be conveyed in the other attributes."
* note.author[x] ..0
* renderedDosageInstruction ..0
* dosageInstruction ..0
* dosageInstruction.sequence ..0
* dosageInstruction.additionalInstruction ..0
* dosageInstruction.patientInstruction ..0
* dosageInstruction.timing ..0
* dosageInstruction.asNeeded ..0
* dosageInstruction.asNeededFor ..0
* dosageInstruction.site ..0
* dosageInstruction.route ..0
* dosageInstruction.method ..0
* dosageInstruction.doseAndRate ..0
* dosageInstruction.maxDosePerPeriod ..0
* dosageInstruction.maxDosePerAdministration ..0
* dosageInstruction.maxDosePerLifetime ..0
* substitution ..0
* eventHistory ..0