/*Instance: task1reimbursement-request-from-epc
InstanceOf: Task
Usage: #example
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-reimbursement-task"
//* implicitRules = "http://hl7.org/fhir/reference"
//* basedOn = Reference(listMatiMeri3)
* status = #requested
* intent = #proposal
* priority = #routine
* focus = Reference(MedicationStatementNovorapid)
* input.type = $task-input-parameter-type#050 "soodusmäär"
* input.type.text = "soodustuse küsimine ravimile Novorapid"
* input.valueReference = Reference(MedicationStatementNovorapid)
* input.valueReference.type = "StructureDefinition"
* output.type = $task-output-parameter-type#jah "soodustus milleks õigus"
* output.valueCodeableConcept = $retsepti-soodustuse-maar#100 "100%"
* output.valueCodeableConcept.text = "ilma diagnoosikoodita on soodustus 50%, koodidega E10-E11; E13-E14; E89.1; O24; P70.2 on 100%"
*/