Instance: prescription-adrenalin-pos-dec
InstanceOf: MedicationRequest
Usage: #example
Description: "Unauthorized medication adrenaline with positive decision for marketing request and permission to form prescription"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-prescription"
* language = #et
//* implicitRules = "http://hl7.org/fhir/reference"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-rate"
* extension[=].extension[0].url = "reimbursementRate"
* extension[=].extension[=].valueCodeableConcept = $retsepti-soodustuse-maar#000 "0%"
* extension[=].extension[+].url = "reimbursementCondition"
* extension[=].extension[=].valueCodeableConcept = $reimbursement-condition#90_1 "vajalikud tingimused bla bla"
* extension[=].extension[+].url = "reimbursementSpeciality"
* extension[=].extension[=].valueCodeableConcept = $erialad#E110 "dermatoveneroloogia"
//* extension[=].extension[=].valueCodeableConcept.coding.display = "siia tuleb kirjeldus vajalikud-tingimused-loendist"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-dispensation-authorization"
* extension[=].valueCodeableConcept = $retsepti-volituse-liik#public "Avalik"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-lock-status"
* extension[=].extension[0].url = "lockStatus"
* extension[=].extension[=].valueBoolean = true
* extension[=].extension[+].url = "lockOwner"
* extension[=].extension[=].valueString = "Tehiku Apteek"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-unauthorized-product-request"
* extension[=].extension[0].url = "requestNumber"
* extension[=].extension[=].valueId = "123456"
* extension[=].extension[+].url = "requestReason"
* extension[=].extension[=].valueCodeableConcept = $myygiloata-ravimi-taotluse-pohjendus#ML01 "Eestis puudub haiguse/seisundi raviks müügiloaga ravim"
* extension[=].extension[+].url = "requestStatus"
* extension[=].extension[=].valueCodeableConcept = $myygiloata-ravimi-taotluse-otsus#P "Otsus positiivne"
* extension[=].extension[+].url = "requestDate"
* extension[=].extension[=].valueDateTime = "2023-11-11"
//* extension[=].extension[+].url = "requestNegDecision"
//* extension[=].extension[=].valueCodeableConcept = $myygiloata-ravimi-neg-otsuse-pohjendus#ON04 "Tegelikult, kui on positiivne otsus siis negatiivset keeldumist siia ei tule ju."
//* identifier.system = https://fhir.ee/CodeSystem/tis-fhir-identifikaatorid/retseptikeskus-retsept
* identifier.value = "1018862058"
* status = #active
* statusChanged = "2023-11-07"
* intent = #proposal
* category[0] = $retsepti-liik#1 "tavaretsept"
* category[+] = $retsepti-kordsus#1 "1-kordne"
* medication.reference = Reference(adrenalin)
* subject = Reference(pat1MatiMeri)
* authoredOn = "2023-11-07"
* reason.concept = $rhk-10#D89.8 "Immuunmehhanismi hõlmavad mujal klassifitseerimata muud täpsustatud haigusseisundid"
* dosageInstruction.timing.repeat.count = 1
* dosageInstruction.doseAndRate.doseQuantity = 1 $retsept-annustamise-yhik#ML "milliliiter"
* dispenseRequest.validityPeriod.start = "2023-11-07"
* dispenseRequest.validityPeriod.end = "2024-02-07"
//* dispenseRequest.dispenser.display = "TEHIKu apteek"
// Kas siia jääb ainult tekst?