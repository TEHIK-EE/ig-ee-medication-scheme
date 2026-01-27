# Ravimiskeemi printvaate pärimine
Ravimiskeemi printvaate operatsioon tagastab kasutajale html renderduse kinnitatud ravimiskeemist.
```
URL: GET [base]/MedicationStatement/$printout?subject=Patient/12345&language=et
```

Päring töötab valiidse Charon v2 tokeniga. Päringu parameetris olev "subject" ja charon tokeni päringusse pandud "patient" peavad olema samad.
Kohustuslik header "x-context-id" - kasutatakse audit logikirje tekitamisel. Sobib näiteks sesssiooni ID.

**DEV näidispäring**
```
curl -k -L 'https://10.0.13.90/r1/ee-dev/GOV/70009770/uptis/fis-service/fhir/MedicationStatement/$printout?subject=Patient/7231&language=et' \
-H 'X-Road-Client: ee-dev/GOV/70009770/tjt' \
-H 'x-context-id: my-context' \
-H 'Authorization: Bearer xxx'
```
