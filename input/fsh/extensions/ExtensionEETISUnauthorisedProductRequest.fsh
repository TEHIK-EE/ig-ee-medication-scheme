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
* extension[requestNumber] ^short = "Müügiloata ravimi taotluse number"
* extension[requestNumber].value[x] only id
* extension[requestNumber].value[x] ^short = "Müügiloata ravimi taotluse number"
* extension[requestNumber].value[x] ^definition = "Every marketing request has its own unique number."
* extension[requestReason] ^short = "Müügiloata ravimi taotluse põhjus"
* extension[requestReason].value[x] only CodeableConcept
* extension[requestReason].value[x] from $myygiloata-ravimi-taotluse-pohjendus-VS (preferred)
* extension[requestReason].value[x] ^binding.description = "Myygiloata ravimi pohjendus. LOEND"
* extension[requestStatus].value[x] only CodeableConcept
* extension[requestStatus].value[x] from $myygiloata-ravimi-taotluse-staatus-VS (preferred)
* extension[requestStatus].value[x] ^short = "Positiivne | Negatiivne"
* extension[requestStatus].value[x] ^definition = "Taotlus rahuldati või taotlust ei rahuldatud. Value of extension - must be one of a constrained set of the data types (see [Extensibility](extensibility.html) for a list)."
* extension[requestStatus].value[x] ^binding.description = "Müügiloata ravimi taotluse staatuse loend"
* extension[requestDate] ^short = "Müügiloata ravimi taotluse kuupäev"
* extension[requestDate] ^definition = "Date when the request was made.\r\n\r\nMay be used to represent additional information that is not part of the basic definition of the element. To make the use of extensions safe and managable, there is a strict set of governance applied to the definition and use of extensions. Though any implementer can define an extension, there is a set of requirements that SHALL be met as part of the definition of the extension."
* extension[requestDate].value[x] only dateTime
* extension[requestNegDecision].value[x] only CodeableConcept
* extension[requestNegDecision].value[x] from $myygiloata-ravimi-neg-otsuse-pohjendus-VS (required)
* extension[requestNegDecision].value[x] ^short = "Negatiivse otsuse põhjendus. LOEND"
* extension[requestNegDecision].value[x] ^binding.description = "Müügiloata ravimi taotluse keelduva otsuse põhjendused"
* extension[requestReasonText].value[x] only string
* extension[requestReasonText].value[x] ^short = "reason in free form text"
* extension[requestReasonText].value[x] ^definition = "If the reason for requesting unauthorized medicine is not in the valueset there must be free form explanation for the request."
//* value[x] ^slicing.discriminator.type = #type
//* value[x] ^slicing.discriminator.path = "$this"
//* value[x] ^slicing.rules = #open
//* sliceValue ^sliceName = "sliceValue"