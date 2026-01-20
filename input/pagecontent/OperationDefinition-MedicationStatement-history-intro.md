# Ravimiskeemi ajaloo andmete pärimine

Ravimiskeemi ajalugu näitab kõiki patsiendile kunagi määratud ravimeid, sh neid, mis on juba aegunud või annulleeritud.



Ravimiskeemi ajaloo päring tagastab korraga kogu patsiendi ravimiskeemide ajaloo. Hetkeseisuga ei ole plaanis luua võimalust otsingut või filtreerimist teostada (aga on võimalik, et see tulevikus siiski luuakse, kui jõudlusega peaks probleeme tekkima).



siia Canonical URL ja Formal definition

```
URL: GET \[base]/MedicationStatement/$history?subject=Patient/12345
```

Päring töötab valiidse Charon v2 tokeniga. Päringu parameetris olev "subject" ja charon tokeni päringusse pandud "patient" peavad olema samad.

Kohustuslik header "x-context-id" - kasutatakse audit logikirje tekitamisel. Sobib näiteks sesssiooni ID.

```
DEV näidispäring

curl -k -L 'https://10.0.13.90/r1/ee-dev/GOV/70009770/uptis/fis-service/fhir/MedicationStatement/$history?subject=Patient/7231' \\

-H 'X-Road-Client: ee-dev/GOV/70009770/tjt' \\

-H 'x-context-id: my-context' \\

-H 'Authorization: Bearer xxx'
```