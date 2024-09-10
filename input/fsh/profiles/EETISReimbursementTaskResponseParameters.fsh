Profile: EETISReimbursementTaskResponseParameters
Parent: Parameters
Id: ee-tis-reimbursement-task-response-parameters
Description: "This resource passes information back to EETISReimbursementTask output about the e-Prescription Centre's answer of allowed reimbursement rates. Also, information about insurance, EU insurance, pension and pension for incapacity for work are passed back."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-05T14:08:48.1446292+00:00"
* parameter ^slicing.discriminator.type = #value
* parameter ^slicing.discriminator.path = "name" //enne oli "value"
* parameter ^slicing.rules = #closed
* parameter ^short = "Received reimbursement rate from EPC (Estonian Prescription Centre)"
//* parameter.name ^short = "Received reimbursement rate from EPC"
//* parameter.name ^definition = "reimbursementParameter" //"SOODUSMÄÄR (retseptikeskusest) päringu vastusena olenevalt, millised õigused on patsiendil."
* parameter contains
    insuranceParameter 0..* and
    insuranceEUParameter 0..* and
    oldAgePensionParameter 0..* and
    incapacityForWorkPensionParameter 0..* and
    reimbursementParameter 0..* 
* parameter[insuranceParameter] ^short = "A parameter received from the operation indicationg whether or not the patient is insured."
* parameter[insuranceParameter] ^definition = "Kindlustatus"
* parameter[insuranceParameter].name = "insuranceParameter"
* parameter[insuranceParameter].name ^short = "Insurance response"
* parameter[insuranceParameter].value[x] only boolean
* parameter[insuranceEUParameter] ^short = "A parameter received from the operation indication whether or not the patient has EU insurance."
* parameter[insuranceEUParameter] ^definition = "EU kindlustatus"
* parameter[insuranceEUParameter].name = "insuranceEUParameter"
* parameter[insuranceEUParameter].name ^short = "EU insurance response"
* parameter[insuranceEUParameter].value[x] only boolean
* parameter[oldAgePensionParameter] ^short = "A parameter received from the operation indicationg whether or not the patient has old age pension."
* parameter[oldAgePensionParameter] ^definition = "Vanaduspension"
* parameter[oldAgePensionParameter].name = "oldAgePensionParameter"
* parameter[oldAgePensionParameter].name ^short = "Old age pension response"
* parameter[oldAgePensionParameter].value[x] only boolean
* parameter[incapacityForWorkPensionParameter] ^short = "A parameter received from the operation indication whether the patient has pension for incapacity for work."
* parameter[incapacityForWorkPensionParameter] ^definition = "Töövõimetuspension"
* parameter[incapacityForWorkPensionParameter].name = "incapacityForWorkPensionParameter"
* parameter[incapacityForWorkPensionParameter].name ^short = "Pension for incapacity for work"
* parameter[incapacityForWorkPensionParameter].value[x] only boolean
* parameter[reimbursementParameter].name = "reimbursementParameter"
* parameter[reimbursementParameter].name ^short = "Received reimbursement rate from EPC"
* parameter[reimbursementParameter].name ^definition = "Soodusmäär retseptikeskusest"
* parameter[reimbursementParameter].part ^slicing.discriminator.type = #value
* parameter[reimbursementParameter].part ^slicing.discriminator.path = "name" //enne oli "value"
* parameter[reimbursementParameter].part ^slicing.rules = #open
* parameter[reimbursementParameter].part ^short = "Received reimbursement rate and condition from EPC (Estonian Prescription Centre)"
* parameter[reimbursementParameter].part ^definition = "Soodusmäär ning vajalikud tingimused soodustuse saamiseks retseptikeskusest"
* parameter[reimbursementParameter].part contains
     condition 1..1 and
     rate 1..*
* parameter[reimbursementParameter].part[condition].name = "condition"
* parameter[reimbursementParameter].part[condition].name ^short = "Received reimbursement Condition from EPC."
* parameter[reimbursementParameter].part[condition].name ^definition = "Vajalikud tingimused- LOEND"
* parameter[reimbursementParameter].part[condition].value[x] only CodeableConcept
//* parameter[reimbursementParameter].part[condition].value[x] ^binding.description = "Vajalikud tingimused- LOEND" kuniks pole päris loendit, ei saa binding-descriptionit panna.
* parameter[reimbursementParameter].part[rate].name = "rate"
* parameter[reimbursementParameter].part[rate].name ^short = "Received reimbursement rate from EPC"
* parameter[reimbursementParameter].part[rate].value[x] only CodeableConcept
* parameter[reimbursementParameter].part[rate].value[x] from $retsepti-soodustuse-maar-VS (preferred)
//* parameter[reimbursementParameter].name ^short = "reimbursementParameter"
//* parameter[reimbursementParameter].part.name ^short = "reimbursementRateParameter"
//* parameter[reimbursementParameter].part.name ^definition = "soodusmäär" 
//* parameter[reimbursementParameter].part.value[x] only CodeableConcept
//* parameter[reimbursementParameter].part.value[x] from $retsepti-soodustuse-maar-VS (preferred)
//* parameter[reimbursementParameter].part.name ^short = "reimbursementConditionParameter"
//* parameter[reimbursementParameter].part.name ^definition = "vajalikud tingimused"
//* parameter[reimbursementParameter].part.value[x] only CodeableConcept
//* parameter[reimbursementRateParameter].value[x] only CodeableConcept
//* parameter[reimbursementRateParameter].value[x] from $retsepti-soodustuse-maar-VS (preferred)
//* parameter[reimbursementRateParameter].value[x] ^binding.description = "Soodustuse määr"
//* parameter[reimbursementConditionParameter].value[x] only CodeableConcept
//* parameter[reimbursementConditionParameter].value[x] ^binding.description = "Vajalikud tingimused"