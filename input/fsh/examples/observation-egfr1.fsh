Instance: observation-egfr1
InstanceOf: Observation
Usage: #example
Description: "Example of a observation definition about eGFR" 
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-observation-egfr"
* language = #et
* status = #final 
* code = #62238-1
* subject = Reference(pat1MatiMeri)
* performer = Reference(PractRoleD12345)
* valueQuantity.value = 84
* valueQuantity.unit = "mg/ml/1, 73m2"
* referenceRange.low.value = 60
* referenceRange.low.unit = "mg/ml/1, 73m2"
* derivedFrom[0].display = "SIIA tuleb tervikdokumendi viide, kust analüüs pärit on?"