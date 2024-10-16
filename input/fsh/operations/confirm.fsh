Instance: MedicationStatement-confirm
InstanceOf: OperationDefinition
Usage: #definition
* extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* extension[=].valueInteger = 1
* extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* extension[=].valueCode = #trial-use
* url = "https://fhir.ee/OperationDefinition/MedicationStatement-confirm"
* version = "1.0.0"
* name = "Confirm"
* title = "Medication Statement Confirm"
* status = #active
* kind = #operation
* experimental = false
* date = "2024-02-29T15:21:02+11:00"
* publisher = "TEHIK"
* contact.name = "TEHIK"
* contact.telecom.system = #url
* contact.telecom.value = "https://tehik.ee"
* description = "The $confirm operation manages a medication plan of a patient, i.e. creates a snapshot of effective medication statements as well as propagates medication requests."
* jurisdiction = urn:iso:std:iso:3166#EE "Estonia"
* affectsState = true
* code = #confirm
* resource = #MedicationStatement
* system = false
* type = true
* instance = false
* parameter[0].name = #lastKnownConfirmation
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Fully qualified reference to the previous medication plan (i.e. List resource)"
* parameter[=].type = #Reference
* parameter[+].name = #input
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Added, changed and ceased medication statements and the included medication resources as they should be persisted in the next snapshot of the medication plan"
* parameter[=].type = #Bundle
* parameter[+].name = #confirmer
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "The PractitionerRole resource of the practitioner confirming the statements, will be added to prescribed statements and list resource as contained resource"
* parameter[=].type = #PractitionerRole
* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "In force medication plan, i.e. the interconnected List, MedicationStatement and Medication resources"
* parameter[=].type = #Bundle