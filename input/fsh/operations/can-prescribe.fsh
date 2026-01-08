Instance: can-prescribe
InstanceOf: OperationDefinition
Usage: #definition
* extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* extension[=].valueInteger = 1
* extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* extension[=].valueCode = #trial-use
* url = "https://fhir.ee/OperationDefinition/can-prescribe"
* version = "1.0.0"
* name = "Can Prescribe"
* title = "Check if the medication can be prescribed"
* status = #active
* kind = #operation
* experimental = false
* date = "2025-09-15T00:00:00Z"
* publisher = "TEHIK"
* contact.name = "TEHIK"
* contact.telecom.system = #url
* contact.telecom.value = "https://tehik.ee"
* description = "The can prescribe operation checks if the Medication can be prescribed to the patient based on existing medications"
* jurisdiction = urn:iso:std:iso:3166#EE "Estonia"
* affectsState = false
* code = #can-prescribe
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
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Medication to be checked against current medications in scheme and prescribed drafts."
* parameter[=].type = #Medication
* parameter[+].name = #draft
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "*"
* parameter[=].documentation = "List of new medication drafts that the input medication is checked against."
* parameter[=].type = #Medication
* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Whether conflicts were found and the nature of the conflicts."
* parameter[=].type = #OperationOutcome