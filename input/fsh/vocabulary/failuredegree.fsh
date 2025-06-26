CodeSystem: FAILURE_DEGREE
Id: failure-degree
Title: "failure degree TEST-CS"
Description: "placeholder. USE text."
* ^url = $failure-degree
* ^status = #draft
* ^content = #not-present

//* #0 "All"
//* #1 "Topical"
//* #2 "Systemic"
//* #3 "Parenteral"
//* #4 "Enteral"

ValueSet: FAILURE_DEGREE_VS
Id: failure-degree
Title: "failure degree TEST-VS"
Description: "placeholder. USE text."

* ^experimental = false
* ^url = $failure-degree-VS
* include codes from system $failure-degree