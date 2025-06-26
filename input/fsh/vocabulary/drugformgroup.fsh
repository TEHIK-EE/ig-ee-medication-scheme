CodeSystem: DRUG_FORM_GROUP
Id: drug-form-group
Title: "drug form groub TEST-CS"
Description: "placeholder. USE text."
* ^url = $drug-form-group
* ^status = #draft
* ^content = #not-present

//* #0 "All"
//* #1 "Topical"
//* #2 "Systemic"
//* #3 "Parenteral"
//* #4 "Enteral"

ValueSet: DRUG_FORM_GROUP_VS
Id: drug-form-group
Title: "drug form groub TEST-VS"
Description: "placeholder. USE text."

* ^experimental = false
* ^url = $drug-form-group-VS
* include codes from system $drug-form-group