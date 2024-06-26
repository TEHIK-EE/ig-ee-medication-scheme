Extension: ExtensionEETISTotalPrescribedAmount
Id: ee-tis-total-prescribed-amount
Description: "Väljakirjutatud kogus. How much in total there is medication prescribed on one Medication Request."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-01-30T12:44:53.0886848+00:00"
* ^context[0].type = #element
* ^context[=].expression = "MedicationStatement"
* ^context[+].type = #element
* ^context[=].expression = "MedicationRequest"
* . ^short = "How much in total there is medication prescribed on one Medication Request. Used for calculating the current status of how much medication is left on one Medication Statement row."
* . ^definition = "Kui palju on ravimit koguseliselt välja kirutatud - näiteks 120 tabletti. Selle pealt saab arvutada JÄÄKI.  \r\nVäljakirjutatud kogus. \r\n"
* value[x] only SimpleQuantity
* value[x] ^short = "Total prescribed amount of medication on one prescription"
* value[x] ^definition = "Ravimi koguhulk ja ühik."