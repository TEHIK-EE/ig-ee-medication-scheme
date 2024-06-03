Profile: EEBasePatient
Parent: Patient
Id: ee-patient
Description: "Patsient. Patient is the subject of the medication overview."
* ^status = #draft
* ^experimental = true
* ^date = "2024-02-02T14:39:12.1785689+00:00"
* identifier ^example[0].label = "isikukood"
* identifier ^example[=].valueIdentifier.system = "https://fhir.ee/ValueSet/ee-patient-identity"
* identifier ^example[=].valueIdentifier.value = "41212120000"
* active ^example[0].label = "Kas see patsient on aktiivne?"
* active ^example[=].valueBoolean = true
* name ^example[0].label = "Esimene näidis"
* name ^example[=].valueHumanName.use = #official
* name ^example[=].valueHumanName.family = "Kokomelon"
* name ^example[=].valueHumanName.given = "Fiona"
* telecom ^example[0].label = "telefoninumber"
* telecom ^example[=].valueContactPoint.system = #phone
* telecom ^example[=].valueContactPoint.value = "51234567"
* telecom ^example[+].label = "email"
* telecom ^example[=].valueContactPoint.system = #email
* telecom ^example[=].valueContactPoint.value = "fiona@fiona.org"