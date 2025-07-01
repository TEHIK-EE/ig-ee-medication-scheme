Instance: observation-egfr1
InstanceOf: Observation
Usage: #example
Description: "Example of a observation definition about eGFR" 
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-observation-egfr"
* language = #et
* status = #active
* code = #62238-1
* subject = Reference(pat1MatiMeri)
* performer = Reference(PractRoleD12345)
* derivedFrom.display = "SIIA tuleb tervikdokumendi viide, kust analüüs pärit on?"