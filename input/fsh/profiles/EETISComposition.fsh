Profile: EETISComposition
Parent: Composition
Id: ee-tis-composition
Description: "Kokkuvõte. Hetkel ei kasuta (vajalik Document Bundle jaoks). This resource gathers together all resources needed to form a document for Medication Overview bundle. Currently replaced with List."
* ^url = "https://fhir.ee/StructureDefinition/ee-tis-composition"
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-01-31T13:55:03.1985103+00:00"
* category ..0
* subject only Reference($ee-mpi-patient)
* subject ^type.aggregation = #referenced
* encounter ..0
* useContext ..0
* author only Reference(Device)
* author ^type.aggregation = #contained
* title ^short = "Ravimiskeem"
* note.author[x] 1..
* note.author[x] only string or Reference(EETISPractitionerRole or EETISPractitioner)
* note.time 1..
* attester 1..1
* attester ^short = "Practitioner who has verified medication scheme."
* attester ^definition = "KES KINNITAS RAVIMISKEEMI. ARST."
* attester.mode ^fixedCodeableConcept.text = "professional"
* attester.party only Reference(EETISPractitionerRole or EETISPractitioner or EETISOrganization)
* custodian ..0
* relatesTo ..0
* event ..0
* section.author ..0
* section.focus ..0
* section.orderedBy ^short = "SYSTEEM SORTEERIB? Order of section entries"
* section.entry only Reference
* section.entry ^slicing.discriminator.type = #profile
* section.entry ^slicing.discriminator.path = "reference"
* section.entry ^slicing.rules = #open
* section.entry ^type.aggregation = #contained
* section.entry contains
    medicationStatementEntry 0..* and
    medicationDispenseEntry 0..* and
    medicationRequestEntry 0..* and
    patientEntry 0..* and
    medicationEntry 0..* and
    practitionerEntry 0..* and
    practitionerRoleEntry 0..* and
    organizationEntry 0..* and
    communicationEntry 0..* and
    observationEntry 0..* and
    clinicalUseDefinitionEntry 0..*
* section.entry[medicationStatementEntry] only Reference(EETISMedicationStatement)
* section.entry[medicationDispenseEntry] only Reference(EETISPrescriptionDispense)
* section.entry[medicationRequestEntry] only Reference(EETISPrescription)
* section.entry[patientEntry] only Reference($ee-mpi-patient)
* section.entry[medicationEntry] only Reference(EETISMedicationEPC or EETISMedicationExtemporal or EETISMedicationDispensedToPatient)
* section.entry[practitionerEntry] only Reference(EETISPractitioner)
* section.entry[practitionerRoleEntry] only Reference(EETISPractitionerRole)
* section.entry[organizationEntry] only Reference(EETISOrganization)
* section.entry[communicationEntry] only Reference(EETISCommunication)
* section.entry[observationEntry] only Reference(EETISObservationEGFR)
* section.entry[clinicalUseDefinitionEntry] only Reference(EETISRenalFailureDS or EETISMedicationInteraction)
* section.section ..0