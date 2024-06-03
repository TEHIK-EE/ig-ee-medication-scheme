CodeSystem: ATC_EE
Id: atc-ee
Title: "Siseriiklik ATC"
Description: "WHO ATC klassifikatsioon koos Eesti laiendkoodidega"

* ^url = $atc-ee
* ^status = #draft
* ^content = #fragment
* ^experimental = false

* #C01CA24 "epinefriin"
* #N05BA12 "alprasolaam"
* #H02AB02 "deksametasoon"
* #J01CE02 "fenoksümetüülpenitsilliin"
* #A10BA02 "metformiin"
* #A11DB85 "tiamiin+püridoksiin+tsüanokobalamiin+lidokaiin"

ValueSet: ATC_EE_VS
Id: atc-ee
Title: "Siseriiklik ATC"
Description: "WHO ATC klassifikatsioon koos Eesti laiendkoodidega"

* ^experimental = false
* ^url = $atc-ee-VS
* include codes from system $atc-ee