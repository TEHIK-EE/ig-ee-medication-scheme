Profile: EETISMedicationDispensedToPatient
Parent: Medication
Id: ee-tis-medication-dispensed-to-patient
Description: "Väljamüüdud ravim. Medication resource as it is presented today in Estonian e-Prescription center (Retseptikeskus). Used on prescriptions and dispensations."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-14T14:34:42.5909877+00:00"
* ^publisher = "TEHIK"
* ^contact[0].name = "TEHIK"
* ^contact[=].telecom[0].system = #url
* ^contact[=].telecom[=].value = "https://www.tehik.ee"
* ^contact[=].telecom[+].system = #email
* ^contact[=].telecom[=].value = "fhir@tehik.ee"
* ^jurisdiction = urn:iso:std:iso:3166#EE "Estonia"
* meta.versionId ^example.label = "versionId"
* meta.versionId ^example.valueId = "1"
* extension contains
    ExtensionEETISMedicinalProductName named name 0..1
* identifier 0..1
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^short = "Package code when medication is prescribed based on specific package. Slice prescriptionNumber is used for grouping medications in TJT. ATC is found in extension."
* identifier ^definition = "Pakendi kood (pakendipõhisel retseptil), või grupeerimiseks kasutatav retseptinumber"
* identifier contains
    packageNumber 0..1 and
    prescriptionNumber 0..1
* identifier[packageNumber].system = $ravimiregister-pakend
* identifier[packageNumber].system 1..
* identifier[prescriptionNumber].system = $retseptikeskus-retsept
* identifier[prescriptionNumber].system 1..
* code ..0
* status ..0
* marketingAuthorizationHolder ..0
