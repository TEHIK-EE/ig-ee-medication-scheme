Profile: EETISObservationEGFR
Parent: Observation
Id: ee-tis-observation-egfr
Description: "Neerufunktsiooni vastuses tagastatav analüüsi tulemus."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-02-22T14:32:30.0668499+00:00"
//* identifier ^short = "TERVIKDOKUMENDI viide, kust analüüs pärit on? Dokumendi number."
//* instantiatesReference only Reference(EETISObservationDefinitionEGFR)
* status ^short = "Siin on kohustusliku staatuse koodid NB!"
* code ^short = "siin on vist LOINC 62238-1?"
* subject only Reference($ee-mpi-patient)
* performer only Reference(EETISPractitioner or EETISPractitionerRole)
* derivedFrom ^short = "Siia tuleks tervikdokumendi viide, millest see analüüs pärit on"


