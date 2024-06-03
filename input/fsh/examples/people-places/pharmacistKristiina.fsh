Instance: pharmacistKristiina
InstanceOf: PractitionerRole
Usage: #example
Description: "Practitioner with Medre code P00197 in practitioner role pharmacist"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
* active = true
* practitioner.identifier.system = $medre
* practitioner.identifier.value = "P00197"
* practitioner.display = "Proviisor Kristiina Kuldkepp"
* organization.identifier.value = "74000091"
* organization.display = "Haigekassa"
* code = $practitioner-role#pharmacist "pharmacist"
* contact.telecom.system = #email
* contact.telecom.value = "apteek123@tehik.ee"