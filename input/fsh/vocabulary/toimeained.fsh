CodeSystem: Toimeained
Id: toimeained
Title: "Toimeained"
Description: "Ravimiameti nimekiri ravimite toimeainetest"

* ^url = $toimeained
* ^status = #draft
* ^content = #fragment
* ^experimental = false

* #8554 "epinefriin"
* #11707 "alprasolaam"
* #8510 "deksametasoon"
* #11470 "fenoksümetüülpenitsilliin"
* #11354 "metformiin"
* #12785 "tiamiin"
* #11887 "püridoksiin"
* #10853 "tsüanokobalamiin"
* #8546 "lidokaiin"

ValueSet: Toimeained_VS
Id: toimeained
Title: "Toimeainete loend"
Description: "Ravimiameti nimekiri ravimite toimeainetest"

* ^url = $toimeained-VS
* ^experimental = false
* include codes from system $toimeained