## Reeglid
Patsiendi ravimiskeemi printvaate pärimiseks mõeldud operatsioon koosneb järgnevatest tegevusest:

### Kinnitatud ravimiskeemi pärimine
Siin küsitakse täpselt sama ravimiskeem, mida tagastatakse ka kinnitatud ravimiskeemi päringus

### Ravimiskeemi printvaate loomine
Kinnitatud ravimiskeemi andmed muundatakse printvaate jaoks sobilikule kujule ja jaotatakse kolmeks:

Vajadusel ravimid (ravikuuri tüüp 'v')
Regulaarsed ravimid (ravikuuri tüüp 'p')
Ajutised ravimid (ravikuuri tüüp ''f' ja ravim väljastatud viimase 180 päeva jooksul, konfigureeritav läbi configmapi `TEMPORARY_MEDICATION_PERIOD_DAYS` env väärtuse)
Kasutades thymeleafi template'i, pannakse kokku ravimiskeemi dokument, mis on ehitatud Terviseportaali nõuete kohaselt patsiendile andmiseks.

### Ravimiskeemi tagastamine
Saadud html dokument kodeeritakse base64 kodeeringuga UTF-8 formaadis ning tagastatakse kasutajale. Edasised toimingud dokumendi printimiseks on kasutajate teha.

Soovituslikult kuvada html dokument implementeeriva rakenduse sees - hetkel ei tagastata fondi infot html-ga ning "Roboto" font on vaja implementeerival rakendusel ise kaasa anda.

## Näited
