CodeSystem: ATC_EE
Id: atc-ee
Title: "Siseriiklik ATC"
Description: "WHO ATC klassifikatsioon koos Eesti laiendkoodidega. Tegemist on fragmendiga, näidisega selle IG jaoks. Tegelik loend tuleb ravimiametilt.  No actual CS in terminology server."

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
* #B01AC06 "Atsetüülsalitsüülhape"

ValueSet: ATC_EE_VS
Id: atc-ee
Title: "Siseriiklik ATC"
Description: "WHO ATC klassifikatsioon koos Eesti laiendkoodidega. Tegemist on fragmendiga, näidisega selle IG jaoks. Tegelik loend tuleb ravimiametilt. No actual VS in terminology server."

* ^experimental = false
* ^url = $atc-ee-VS
* include codes from system $atc-ee
