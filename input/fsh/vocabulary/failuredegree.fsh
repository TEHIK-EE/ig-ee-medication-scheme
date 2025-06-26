CodeSystem: FAILURE_DEGREE
Id: failure-degree
Title: "testimiseks kas saaab ilma päriselt eksisteeriva cs v vs-ta"
Description: "testimiseks"
* ^url = $failure-degree
* ^status = #draft
* ^content = #not-present

//* #0 "All"
//* #1 "Topical"
//* #2 "Systemic"
//* #3 "Parenteral"
//* #4 "Enteral"

ValueSet: FAILURE_DEGREE_VS
Id: failure-degree-VS
Title: "testin"
Description: "testimiseks"

* ^experimental = false
* ^url = $failure-degree-VS
* include codes from system $failure-degree