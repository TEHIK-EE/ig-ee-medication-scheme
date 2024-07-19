Extension: ExtensionEETISUnauthorizedProductRequest
Id: ee-tis-unauthorized-product-request
Description: "Müügiloata ravimi taotlus. Used for requesting marketing permit for unauthorized medication."
* ^status = #draft
* ^date = "2024-02-21T12:14:43.6691324+00:00"
* ^context[0].type = #element
* ^context[=].expression = "MedicationRequest"
* ^context[+].type = #element
* ^context[=].expression = "MedicationStatement"
* . ^short = "Müügiloata ravimi taotlus."
* . ^definition = "Used for requesting marketing permit for unauthorized medication."
* . ^isModifier = false
* extension contains
    requestNumber 0..1 and
    requestReason 1..1 and
    requestStatus 0..1 and
    requestDate 1..1 and
    requestNegDecision 0..1 and
    requestReasonText 0..*
* extension[requestNumber] ^short = "Request number for unauthorized medication marketing request"
* extension[requestNumber].value[x] only id
* extension[requestNumber].value[x] ^short = "Marketing request decision number given by Ravimiamet. Every marketing request has its own unique number."
* extension[requestNumber].value[x] ^definition = "Müügiloata ravimi otsuse number, mille annab Ravimiamet."
* extension[requestReason] ^short = "Reason for unauthorized medication marketing request"
* extension[requestReason] ^definition = "Müügiloata ravimi taotluse põhjus"
* extension[requestReason].value[x] only CodeableConcept
* extension[requestReason].value[x] from $myygiloata-ravimi-taotluse-pohjendus-VS (preferred)
* extension[requestReason].value[x] ^binding.description = "Myygiloata ravimi pohjendus. LOEND"
* extension[requestStatus].value[x] only CodeableConcept
* extension[requestStatus].value[x] from $myygiloata-ravimi-taotluse-staatus-VS (preferred)
* extension[requestStatus].value[x] ^short = "Unauthorized medication marketing request ststus\r\nPositiivne | Negatiivne"
* extension[requestStatus].value[x] ^definition = "Taotlus rahuldati või taotlust ei rahuldatud."
* extension[requestStatus].value[x] ^binding.description = "Müügiloata ravimi taotluse staatuse loend"
* extension[requestDate] ^short = "Date when the request was made."
* extension[requestDate] ^definition = "Müügiloata ravimi taotluse kuupäev."
* extension[requestDate].value[x] only dateTime
* extension[requestNegDecision].value[x] only CodeableConcept
* extension[requestNegDecision].value[x] from $myygiloata-ravimi-neg-otsuse-pohjendus-VS (required)
* extension[requestNegDecision].value[x] ^short = "Reason for a declining the request."
* extension[requestNegDecision].value[x] ^definition = "Negatiivse otsuse põhjendus. LOEND"
* extension[requestNegDecision].value[x] ^binding.description = "Müügiloata ravimi taotluse keelduva otsuse põhjendused"
* extension[requestReasonText].value[x] only string
* extension[requestReasonText].value[x] ^short = "Reason in free form text. If the reason for requesting unauthorized medicine is not in the valueset there must be free form explanation for the request."
* extension[requestReasonText].value[x] ^definition = "Negatiivse otsuse põhjendus kui loendist on valitud 'muu'"
//* value[x] ^slicing.discriminator.type = #type
//* value[x] ^slicing.discriminator.path = "$this"
//* value[x] ^slicing.rules = #open
//* sliceValue ^sliceName = "sliceValue"