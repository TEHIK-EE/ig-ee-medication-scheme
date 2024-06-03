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
* parameter ^short = "Received reimbursement rate from EPC"
* parameter.name ^short = "Received reimbursement rate from EPC"
* parameter.name ^definition = "SOODUSMÄÄR päringu vastusena olenevalt, millised õigused on patsiendil. The name of the parameter (reference to the operation definition)."
* parameter contains
    insuranceParameter 0..* and
    insuranceEUParameter 0..* and
    oldAgePensionParameter 0..* and
    incapacityForWorkPensionParameter 0..* and
    reimbursementRateParameter 0..*
* parameter[insuranceParameter] ^short = "Kindlustatus"
* parameter[insuranceParameter] ^definition = "A parameter received from the operation indicationg whether or not the patient is insured."
* parameter[insuranceParameter].name ^short = "Insurance response"
* parameter[insuranceParameter].value[x] only boolean
* parameter[insuranceEUParameter] ^short = "EU kindlustatus"
* parameter[insuranceEUParameter] ^definition = "A parameter received from the operation indication whether or not the patient has EU insurance."
* parameter[insuranceEUParameter].name ^short = "EU insurance response"
* parameter[insuranceEUParameter].value[x] only boolean
* parameter[oldAgePensionParameter] ^short = "Vanaduspension"
* parameter[oldAgePensionParameter] ^definition = "A parameter received from the operation indicationg whether or not the patient has old age pension."
* parameter[oldAgePensionParameter].name ^short = "Old age pension response"
* parameter[oldAgePensionParameter].value[x] only boolean
* parameter[incapacityForWorkPensionParameter] ^short = "Töövõimetuspension"
* parameter[incapacityForWorkPensionParameter] ^definition = "A parameter received from the operation indication whether the patient has pension for incapacity for work."
* parameter[incapacityForWorkPensionParameter].name ^short = "Pension for incapacity for work"
* parameter[incapacityForWorkPensionParameter].value[x] only boolean
* parameter[reimbursementRateParameter].value[x] only CodeableConcept
* parameter[reimbursementRateParameter].value[x] from $retsepti-soodustuse-maar-VS (preferred)
* parameter[reimbursementRateParameter].value[x] ^binding.description = "Soodustuse määr"