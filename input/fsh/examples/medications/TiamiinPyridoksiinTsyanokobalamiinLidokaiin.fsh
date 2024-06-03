Instance: TiamiinPyridoksiinTsyanokobalamiinLidokaiin
InstanceOf: Medication
Usage: #example
Description: "Description of medication Milgamma with four ingredient"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-medication-epc"
* extension[0].url = "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification"
* extension[=].valueCodeableConcept = $atc-ee#A11DB85 "tiamiin+püridoksiin+tsüanokobalamiin+lidokaiin"
* extension[+].url = "https://fhir.ee/StructureDefinition/ee-tis-size-of-item"
* extension[=].valueQuantity = 2 $retsept-mahu-ja-massiyhik#ML
* doseForm = $ravimvormid#1695 "süstesuspensiooni lahus"
* totalVolume.value = 10

* ingredient[0].item.concept = $toimeained#12785 "tiamiin"
* ingredient[=].isActive = true
* ingredient[=].strengthRatio.numerator = 50 $retsept-mahu-ja-massiyhik#MG
* ingredient[=].strengthRatio.denominator = 1 $retsept-mahu-ja-massiyhik#ML

* ingredient[+].item.concept = $toimeained#11887 "püridoksiin"
* ingredient[=].isActive = true
* ingredient[=].strengthRatio.numerator = 50 $retsept-mahu-ja-massiyhik#MG
* ingredient[=].strengthRatio.denominator = 1 $retsept-mahu-ja-massiyhik#ML

* ingredient[+].item.concept = $toimeained#10853 "tsüanokobalamiin"
* ingredient[=].isActive = true
* ingredient[=].strengthRatio.numerator = 0.5 $retsept-mahu-ja-massiyhik#MG
* ingredient[=].strengthRatio.denominator = 1 $retsept-mahu-ja-massiyhik#ML

* ingredient[+].item.concept = $toimeained#8546 "lidokaiin"
* ingredient[=].isActive = true
* ingredient[=].strengthRatio.numerator = 10 $retsept-mahu-ja-massiyhik#MG
* ingredient[=].strengthRatio.denominator = 1 $retsept-mahu-ja-massiyhik#ML