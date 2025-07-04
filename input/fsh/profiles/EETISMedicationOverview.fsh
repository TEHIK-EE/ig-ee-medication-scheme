Profile: EETISMedicationOverview
Parent: Bundle
Id: ee-tis-medication-overview
Description: "Ravimiskeem kui dokument. Hetkel ei kasuta! Not in use. Medication Overview gathers together all resources related to patient's prescribed and dispensed medication."
* ^version = "1.0.0"
* ^date = "2024-02-13T09:32:10.2376124+00:00"
* . ^short = "Ravimiskeem"
* . ^definition = "Ravimiskeem koosneb ravimiskeemiridadest. A container for a collection of resources."
* type = #document
* entry 1..
* entry ^slicing.discriminator[0].type = #type
* entry ^slicing.discriminator[0].path = "resource"
* entry ^slicing.ordered = false
* entry ^slicing.rules = #open
* entry contains
    compositionEntry 1..1 and
    medicationsStatementEntry 0..* and
    practitionerEntry 0..* and
    practitionerRoleEntry 0..* and
    organizationEntry 0..* and
    patientEntry 0..* and
    medicationEntry 0..* and
    pharmacyLocationEntry 0..* and
    medicationRequestEntry 0..* and
    communicationEntry 0..* and
    observationEntry 0..* and
    clinicalUseDefinitionEntry 0..*
* entry[compositionEntry].resource only EETISComposition
* entry[medicationsStatementEntry].resource only EETISMedicationStatement
* entry[practitionerEntry].resource only EETISPractitioner
* entry[practitionerRoleEntry].resource only EETISPractitionerRole
* entry[organizationEntry].resource only EETISOrganization
* entry[patientEntry].resource only $ee-mpi-patient
//* entry[deviceEntry].resource only Device
* entry[medicationEntry].resource only EETISMedicationEPC or EETISMedicationExtemporal or EETISMedicationDispensedToPatient
* entry[pharmacyLocationEntry].resource only EETISPharmacyLocation
* entry[medicationRequestEntry].resource only EETISPrescription
* entry[communicationEntry].resource only EETISCommunication
* entry[observationEntry].resource only EETISObservationEGFR
* entry[clinicalUseDefinitionEntry].resource only EETISRenalFailureDS or EETISMedicationInteraction