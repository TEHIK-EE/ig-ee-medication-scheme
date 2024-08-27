Instance: PractRoleD12345
InstanceOf: PractitionerRole
Usage: #example
Description: "Practitioner D12345 in practitioner role doctor and with occupation pediaater"
* meta.profile = "https://fhir.ee/base/StructureDefinition/ee-practitioner-role"
* active = true
* period.start = "2012-01-01"
* practitioner = Reference(D12345)
* organization = Reference(rh)
* code[0] = $practitioner-role#doctor "Doctor"
* code[+] = $ee-occupation#22122501 "Pediaater"
* specialty[0] = $sct#394537008 "Pediatric specialty"
* specialty[+] = $sct#418535003 "Pediatric immunology"
* specialty[+] = $sct#408439002 "Allergy - specialty"
* specialty[+] = $ee-medre-specialty#E290 "Pediaatria"
* specialty[+] = $ee-medre-specialty#E670 "Pediaatria allergoloogia lisapädevusega"