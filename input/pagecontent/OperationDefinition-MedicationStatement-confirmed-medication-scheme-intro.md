# Ravimiskeemi andmete pärimine

URL: GET [base]/MedicationStatement/$confirmed-medication-scheme?subject=Patient/12345

Päring töötab valiidse Charon v2 tokeniga. Päringu parameetris olev "subject" ja charon tokeni päringusse pandud "patient" peavad olema samad.

Kohustuslik header "x-context-id" - kasutatakse audit logikirje tekitamisel. Sobib näiteks sesssiooni ID.
```
DEV näidispäring
curl -k -L 'https://10.0.13.90/r1/ee-dev/GOV/70009770/uptis/fis-service/fhir/MedicationStatement/$confirmed-medication-scheme?subject=Patient/7231' \
-H 'X-Road-Client: ee-dev/GOV/70009770/tjt' \
-H 'x-context-id: my-context' \
-H 'Authorization: Bearer xxx'
```
This is NOT an idempotent operation