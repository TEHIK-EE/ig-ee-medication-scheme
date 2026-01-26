CodeSystem: ADDITIONAL_INFORMATION
Id: additional-information
Title: "additional information TEST-CS"
Description: "Placeholder. NO actual CS in terminologyserver. USE text."
* ^url = $additional-information
* ^status = #draft
* ^content = #not-present

ValueSet: ADDITIONAL_INFORMATION_VS
Id: additional-information
Title: "additional information TEST-VS"
Description: "Placeholder. NO actual VS in terminologyserver. USE text."

* ^experimental = false
* ^url = $additional-information-VS
* include codes from system $additional-information