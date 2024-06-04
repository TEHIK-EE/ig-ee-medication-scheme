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
* . ^definition = "Ravimi soodustuse määr protsentides Retseptikeskuse loendist \"Soodustuste määrad\" ning tingimused soodustuse saamiseks."
* extension contains
    reimbursementRate 0..* and
    reimbursementReason 0..*
* extension[reimbursementRate].value[x] only CodeableConcept
* extension[reimbursementRate].value[x] from $retsepti-soodustuse-maar-VS (preferred)
* extension[reimbursementRate].value[x] ^short = "Reimbursement rate of prescription medicine.\r\n0 | 50 | 75 | 90 | 100"
* extension[reimbursementRate].value[x] ^binding.description = "Retsepti soodustuse määr"
* extension[reimbursementReason] ^short = "Condition according to the list of reimbursed pharmaceuticals"
* extension[reimbursementReason] ^definition = "Soodusravimite loetelule vastav tingimus"
* extension[reimbursementReason].value[x] only string