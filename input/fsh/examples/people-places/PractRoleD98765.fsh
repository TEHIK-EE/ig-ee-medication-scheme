Instance: PractRoleD98765
InstanceOf: PractitionerRole
Usage: #example
Description: "Practitioner D98765 in practitioner role doctor and with occupation kardioloog"
* meta.profile = "https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
* active = true
* period.start = "2012-01-01"
* practitioner = Reference(D98765)
* organization = Reference(rh)
* code[0] = $practitioner-role#doctor "Doctor"
* code[+] = $ee-occupation#22120901 "Kardioloog"
* specialty[0] = $sct#394579002 "Cardiology"
* specialty[+] = $sct#1251549008 "Interventional cardiology"
* specialty[+] = $ee-medre-specialty#E170 "Kardioloogia"