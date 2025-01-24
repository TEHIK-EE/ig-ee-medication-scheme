Instance: Interactions
InstanceOf: OperationDefinition
Usage: #definition
* extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* extension[=].valueInteger = 1
* extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* extension[=].valueCode = #trial-use
* url = "https://fhir.ee/OperationDefinition/interactions"
* version = "1.0.0"
* name = "Interactions"
* title = "Find interactions for medications"
* status = #active
* kind = #operation
* experimental = false
* date = "2024-05-13T00:00:00Z"
* publisher = "TEHIK"
* contact.name = "TEHIK"
* contact.telecom.system = #url
* contact.telecom.value = "https://tehik.ee"
* description = "The interactions operation is used to get interactions for given Medications or MedicationPlan."
* jurisdiction = urn:iso:std:iso:3166#EE "Estonia"
* affectsState = false
* code = #interactions
* resource[0] = #Medication
* resource[+] = #Patient
* system = false
* type = true
* instance = false
* parameter[0].name = #subject
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Patient"
* parameter[=].type = #Patient
* parameter[+].name = #input
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "*"
* parameter[=].documentation = "List of new medications. If not empty then only interactions between input medications will be returned. Old medication interactions won't be returned if they don't interact with new medications."
* parameter[=].type = #Medication
* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Found interactions"
* parameter[=].type = #ClinicalUseDefinition