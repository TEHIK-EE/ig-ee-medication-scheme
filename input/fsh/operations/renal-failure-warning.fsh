Instance: Medication-renal-failure-warnings
InstanceOf: OperationDefinition
Usage: #definition
* extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* extension[=].valueInteger = 1
* extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* extension[=].valueCode = #trial-use
* url = "https://fhir.ee/OperationDefinition/renal-failure-warnings"
* version = "1.0.0"
* name = "Renal Failure Warnings"
* title = "Find renal failure warnings for medications"
* status = #active
* kind = #operation
* experimental = false
* date = "2025-07-11T00:00:00Z"
* publisher = "TEHIK"
* contact.name = "TEHIK"
* contact.telecom.system = #url
* contact.telecom.value = "https://tehik.ee"
* description = "The renal failure warnings operation is used to get renal warnings for given Medications or Medication Scheme."
* jurisdiction = urn:iso:std:iso:3166#EE "Estonia"
* affectsState = false
* code = #renal-failure-warnings
* resource = #Medication
* system = false
* type = true
* instance = false
* parameter[0].name = #subject
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Reference"
* parameter[=].type = #Reference
* parameter[+].name = #input
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "*"
* parameter[=].documentation = "List of new medications. If not empty then only warnings between input medications will be returned. Old medication warnings won't be returned."
* parameter[=].type = #Medication
* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Found warnings"
* parameter[=].type = #ClinicalUseDefinition