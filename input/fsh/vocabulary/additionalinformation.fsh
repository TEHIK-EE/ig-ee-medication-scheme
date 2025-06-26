CodeSystem: ADDITIONAL_INFORMATION
Id: additional-information
Title: "testimiseks kas saaab ilma päriselt eksisteeriva cs v vs-ta"
Description: "testimiseks"
* ^url = $additional-information
* ^status = #draft
* ^content = #not-present

ValueSet: ADDITIONAL_INFORMATION_VS
Id: additional-information-VS
Title: "testin"
Description: "testimiseks"

* ^experimental = false
* ^url = $additional-information-VS
* include codes from system $additional-information