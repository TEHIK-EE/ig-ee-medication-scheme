Profile: EETISPrescriptionDispense
Parent: MedicationDispense
Id: ee-tis-prescription-dispense
Description: "Ravimi väljastamine. When the medication prescribed is dispensed in pharmacy."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-01-31T14:08:33.4764521+00:00"
* . ^short = "Dispensation of prescribed medication to the patient"
* . ^definition = "Ravimi väljastamine patsiendile."
* contained ..0
* extension contains
    ExtensionEETISBuyerEPC named extensionEETISBuyerEPC 0..* and
    ExtensionEETISReimbursementRate named extensionEETISReimbursementRate 0..*
* extension[extensionEETISBuyerEPC].value[x] ^short = "Personal identification code of the buyer"
* extension[extensionEETISBuyerEPC].value[x] ^definition = "OSTJA ISIKUKOOD"
* identifier ..0
* basedOn ..0
* partOf ..0
* status = #completed (exactly)
* status ^short = "When dispensation occurres it is always completed."
* status ^definition = "Ravimi väljamüük saab olla ainult \"completed\" staatuses, kui ravimit ei saa müüa siis muutub kas retsepti või ravimiskeemi rea staatus ja dispense pole üldse."
* notPerformedReason ..0
* statusChanged ..0
* category ..0
* medication only CodeableReference(EETISMedicationDispensedToPatient or EETISMedicationExtemporal)
* medication ^short = "Dispensed medication"
* medication ^definition = "Väljastatud ravim"
//* medication ^type.aggregation = #referenced
//* medication.concept ..0
//* medication.reference only Reference(EETISMedicationEPC or EETISMedicationExtemporal)
//* medication.reference ^type.aggregation = #referenced
* subject only Reference(EETISPatient)
* subject ^short = "Patient recieving the medication"
* subject ^definition = "Patsient, kellele ravim väljastatakse"
//* subject ^type.aggregation = #referenced
* encounter ..0
* supportingInformation ..0
* performer 1..1
* performer ^short = "Indicates who or what performed the event."
* performer ^definition = "Väljastuse teostaja ehk kes väljastas ravimi patsiendile. "
* performer.function ..0
* performer.actor only Reference(EETISPractitionerRole)
* performer.actor ^short = "Pharmacist or assistant pharmacist who has the rights to dispense meditcation."
* performer.actor ^definition = "Proviisor või farmatseut, kellel on õigus väljastada ravimit"
* location only Reference(EETISPharmacyLocation)
* location ^short = "The principal physical location where the dispense was performed."
* location ^definition = "APTEEK ja SELLE KOOD KUS RAVIM VÄLJASTATI.Apteegi tegevuskoha kood."
* location.identifier ^short = "Logical reference, when literal reference is not known"
* location.identifier ^definition = "APTEEGI TEGEVUSKOHA KOOD. Logical reference, when literal reference is not known"
* authorizingPrescription 1..
* authorizingPrescription only Reference(EETISPrescription)
* authorizingPrescription ^short = "Retsept, mille alusel ravim väljastati patsiendile."
* type ..0
* quantity 1..
* quantity ^short = "The amount of medication that has been dispensed. Includes unit of measure."
* quantity ^definition = "Väljastatud ravimi kogus. Pakendite arv, mis väljastati. "
* quantity.unit ..0
* quantity.system ..0
* quantity.code ..0
* daysSupply ..0
* recorded ..0
* whenPrepared ..0
* whenHandedOver 1..
* whenHandedOver ^short = "The time the dispensed product was provided to the patient or their representative."
* whenHandedOver ^definition = "Väljastamise aeg. Kuupäev ja kellaaeg, millal ravim anti üle patsiendile, või tema esindajale. "
* destination ..0
* receiver ..1
* receiver ^short = "Who collected the medication or where the medication was delivered"
* receiver ^definition = "KUI RAVIMI OSTAB VÄLJA KEEGI TEINE KUI SEE, KELLELE RAVIM ON VÄLJAKIRJUTATUD EI KASUTATA SEDA VAID ExtensionEETISBuyerEPC."
* receiver.identifier.value 1..
* receiver.identifier.value ^short = "Buyers personal identification code. Logical reference, when literal reference is not known"
* receiver.identifier.value ^definition = "OSTJA ISIKUKOOD"
//* receiver.identifier.system 1..
//* receiver.identifier.system = $isikukood (exactly)
* note ..1
* note ^short = "Extra information about the dispense that could not be conveyed in the other attributes."
* note ^definition = "Kommentaar väljastuse kohta. Kommentaari saab lisada ainult see, kes teostas ravimi väljastuse apteegis. "
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