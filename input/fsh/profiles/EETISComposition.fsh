Profile: EETISComposition
Parent: Composition
Id: ee-tis-composition
Description: "Kokkuvõte. Hetkel ei kasuta (vajalik Document Bundle jaoks). This resource gathers together all resources needed to form a document for Medication Overview bundle. Currently replaced with List."
* ^url = "https://fhir.ee/StructureDefinition/ee-tis-composition"
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-01-31T13:55:03.1985103+00:00"
* category ..0
* subject only Reference(EETISPatient)
* subject ^type.aggregation = #referenced
* encounter ..0
* useContext ..0
* author only Reference(Device)
* author ^type.aggregation = #contained
* title ^short = "Ravimiskeem"
* note.author[x] 1..
* note.author[x] only string or Reference(Practitioner or PractitionerRole)
* note.time 1..
* attester 1..1
* attester ^short = "KES KINNITAS RAVIMISKEEMI. ARST. Attests to accuracy of composition"
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
    relatedPersonEntry 0..* and
    pharmacyLocationEntry 0..* and
    deviceEntry 0..*
* section.entry[medicationStatementEntry] only Reference(EETISMedicationStatement)
* section.entry[medicationDispenseEntry] only Reference(EETISPrescriptionDispense)
* section.entry[medicationRequestEntry] only Reference(EETISPrescription)
* section.entry[patientEntry] only Reference(EETISPatient)
* section.entry[medicationEntry] only Reference(EETISMedicationEPC)
* section.entry[practitionerEntry] only Reference(EETISPractitioner)
* section.entry[practitionerRoleEntry] only Reference(EETISPractitionerRole)
* section.entry[organizationEntry] only Reference(EETISOrganization)
* section.entry[relatedPersonEntry] only Reference(EETISRelatedPerson)
* section.entry[pharmacyLocationEntry] only Reference(EETISPharmacyLocation)
* section.entry[deviceEntry] only Reference(Device)
* section.section ..0