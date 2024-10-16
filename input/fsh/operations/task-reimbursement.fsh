Instance: Task-reimbursements
InstanceOf: OperationDefinition
Usage: #definition
* extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* extension[=].valueInteger = 1
* extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* extension[=].valueCode = #trial-use
* url = "https://fhir.ee/OperationDefinition/Task-reimbursements"
* version = "1.0.0"
* name = "Reimbursements"
* title = "Task reimbursements"
* status = #active
* kind = #operation
* experimental = false
* date = "2024-03-13T11:30:00Z"
* publisher = "TEHIK"
* contact.name = "TEHIK"
* contact.telecom.system = #url
* contact.telecom.value = "https://tehik.ee"
* description = "The reimbursement operation is used to get possible reimbursement for given Medication."
* jurisdiction = urn:iso:std:iso:3166#EE "Estonia"
* affectsState = false
* code = #reimbursements
* resource = #Task
* system = false
* type = true
* instance = false
* parameter[0].name = #input
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Task input containing Medication and MedicationStatement as contained resources"
* parameter[=].type = #Task
* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Found reimbursements"
* parameter[=].type = #Task