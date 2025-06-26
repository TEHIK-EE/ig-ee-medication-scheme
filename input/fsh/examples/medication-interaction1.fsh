/*Instance: medication-interaction1
InstanceOf: ClinicalUseDefinition
Usage: #example
Description: "Example of a medication interaction between medication A and B" 
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-interaction"
* language = #et
* status = #active
* contained[0] = metformin
* contained[+] = adrenalin
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-affected-medication-statements"
* extension[=].valueReference = Reference(MedicationStatement-metformin)
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-affected-medication-statements"
* extension[=].valueReference = Reference(MedicationStatementAdrenalin)
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-additional-information-link"
* extension[=].valueString = "www.synbase.ee/metformin+adrenalin"
* type = #interaction
//* category[0] = $clinical-importance-category-VS#4 
//* category[ClinicalImportance] ^short = "Clinical importance category"
// * category[0].text = "D. Kliiniliselt oluline koostoime, mida saab juhtida n&#228;iteks annuse kohandamisega"
//* category[ScientificDocumentation] ^short = "Scientific documentation category"
//* category[+] = $scientific-documentation-category-VS#4 
// * category[+].text = "0. Andmed on saadud asjakohase patsiendiryhma seas korraldatud kontrollitud uuringutest"
* subject.reference = "#metformin"
//* subject.identifier.valueIdentifier = "11354"
* interaction.interactant.itemReference.reference = "#adrenalin" 
//* interaction.interactant.itemCodeableConcept = "10355"
* interaction.type = $interaction-type#drug-drug "drug to drug interaction"
* interaction.type.text = "drug to drug interaction"
* interaction.effect.concept.text = "Consequences. Ravim A vererõhku alandav ja diureetiline toime võib ravim B-ga kooskasutamisel nõrgeneda ning suurendada kehakaalu. Vererõhk kõrgeneb enamasti vähe või mõõdukalt, kuid hüpertensiooni tüsistuste tekke oht võib suureneda, eriti eakatel."
* interaction.incidence.text = "D0"
* interaction.management.text = "Recommendation. Kui kooskasutamine on vajalik, on soovitatav hoolikalt jälgida vererõhku ja kehakaalu. Ravimi A annust võib olla vaja kohandada. Kaaluda raviks xxx, kuna Ravim B ei vähenda toimet."
*/