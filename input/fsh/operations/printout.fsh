Instance: MedicationStatement-printout
InstanceOf: OperationDefinition
Usage: #definition
* extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* extension[=].valueInteger = 1
* extension[+].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status"
* extension[=].valueCode = #trial-use
* url = "https://fhir.ee/OperationDefinition/MedicationStatement-printout"
* version = "1.0.0"
* name = "Confirmed Medication Scheme printout"
* title = "Return confirmed medication scheme printout"
* status = #active
* kind = #operation
* experimental = false
* date = "2025-01-30T00:00:00Z"
* publisher = "TEHIK"
* contact.name = "TEHIK"
* contact.telecom.system = #url
* contact.telecom.value = "https://tehik.ee"
* description = "The printout operation is used to get current confirmed medication scheme as an html document for printing."
* jurisdiction = urn:iso:std:iso:3166#EE "Estonia"
* affectsState = false
* code = #printout
* resource = #MedicationStatement
* system = false
* type = true
* instance = false
* parameter[0].name = #subject
* parameter[=].use = #in
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].targetProfile = "EEBasePatient"
* parameter[=].scope = #type
* parameter[=].documentation = "Patsiendi MPI viide - kelle ravimiskeemi printvaadet päritakse"
* parameter[=].type = #Patient
* parameter[+].name = #language
* parameter[=].use = #in
* parameter[=].min = 0
* parameter[=].max = "1"
* parameter[=].documentation = "Keel milles soovitakse ravimiskeemi kuvada. Nt 'et' või 'en' vaikimisi väärtus on 'et'."
* parameter[=].type = #string
* parameter[+].name = #return
* parameter[=].use = #out
* parameter[=].min = 1
* parameter[=].max = "1"
* parameter[=].documentation = "Operatsiooni väljundiks on alati Binary, mille sisuks on UTF-8 formaadis base64 kodeeritud html dokument."
* parameter[=].type = #Binary