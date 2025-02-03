Instance: raud-patient-reported
InstanceOf: Medication
Usage: #example
Description: "Description of patient reported food supplement"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-patient-reported"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name"
* extension[=].valueString = "RAUD 25MG"
* identifier.system =  "https://jvis.agri.ee"
* identifier.value = "412462"