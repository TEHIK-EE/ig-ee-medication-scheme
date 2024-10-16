Instance: MedicationStatement-history
InstanceOf: OperationDefinition
Usage: #definition
* extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* extension[=].valueInteger = 1
* extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* extension[=].valueCode = #trial-use
* url = "https://fhir.ee/OperationDefinition/MedicationStatement-history"
* version = "1.0.0"
* name = "Confirmed medications history"
* title = "Get history of medication statements"
* status = #active
* kind = #operation
* experimental = false
* date = "2024-07-09T00:00:00Z"
* publisher = "TEHIK"
* contact.name = "TEHIK"
* contact.telecom.system = #url
* contact.telecom.value = "https://tehik.ee"
* description = "Returns the history of the current MedicationPlan(confirmed MedicationStatements) for requested patient"
* jurisdiction = urn:iso:std:iso:3166#EE "Estonia"
* affectsState = false
* code = #history
* resource = #MedicationStatement
* system = false
* type = true
* instance = false
* parameter[0].name = #subject
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Patient"
* parameter[=].type = #Patient
* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "In force medication plan, i.e. the interconnected List, MedicationStatement and Medication resources"
* parameter[=].type = #Bundle