Profile: EETISPharmacyLocation
Parent: $ee-location
Id: ee-tis-pharmacy-location
Description: "Apteegi asukoht. This resource is used when there is a need to specify a certain pharmacy for medication dispensation."
* ^status = #draft
* ^date = "2023-09-28T10:15:30.0319461+00:00"
* contained ..0
* identifier ^short = "Unique code or number identifying the location to its users"
* identifier ^definition ="APTEEGI TEGEVUSKOHA KOOD."
* operationalStatus ..0
* name ^short = "Name of the location as used by humans"
* name ^definition = "APTEEGI TEGEVUSKOHA NIMI." 
* type ..0
* position ..0
* managingOrganization ^short = "Organization responsible for provisioning and upkeep"
* managingOrganization ^definition = "APTEEGI ÄRIREGISTRI KOOD."
* partOf ..0
* characteristic ..0
* hoursOfOperation ..0
* virtualService ..0
* endpoint ..0