/*Profile: EETISClaimForReimbursement
Parent: Claim
Id: ee-tis-claim-for-reimbursement
Description: "This resource is used for asking the National Health Insurance Fund reimbursement for prescription medication. The percent of the reimbursement depends on the medication, age, diagnose etc."
* ^version = "1.0.0"
* ^status = #retired
* ^experimental = true
* ^date = "2024-02-01T11:50:21.649163+00:00"
* contained ..0
* subType 1..
* subType from $retsepti-soodustuse-maar-VS (preferred)
* subType ^short = "Soodustuse määr. Loend."
* patient only Reference($ee-mpi-patient) 
* enterer 1..
* enterer only Reference(EETISPractitioner or EETISPractitionerRole)
* insurer only Reference(EETISOrganization)
* priority ..0
* fundsReserve ..0
* prescription 1..
* prescription only Reference(EETISPrescription)
* originalPrescription ..0
* payee ..0
* referral ..0
* encounter ..0
* facility ..0
* diagnosisRelatedGroup ..0
* event ..0
* careTeam ..0
* diagnosis 1..1
* diagnosis.diagnosis[x] only CodeableConcept
* diagnosis.diagnosis[x] from $rhk-10-VS (preferred)
//* diagnosis.diagnosis[x] ^binding.description = "RHK-10"
* procedure ..0
* accident ..0
*/