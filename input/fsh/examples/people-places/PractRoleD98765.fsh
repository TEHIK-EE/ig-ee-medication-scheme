Instance: PractRoleD98765
InstanceOf: PractitionerRole
Usage: #example
Description: "Practitioner D98765 in practitioner role doctor and with occupation kardioloog"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
* language = #et
* active = true
* period.start = "2012-01-01"
* practitioner = Reference(D98765)
* organization = Reference(rh)
* code[0] = $practitioner-role#doctor "Doctor"
* code[+] = $ee-occupation#22120901 "Kardioloog"
* code[+] = $autoriseerimismooduli-kasutajarollid#doctor "Arst"
//* specialty[0] = $sct#394579002 "Cardiology (qualifier value)"
//* specialty[+] = $sct#1251549008 "Interventional cardiology (qualifier value)"
* specialty[0] = $ee-medre-specialty#E170 "Kardioloogia"