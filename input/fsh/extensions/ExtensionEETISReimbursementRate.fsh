Extension: ExtensionEETISReimbursementRate
Id: ee-tis-reimbursement-rate
Description: "Soodustuse määr ja tingimused (soodusravimite nimekirja järgi). For representation of the reimbursement rate and reason of prescription medicine."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-01-31T14:08:33.4764521+00:00"
* ^context[0].type = #element
* ^context[=].expression = "MedicationStatement"
* ^context[+].type = #element
* ^context[=].expression = "MedicationRequest"
* ^context[+].type = #element
* ^context[=].expression = "MedicationDispense"
* . ^short = "Reimbursement rate and reason of prescription medicine."
* . ^definition = "Ravimi soodustuse määr protsentides Retseptikeskuse loendist \"Soodustuste määrad\" ning tingimused \"Vajalikud tingimused\" -loendist soodustuse saamiseks."
* extension contains
    reimbursementRate 0..* and
    reimbursementCondition 0..*
* extension[reimbursementRate].value[x] only CodeableConcept
* extension[reimbursementRate].value[x] from $retsepti-soodustuse-maar-VS (preferred)
* extension[reimbursementRate].value[x] ^short = "Reimbursement rate of prescription medicine.\r\n0 | 50 | 75 | 90 | 100"
* extension[reimbursementRate].value[x] ^binding.description = "Retsepti soodustuse määr. Loend"
* extension[reimbursementCondition] ^short = "Condition according to the list of reimbursed pharmaceuticals. Code from Retseptikeskus and description as display in text field."
* extension[reimbursementCondition] ^definition = "\"Vajalikud tingimused\"loendist kood ning kirjeldus. Soodusravimite loetelule vastav tingimus."
* extension[reimbursementCondition].value[x] only CodeableConcept
* extension[reimbursementCondition].value[x] from $reimbursement-condition-VS (preferred)
* extension[reimbursementCondition].value[x] ^binding.strength = #preferred
* extension[reimbursementCondition].value[x] ^binding.description = "\"Vajalikud tingimused -loend\" retseptikeskusest"
//* extension[reimbursementCondition].text ^short = "Textual description of conditions for reimbursement"
//* extension[reimbursementCondition].text ^definition = "Tekstiline kirjeldus vajalikest tingimustest soodustuse saamiseks"