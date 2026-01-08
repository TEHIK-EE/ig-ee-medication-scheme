# Ravimiskeemi printvaate pärimine
Ravimiskeemi printvaate operatsioon tagastab kasutajale html renderduse kinnitatud ravimiskeemist.

URL: GET [base]/MedicationStatement/$printout?subject=Patient/12345&language=et

Päring töötab valiidse Charon v2 tokeniga. Päringu parameetris olev "subject" ja charon tokeni päringusse pandud "patient" peavad olema samad.
Kohustuslik header "x-context-id" - kasutatakse audit logikirje tekitamisel. Sobib näiteks sesssiooni ID.

DEV näidispäring
```
curl -k -L 'https://10.0.13.90/r1/ee-dev/GOV/70009770/uptis/fis-service/fhir/MedicationStatement/$printout?subject=Patient/7231&language=et' \
-H 'X-Road-Client: ee-dev/GOV/70009770/tjt' \
-H 'x-context-id: my-context' \
-H 'Authorization: Bearer xxx'
```

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
**Näidispäring patsiendi viitega**

Ravimiskeemi printvaate pärimine:
```
GET /MedicationStatement/$printout?subject=Patient/140959&language=et
```
**Näidisvastus** 

Ravimiskeemi printvaate näidisvastus:

```
{
  	"resourceType": "Binary",
  	"contentType": "text/html",
	"data": "Base64EncodedString"
}
```

<div>
<img src="printout.svg"  alt="printout" width="50%">
<p>Printvaate näidis</p>
<p></p>
</div>