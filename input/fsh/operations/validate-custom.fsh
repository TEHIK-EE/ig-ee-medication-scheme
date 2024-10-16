Instance: MedicationStatement-validate-custom
InstanceOf: OperationDefinition
Usage: #definition
* extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* extension[=].valueInteger = 1
* extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* extension[=].valueCode = #trial-use
* url = "https://fhir.ee/OperationDefinition/MedicationStatement-validate-custom"
* version = "1.0.0"
* name = "Custom Statement Validation"
* title = "Validate MedicationStatement business rules"
* status = #active
* kind = #operation
* experimental = false
* date = "2024-09-02T00:00:00Z"
* publisher = "TEHIK"
* contact.name = "TEHIK"
* contact.telecom.system = #url
* contact.telecom.value = "https://tehik.ee"
* description = "Builds on the default validate, by running MedIN specific business rules and RK checks"
* jurisdiction = urn:iso:std:iso:3166#EE "Estonia"
* affectsState = false
* code = #validate-custom
* resource = #MedicationStatement
* system = false
* type = true
* instance = false
* parameter[0].name = #input
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Bundle of MedicationStatements and Medications"
* parameter[=].type = #Bundle
* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Occurred issues (if any)"
* parameter[=].type = #OperationOutcome