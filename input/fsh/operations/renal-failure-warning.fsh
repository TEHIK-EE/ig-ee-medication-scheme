/*Instance: renal-failure-warning
InstanceOf: OperationDefinition
Usage: #definition
* extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* extension[=].valueInteger = 1
* extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* extension[=].valueCode = #trial-use
* url = "https://fhir.ee/OperationDefinition/renal-failure-warning"
* version = "1.0.0"
* name = "Renal failure warning"
* title = "Find renal failure warnings"
* status = #active
* kind = #operation
* experimental = false
* date = "2024-05-13T00:00:00Z"
* publisher = "TEHIK"
* contact.name = "TEHIK"
* contact.telecom.system = #url
* contact.telecom.value = "https://tehik.ee"
* description = "The operation is used to get warnings about renal failure for given Medications."
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
* parameter[=].documentation = "Patient MPI reference of who the medication scheme and eGFR result warning checked. "
* parameter[=].type = #Patient
* parameter[+].name = #input
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "*"
* parameter[=].documentation = "List of medications (if added) of which renal function failure warnings are held against."
* parameter[=].type = #Medication
* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Always Bundle, if no warnings then the bundle is empty. Every warning for different active ingredient is separate warning."
* parameter[=].type = #Bundle
*/
