CodeSystem: ADDITIONAL_INFORMATION
Id: additional-information
Title: "additional information TEST-CS"
Description: "placeholder. USE text."
* ^url = $additional-information
* ^status = #draft
* ^content = #not-present

ValueSet: ADDITIONAL_INFORMATION_VS
Id: additional-information-VS
Title: "additional information TEST-VS"
Description: "placeholder. USE text."

* ^experimental = false
* ^url = $additional-information-VS
* include codes from system $additional-information