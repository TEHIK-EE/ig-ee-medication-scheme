CodeSystem: DRUG_FORM_GROUP
Id: drug-form-group
Title: "Siseriiklik ATC"
Description: "WHO ATC klassifikatsioon koos Eesti laiendkoodidega"

* ^url = $drug-form-group
* ^status = #draft
* ^content = #fragment
* ^experimental = false

* #0 "All"
* #1 "Topical"
* #2 "Systemic"
* #3 "Parenteral"
* #4 "Enteral"

ValueSet: DRUG_FORM_GROUP_VS
Id: drug-form-group-VS
Title: "test drug form group"
Description: "testimiseks"

* ^experimental = false
* ^url = $drug-form-group-VS
* include codes from system $drug-form-group