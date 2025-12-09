Profile: EETISObservationEGFR
Parent: Observation
Id: ee-tis-observation-egfr
Description: "eGFR analüüsi tulemus. Observation about eGFR"
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-22T14:32:30.0668499+00:00"
//* identifier ^short = "TERVIKDOKUMENDI viide, kust analüüs pärit on? Dokumendi number."
//* instantiatesReference only Reference(EETISObservationDefinitionEGFR)
* status ^short = "|final| kui eGFR näit on ajaliselt kontrollperioodi sees ja OK. |unknown| kui näit on kontrollperioodist väljas (vananenud)."
* code ^short = "eGFR puhul LOINC 62238-1?"
* subject only Reference($ee-mpi-patient)
* performer only Reference($ee-practitioner or EETISPractitionerRole)
* value[x] only Quantity
* value[x] ^short = "Mõõdetud eGFR väärtus (ja ühik) ning lisaks referentsväärtus. Measured eGFR value."
* dataAbsentReason ^short = "If the eGFR has never been measured use this element and code |not-performed|"
* referenceRange ^short = "Siia tuleb referentsväärtus low(/high) kui vajalik"
* derivedFrom ^short = "Reference to a document/source where observation came from. (ee Siia tuleks tervikdokumendi viide, millest see analüüs pärit on.)"


