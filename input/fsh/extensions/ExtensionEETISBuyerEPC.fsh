Extension: ExtensionEETISBuyerEPC
Id: ee-tis-buyer-epc
Description: "Ostja. When someone other than the subject of prescription buys medication."
* ^status = #draft
* ^date = "2023-10-03T10:47:00.9373224+00:00"
* ^context.type = #element
* ^context.expression = "MedicationDispense"
* . ^short = "Identity code of the buyer of medicine when the buyer is someone else than the subject of prescription."
* . ^definition = "Ostja. Keegi teine kui see, kellele ravim välja kirjutati."
* value[x] 1..
* value[x] only string or Identifier
//* value[x] from $ee-identity-system (preferred)
* value[x] ^short = "Buyer's identity code"
* value[x] ^definition = "Ravimit välja ostva isiku isikukood."
//* value[x] ^binding.description = "Identity System"