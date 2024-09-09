Instance: parameters-response
InstanceOf: Parameters
Usage: #example
Description: "Soodustuse päringu vastus. Response for reimbursement parameters."
* parameter[0].name = "insuranceParameter"
* parameter[=].valueBoolean = true
* parameter[+].name = "insuranceEUParameter"
* parameter[=].valueBoolean = true
* parameter[+].name = "oldAgePensionParameter"
* parameter[=].valueBoolean = true
* parameter[+].name = "incapacityForWorkPensionParameter"
* parameter[=].valueBoolean = false
* parameter[+].name = "reimbursementParameter"
* parameter[=].part[0].name = "condition"
* parameter[=].part[=].valueCodeableConcept = #9004
* parameter[=].part[+].name = "rate"
* parameter[=].part[=].valueCodeableConcept = #090
