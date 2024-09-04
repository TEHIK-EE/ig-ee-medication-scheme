Profile: EETISReimbursementTaskResponseParameters
Parent: Parameters
Id: ee-tis-reimbursement-task-response-parameters
Description: "This resource passes information back to EETISReimbursementTask output about the e-Prescription Centre's answer of allowed reimbursement rates. Also, information about insurance, EU insurance, pension and pension for incapacity for work are passed back."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-05T14:08:48.1446292+00:00"
* parameter ^slicing.discriminator.type = #value
* parameter ^slicing.discriminator.path = "value"
* parameter ^slicing.rules = #open
* parameter ^short = "Received reimbursement rate from EPC (Estonian Prescription Centre)"
* parameter.name ^short = "Received reimbursement rate from EPC"
* parameter.name ^definition = "SOODUSMÄÄR (retseptikeskusest) päringu vastusena olenevalt, millised õigused on patsiendil."
* parameter contains
    insuranceParameter 0..* and
    insuranceEUParameter 0..* and
    oldAgePensionParameter 0..* and
    incapacityForWorkPensionParameter 0..* and
    reimbursementRateParameter 0..* and
    reimbursementConditionParameter 0..*
* parameter[insuranceParameter] ^short = "A parameter received from the operation indicationg whether or not the patient is insured."
* parameter[insuranceParameter] ^definition = "Kindlustatus"
* parameter[insuranceParameter].name ^short = "Insurance response"
* parameter[insuranceParameter].value[x] only boolean
* parameter[insuranceEUParameter] ^short = "A parameter received from the operation indication whether or not the patient has EU insurance."
* parameter[insuranceEUParameter] ^definition = "EU kindlustatus"
* parameter[insuranceEUParameter].name ^short = "EU insurance response"
* parameter[insuranceEUParameter].value[x] only boolean
* parameter[oldAgePensionParameter] ^short = "A parameter received from the operation indicationg whether or not the patient has old age pension."
* parameter[oldAgePensionParameter] ^definition = "Vanaduspension"
* parameter[oldAgePensionParameter].name ^short = "Old age pension response"
* parameter[oldAgePensionParameter].value[x] only boolean
* parameter[incapacityForWorkPensionParameter] ^short = "A parameter received from the operation indication whether the patient has pension for incapacity for work."
* parameter[incapacityForWorkPensionParameter] ^definition = "Töövõimetuspension"
* parameter[incapacityForWorkPensionParameter].name ^short = "Pension for incapacity for work"
* parameter[incapacityForWorkPensionParameter].value[x] only boolean
* parameter[reimbursementRateParameter].value[x] only CodeableConcept
* parameter[reimbursementRateParameter].value[x] from $retsepti-soodustuse-maar-VS (preferred)
* parameter[reimbursementRateParameter].value[x] ^binding.description = "Soodustuse määr"
* parameter[reimbursementConditionParameter].value[x] only CodeableConcept
* parameter[reimbursementConditionParameter].value[x] ^binding.description = "Vajalikud tingimused"