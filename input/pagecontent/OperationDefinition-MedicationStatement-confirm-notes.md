## Ärireeglid
Ravimiskeemi kinnitamine koosneb mitmest järjestikku tehtavast tegevusest. Üldine reegel on, et kui tekib vigu, katkestatakse töö ning FHIR andmeid ei salvestata.
**NB!** äriloogilised veaolukorrad on toodud all iga ploki juures, küll aga ei ole seal eraldi välja toodud liidestustel tekkivad tehnilised vead - **juhul kui tekib tehniline viga, katkeb operation'i töö ja FHIR andmed jäävad salvestamata,** ja OperationOutcome sisaldab **veakoodi ja kirjeldust**, mis annavad teenuse kasutajale teada, et tegemist on just **tehnilise veaga.**

Skeemil on toodud tegevuste järjekord, iga ploki kohta on eraldi kirjeldus allpool.  

**NB!** Tugevaks äriliseks eelduseks kinnitamise edukusele on, et Ravimiskeemi pärimisel on saadud viimane seis nii FHIR andmetes kui ka retseptikeskuse retseptidest - vt [Kinnitatud ravimiskeemi pärimine](OperationDefinition-MedicationStatement-confirmed-medication-scheme.html) 

<div>
<img src="andmetekinnitamine.svg"  alt="Ravimiskeemi kinnitamine - üldine protsess" width="60%">
<p>Ravimiskeemi kinnitamine - üldine protsess</p>
<p></p>
</div>

## Sisendiandmete esmane validatsioon ja töötlus
*NB!* eeltöötlus ei peegelda tingimata koodis loodud lahendust vaid pigem äriloogilist andmetega tegelemise viisi - reaalset rakenduse koodi vaadates ei pruugi loogika asuda tegevuste järjekorras selles kohas*
Esmase validatsioonina rakendab FHIR server automaatset sisendandmete valideerimist vastu FHIR profiile ning kasutatud terminoloogiat. (vt ka MedIN Andmekvaliteedi kontrollid)
Edasiseks andmete töötluseks tehakse **esmalt** sisemiselt [Kinnitatud ravimiskeemi pärimine](OperationDefinition-MedicationStatement-confirmed-medication-scheme.html), rakendades kogu seal olevat loogikat, et saada kätte hetkel kehtiv ravimiskeemi seis ning võrrelda sisendisse tulnud andmeid sellega, mis on hetkel kehtiv skeem.
Edasi jaotuvad andmed vastavalt järgmisele skeemile:

<div>
<img src="sisendiandmetetootlus.svg"  alt="Sisendiandmete töötlus" width="80%">
<p>Ravimiskeemi andmete kinnitamine - Sisendiandmete töötlus</p>
<p></p>
</div>

Selleks, et hõlbustada edasiste kontrollide ja sooritatavate tegevuste läbi viimist, eristatakse sisendisse tulnud andmetes järgmiseid seisusid, mis väljenduvad ka kinnitamise lõpuks tekkiva [EETISMedicationList] atribuudis List.entry.flag: 
**NB!** töötlemisel on ka oluline järjekord, kuna iga järgnev samm eeldab, et eelmine on läbitud:
- Juhul kui MedicationStatement.id ei ole määratud 
    - JA puudub MedicationStatment.identifier mille system oleks (https://fhir.ee/retseptikeskus-retsept), siis List.Entry.item.flag=**prescribed** ehk tegemist on uue lisatava reaga
    - JA on olemas MedicationStatment.identifier mille system oleks (https://fhir.ee/retseptikeskus-retsept) 
        - AGA andmeid EI OLE muudetud → siis on List.Entry.item.flag=**unchanged** ehk tegemist on Retseptikeskuse andmetest genereeritud reaga, mis vajab salvestamist
        - KUI andmed ON muudetud, käitub rida samamoodi, nagu oleks real olemas MedicationStatement.id ja andmeid on muudetud (vt edasi)
- Juhul kui MedicationStatement.id on määratud
    - JA andmeid EI OLE muudetud võrreldes serveri versiooniga, siis List.Entry.item.flag=**unchanged** ehk tegemist on muutmata reaga
        - siin kehtib ka erijuht - juhul kui Kinnitatud ravimiskeemi pärimisel on saadud rida, mille flag on List.Entry.item.flag=**generated** ehk rida on baasis olemas, kuid sama reaga seotult on olemas Retseptikeskuses uuemad andmed - ka sellisel juhul määratakse List.Entry.item.flag=**unchanged** (vt ka B1 - olemas uus FHIR kinnitamine (A2) ja peale seda loodud RK retseptid - Kinnitatud ravimiskeemi pärimine)
    - KUI andmeid ON muudetud võrreldes serveri versiooniga
        - JA kui MedicationStatement.effective.end ON sisendis väärtustatud ja serveri versioonis ei ole, siis flag=ceased ehk tegemist on eemaldatava reaga
            - kõrvalmärkus: olukord, kus serveri versioonis on MedicationStatement.effective.end väärtustatud ja sisendis ei ole, on tehniline viga
        - KUI MedicationStatement.effective.end EI OLE sisendis väärtustatud 
            - JA retsepti mõjutavaid atribuute EI OLE muudetud (Ravimvorm/tugevus, Mitte asendada, ravimeid pakendis, pakkide arv, Müügiloata ravimi taotluse põhjendus + kirjeldus, retsepti kommentaar, Ravikuuri kestus, kordsus, volitus, retsepti kehtivus)  → siis List.Entry.item.flag=**changed** ehk tegemist on muudetud reaga, kus retsepte EI OLE vaja muuta
            - KUI retsepti mõjutavaid atribuute ON muudetud (Ravimvorm/tugevus, Mitte asendada, ravimeid pakendis, pakkide arv, Müügiloata ravimi taotluse põhjendus + kirjeldus, retsepti kommentaar, Ravikuuri kestus, kordsus, volitus, retsepti kehtivus)
                - JA MedicationStatement.partOf EI OLE  täidetud → siis List.Entry.item.flag=**changed** ehk tegemist on nn **"muutmisega"** ning sama reaga seotud **olemasolevad retseptid** tuleb **tühistada** ning seejärel **luua uued retseptid**
                - KUI ON täidetud → siis List.Entry.item.flag=changed ehk tegemist on nn "pikendamisega" ning sama reaga seotud olemasolevad retseptid tuleb jätta muutmata ning seejärel **luua uued täiendavad retseptid**.

Sisendi töötlemisel tehakse ühtlasi ka vajadusel andmete rikastamist :
- Kontrollitakse kas confirmer parameetris (või ka MedicationStatement.contained plokis) märgitud PractitionerRole ressursil on määratud kontaktandmed (telefon, email)
- Juhul kui ei ole, päritakse need (vt MedIN SPD integratsioon), andes ette PractitionerRole.organization viitest saadud asutuse registrikoodi

## Sisendi Äriloogilised kontrollid
Kogu sisendile teostatakse äriloogilised kontrollid vastavalt MedIN Andmekvaliteedi kontrollid 
- NB! siin olevad andmekvaliteedi kontrollid rakenduvad nii juba FHIR andmetes olevate ridade kui ka Retseptikeskuse andmetest genereeritud FHIR andmete peale - kattes kogu tervikut.
    - vt Ravimiskeemi väliselt loodud retseptide vastus
- Retseptikeskuse andmetest genereeritud ridadele kehtivad salvestamisel-valideerimisel erireeglid (nt autor võib erineda, alguse aeg võib olla minevikus jne) - need on vaja siia välja tuua, lisaks ka kirjeldada RK päringud, mida siin teostatakse
<div>
<img src="retseptikeskusekontrollid.svg"  alt="Retseptikeskuse kontrollid" width="80%">
<p>Ravimiskeemi kinnitamisel Retseptikeskuse kontrollid</p>
<p></p>
</div>

### Ärireeglid

- Tehakse päring, millega kontrollitakse, kas sisendisse tulnud viimasest kinnitamisest alates (või viimase 540p jooksul) on tekkinud juurde uusi (hilisema kuupäevaga) kehtivaid retsepte (vt Viimasest kinnitamisest alates loodud retseptide kontroll - päring )
    - Juhul on kui on, tähendab see, et "kehtiv seis" on edasi läinud - viga ja töö katkeb (veakood)
    - Juhul kui sisendisse ei olnud antud kinnitamise kuupäeva, kuid päringuga leiti andmeid, on olukord sama - see tähendab, et "kehtiv seis" on edasi läinud - viga ja töö katkeb (veakood)
- Tehakse päring, millega kontrollitakse, kas viimase 540p jooksul on juurde tekkinud uusi (hilisema annulleerimise kuupäevaga) annulleeritud retsepte (vt Viimasest kinnitamisest alates annulleeritud retseptide kontroll - päring)
    - Juhul on kui on, tähendab see, et "kehtiv seis" on edasi läinud - viga ja katkestame (veakood)
    - Juhul kui sisendisse ei olnud antud kinnitamise kuupäeva, kuid päringuga leiti andmeid, on olukord sama - see tähendab, et "kehtiv seis" on edasi läinud - viga ja töö katkeb (veakood)
    - *Kommentaar: selle päringuga kaetakse nii tundmatud retseptid kui ka ravimiskeemiga seotud retseptid. On ka võimalik, et vahepeal tehti uus retsept ja kohe tühistati, mis teatud mõttes ei ole huvipakkuv, kuid tehniliselt korrektne lahendus on ka siin öelda, et seis on tegelikult edasi läinud.*
- Juhul kui Ravimiskeemi ridadega seotud retseptidega on toimunud protsessis edasi liikumine (st staatus on muutunud Koostatud → Broneeritud/Väljastatud), ei ole see äriliselt oluline kinnitamisel ja seega ei tehta selle kohta eraldi päringut

## Koostoimete kontroll
### Ärireeglid

- Kõikidele sisendisse tulnud andmetele lisaks (eelnevate kontrollide läbimise põhjal eeldatakse, et sisend on täielik Retseptikeskuse andmestik ja muutmisele minev FHIR andmestik) leitakse kehtiva ravimiskeemi FHIR andmed
- Kehtivast FHIR ravimiskeemist välistatakse sisendisse tulnud kustutamisele määratud read (ceased) ja see liidetakse sisendisse tulnud andmestikule
- Summa alusel tehakse SynBase koostoimete päring ( vt MedIN Otsustustoe integratsioon )
    - vastusest välistatakse sellised koostoimete read, kus mõlemad koostoime toimeained kuuluvad ravimiskeemi reale, mis on jäänud antud kinnitamise sisendiga muutmata (unchanged)
- Kontrolliks võrreldakse sisendisse tulnud koostoimete kinnitust (consentWithInteractions) ja kas koostoimeid leiti või mitte
- Ainus lubatud olukord, on see, kus koostoimete kinnitus ja koostoimete olemasolu on võrdsed, kui ei ole - viga ja töö katkeb (veakood)

## Neerufunktsiooni hoiatuste kontroll
### Ärireeglid

- Kõikidest sisendisse tulnud andmetest leitakse ravimiskeemi read, mis on lisatud või mida on muudetud (kuid ei ole kustutamisele määratud) 
- Vastavalt Neerufunktsiooni languse hoiatuste pärimine#Patsiendineerun%C3%A4idup%C3%A4riminejaaegumiseloogika päritakse patsiendi eGFR ja selle tulemustega tehakse leitud ridade alusel SynBase neerufunktsiooni hoiatuste päring ( vt MedIN Otsustustoe integratsioon ) sama loogika alusel mis [Neerufunktsiooni languse hoiatuste pärimine](OperationDefinition-Medication-renal-failure-warnings.html) päringu sees.
    - mh kehtivad erandid:
        - alla 18a patsiendil kontrolli ei tehta
        - kui patsiendil ei leita eGFR tulemust
        - kui patsiendi eGFR on suurem või võrdne 90
- Kontrolliks võrreldakse sisendisse tulnud hoiatuste kinnitust (consentWithRenalFailureWarnings) ja kas hoiatusi leiti või mitte
- Ainus lubatud olukord, on see, kus hoiatuste kinnitus ja hoiatuste olemasolu on võrdsed, kui ei ole - viga ja töö katkeb (veakood)

## Retseptikeskuse validatsioon
<div>
<img src="rkvalidatsioon.svg"  alt="Retseptikeskuse validatsioon" width="60%">
<p>Ravimiskeemi kinnitamisel Retseptikeskuse validatsioon</p>
<p></p>
</div>


### Ärireeglid
- Valideerimine on kahes etapis:
- Etapp 1
    - Tehakse päringud, millega saadetakse kõikide loodavate retseptide andmed Retseptikeskuse soodustuste teenusesse (vt Loodava retsepti valideerimine  - päring )
    - Loodavad retseptid on sisendis eeltöötlusega tuvastatud:
        - Uued loodavad read (prescribed)
        - Muudetavad read (changed), kus on vaja retsepte luua
    - Juhul kui mõne rea puhul tuleb tagasi RK vea tüüpe E või A korral - viga ja töö katkeb (veakood)
        - NB! retseptikeskuse vead peegeldatakse vastuse OperationOutcome-i!
- Etapp 2 - Implementeerimata!
    - Tehakse päring, millega saadetakse kõikide loodavate retseptide andmed Retseptikeskuse uude valideerimisteenusesse (vt Kõikide loodavate retseptide kumulatiivne valideerimine  - päring )
    - Loodavad retseptid on sisendis eeltöötlusega tuvastatud:
        - Uued loodavad read (prescribed)
        - Muudetavad read (changed), kus on vaja retsepte luua
    - Juhul kui vastusest tuleb tagasi (täpsustada, kui teenuse spec on olemas) korral - viga ja katkestame (veakood)
        - NB! kusjuures retseptikeskuse vead peegeldatakse vastuse OperationOutcome-i!

## Retseptikeskuses retseptide tühistamine
<div>
<img src="rkrtyhistamine.svg"  alt="Retseptikeskuse retseptide tühistamine" width="60%">
<p>Ravimiskeemi kinnitamisel Retseptikeskuse retseptide tühistamine</p>
<p></p>
</div>

### Ärireeglid
- Tühistatavad retseptid on sisendi töötlusega tuvastatud:
    - Muudetavad read (changed), kus on vaja retsepte ka tühistada
    - Kustutamisele määratud read (ceased)
- Ravimiskeemi rea küljes olevate retseptide puhul teostame esmalt RK päringu, et saada seotud retseptide staatused (vt Tühistamisele minevate retseptide staatused  - päring )
- Staatuste alusel filtreeritakse välja need, mida ei ole võimalik annuleerida (staatus <> Koostatud), välja filtreeritavaid IGNOREERITAKSE
    - Selgitus: Ravimiskeemi kinnitamist ja retseptide tühistamist ei katkestata, kui retseptid on mööda äriprotsessi edasi liikunud (nt välja ostetud, aegunud, broneeritud)
- Alles jäänud retseptid annuleeritakse teenusega ( annulleerimine  - päring ), kordsete retseptide puhul tehakse päring ainult ühele kordsete hulgast, Retseptikeskuse vastusest   saab välja lugeda kõik automaatselt tühistatud retseptid
    - NB! Muudetavate ridade puhul, kus on vaja retsepte tühistada, määratakse annulleerimise põhjuseks "AN02 - Raviskeemi muudatus: puudub oodatud ravitulemus"
- Juhul kui mõne retsepti tühistamisel tekib vigu - viga ja katkestame (veakood)
    - NB! retseptikeskuse vead peegeldatakse vastuse OperationOutcome-i!
- Juhul kui peale filtreerimist ei jää alles ühtegi tühistatavat retsepti, liigutakse edasi järgmise tegevuse juurde, st viga ei teki

## Retseptikeskuses retseptide annustamise muutmine - tulevikus loodav
Kirjeldus: Retseptikeskuse poolel on loodud eraldi teenus retsepti annustamise muutmiseks, mida peaks MedIN kasutama juhul kui ravimiskeemi real muudetakse ainult annustamise sektsiooni. 
**NB!** Tegemist on implementeerimata funktsionaalsusega

## Retseptikeskuses retseptide loomine
<div>
<img src="rkrloomine.svg"  alt="Retseptikeskuse retseptide loomine" width="60%">
<p>Ravimiskeemi kinnitamisel Retseptikeskuses retseptide loomine</p>
<p></p>
</div>

### Ärireeglid
- Loodavad retseptid on sisendis eeltöötlusega tuvastatud:
    - Uued loodavad read (prescribed)
    - Muudetavad read (changed), kus on vaja retsepte luua
- Tulevikus on siia vahele planeeritud funktsionaalsus, mis järjestaks loodavad retseptid selliselt, et bensodiasepiinid oleksid järjekorras viimasena
- Loodavate retseptide alusel püütakse üks-haaval luua retseptid vastavalt kirjeldatud andmetele (vt retsepti_kinnitamine_arst päring ) ning salvestatakse loodud retseptide numbrid MedicationRequest viidetena MedicationStatement.derivedFrom väljale
- Juhul kui mõni retsepti loomine saab RK vea tüüpidega E ja A - viga ja töö katkeb (veakood)
    - NB! retseptikeskuse vead peegeldatakse vastuse OperationOutcome-i!

## FHIR andmete salvestamine
<div>
<img src="fhirandmetetootlemine.svg"  alt="FHIR andmete töötlemine ja salvestamine" width="60%">
<p>Ravimiskeemi kinnitamine - FHIR andmete töötlemine ja salvestamine</p>
<p></p>
</div>

### Ärireeglid:
- FHIR andmed salvestatakse kõige viimasena tegevuste järjekorras ning seda tehakse ühe transaktsioonina (üks muudatus, mitte mitu erinevat). Kui kogu tegevuse jooksul tekib vähemalt üks viga, katkestatakse töö ja **andmete muudatusi ei salvestata**
- Kinnitamise fakti salvestamiseks tekitatakse nn "Kinnitamise objekt" ehk [EETISMedicationList], mis:
    - Sisaldab kinnitamise aega
    - Sisaldab kinnitaja (PractitionerRole) andmestikku FHIR contained atribuudis, mis on võetud vastavast sisendparameetrist (confirmer)
    - Sisaldab versioonispetsiifilisi viiteid (List.Entry) ravimiskeemi ridadele ehk MedicationStatment'tele, mis sisendi töötlemisel eri List.Entry.flag väärtustega eristati
sisaldab iga (List.Entry) viite kohta viimast ravimiskeemi rea muudatuse kuupäeva atribuudis List.Entry.date: 
        - st kui rida selle kinnitamisega ei muutunud, siis Entry.date jääb sama, mis eelmine kord (sama mis selle rea viimane EETISVerification)
        - kui reaga toimub mingi muudatus, siis List.Entry.date = kinnitamise kuupäev
    - Juhul kui kinnitamisel lisati kommentaar, siis sisaldab kommentaar teksti ning kommenteerija nime, rolli ja kommenteerimise aega. Kommenteerija andmed on samad, mis ravimiskeemi kinnitajal ja kommentaari aeg on sama, mis kinnitamise aeg
- Igale List.Entry.flag väärtusega prescribed, ceased, changed olnud MedicationStatment'le lisatakse Kinnitamise andmestik ehk [EETISVerification] mis sisaldab:
    - kinnitamise aeg
    - kinnitaja viited ehk PractitionerRole nn FHIR logical reference'd (MEDRE kood identifier'na) 
    - kinnitaja viidete juures ka display väärtus mis sisaldab kinnitaja nime ja eriala
- Lisategevusena võetakse sellised read, mille küljes oleva [ExtensionEETISGroupedItems] sees on "groupingReference" extensionid ning:
    - võetakse extensioni seest MedicationStatement ID-d ning lisatakse need List-i alla List.Entry.item.flag=**consolidated** väärtusega entry-d.
    - Seejärel eemaldatakse "base" statement-i küljest "groupingReference" extensionid ära
        - siia tuleb perspektiivis ka nende ridade effective.end märkimine! TJT-2799 - MedIN: grupeeritud ridade konsolideerimisel väärtustada konsolideeritud ridadel effective.end Closed
- Igale flag väärtusega prescribed, changed olnud MedicationStatment'le lisatakse contained atribuuti täis andmestik selle rea loonud või muutnud tervishoiutöötaja/spetsialistile PractitionerRole ressursi näol ning lisatakse sellele viide MedicationStatement.informationSource atribuuti
- Iga serverisse lisatav või muudetav MedicationStatement esmalt täiendatakse kinnitamise infoga (ja sellest tekib uus versioon) ja seejärel lisatakse selle versiooni viide List-i
- Medication ressursi muutumisel luuakse ALATI uus Medication ressurss, sest eeldus on, et ravim kui selline muutuda ei saa, pigem asendub
    - see tähendab, et MedicationStatement'st tekib uus versioon, mis viitab ainult uuele Medication Ressursile
- Kõige lõpuks ressurssid **salvestatakse baasi**

## Näited
Näide, kus patsiendile lisatakse üks uus ravimiskeemi rida ja lõpetatakse teine, taustal on serveris alles jäänud üks ravimiskeemi rida, mida ei muudeta.
**Ravimiskeemi kinnitamise sisend**:
```
{
  "resourceType": "Parameters",
  "parameter": [
    {
      "name": "lastKnownConfirmation",
      "valueReference": {
        "reference": "List/456"
      }
    },
    {
      "name": "input",
      "resource": {
        "resourceType": "Bundle",
        "type": "collection",
        "entry": [
          { /* näide muutmisele minevast ravimiskeemi reast, kus on lõpu kuupäev külge pandu */
            "fullUrl": "MedicationStatement/119",
            "resource": {
              "resourceType": "MedicationStatement",
              "id": "119",
              "meta": {
                "profile": [
                  "https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
                ]
              },
              "contained": [
                {
                  "resourceType": "PractitionerRole",
                  "id": "med-statement-kinnitaja",
                  "meta": {
                    "profile": [
                      "https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
                    ]
                  },
                  "active": true,
                  "practitioner": {
                    "identifier": [
                      {
                        "system": "https://fhir.ee/sid/pro/est/pho",
                        "value": "D98765" /*siia MEDRE kood*/
                      }
                    ],
                    "display": "Mari Maasikas"
                  },
                  "organization": {
                    "identifier": [
                      {
                        "system": "https://fhir.ee/sid/org/est/br",
                        "value": "11073901" /*siia asutuse reg.kood*/
                      }
                    ],
                    "display": "Doktor Sirje Lille Hambaravi OÜ"
                  },
                  "specialty": [ /*siia MEDRE'st tulnud erialad, igaüks eraldi*/
                    {
                      "coding": [
                        {
                          "system": "https://fhir.ee/CodeSystem/ee-medre-specialty",
                          "code": "E170",
                          "display": "Kardioloogia"
                        }
                      ]
                    }
                  ],
                  "contact": [
                    {
                      "telecom": [
                        {
                          "system": "email",
                          "value": "mari.maasikas@example.org"
                        },
                        {
                          "system": "phone",
                          "value": "555 123456",
                          "use": "work"
                        }
                      ]
                    }
                  ]
                }
              ],
              "extension": [
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time",
                  "valueDateTime": "2024-06-07T03:00:00+03:00"
                },
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-medication-left",
                  "valueInteger": 10
                },
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
                  "valueInteger": 10
                },
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-authorization",
                  "valueCodeableConcept": {
                    "coding": [
                      {
                        "system": "https://fhir.ee/CodeSystem/retsepti-volituse-liik",
                        "code": "public"
                      }
                    ]
                  }
                },
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-intent",
                  "valueCode": "order"
                },
                {
                  "extension": [
                    {
                      "url": "substitutionAllowed",
                      "valueBoolean": true
                    }
                  ],
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-substitution-allowed"
                },
                {
                  "extension": [
                    {
                      "url": "verificationTime",
                      "valueDateTime": "2024-05-08T09:13:11+03:00"
                    },
                    {
                      "url": "verificationAuthor",
                      "valueReference": {
                        "identifier": [
                          {
                            "system": "https://fhir.ee/sid/pro/est/pho",
                            "value": "D98765" /*siia MEDRE kood*/
                          },
                          {
                            "system": "https://fhir.ee/sid/org/est/br",
                            "value": "11073901" /*siia asutuse reg.kood*/
                          }
                        ],
                        "display": "Mari Maasikas, Kardioloogia, Õendus"
                      }
                    }
                  ],
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
                },
                {
                  "extension": [
                    {
                      "url": "verificationTime",
                      "valueDateTime": "2024-05-08T10:18:07+03:00"
                    },
                    {
                      "url": "verificationAuthor",
                      "valueReference": {
                        "reference": "PractitionerRole/N16054",
                        "display": "ARTUR TEHIK"
                      }
                    }
                  ],
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
                },
                {
                  "extension": [
                    {
                      "url": "verificationTime",
                      "valueDateTime": "2024-05-08T10:23:34+03:00"
                    },
                    {
                      "url": "verificationAuthor",
                      "valueReference": {
                        "reference": "PractitionerRole/N16054",
                        "display": "ARTUR TEHIK"
                      }
                    }
                  ],
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
                },
                {
                  "extension": [
                    {
                      "url": "verificationTime",
                      "valueDateTime": "2024-05-08T15:20:41+03:00"
                    },
                    {
                      "url": "verificationAuthor",
                      "valueReference": {
                        "reference": "PractitionerRole/N16054",
                        "display": "ARTUR TEHIK"
                      }
                    }
                  ],
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
                },
                {
                  "extension": [
                    {
                      "url": "verificationTime",
                      "valueDateTime": "2024-05-08T15:22:04+03:00"
                    },
                    {
                      "url": "verificationAuthor",
                      "valueReference": {
                        "reference": "PractitionerRole/N16054",
                        "display": "ARTUR TEHIK"
                      }
                    }
                  ],
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
                },
                {
                  "extension": [
                    {
                      "url": "verificationTime",
                      "valueDateTime": "2024-05-08T15:25:32+03:00"
                    },
                    {
                      "url": "verificationAuthor",
                      "valueReference": {
                        "reference": "PractitionerRole/N16054",
                        "display": "ARTUR TEHIK"
                      }
                    }
                  ],
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
                }
              ],
              "status": "draft",
              "category": [
                {
                  "coding": [
                    {
                      "system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
                      "code": "f"
                    }
                  ]
                },
                {
                  "coding": [
                    {
                      "system": "https://fhir.ee/CodeSystem/statement-origin-category",
                      "code": "pc"
                    }
                  ]
                },
                {
                  "coding": [
                    {
                      "system": "https://fhir.ee/CodeSystem/retsepti-liik",
                      "code": "2"
                    }
                  ]
                },
                {
                  "coding": [
                    {
                      "system": "https://fhir.ee/CodeSystem/retsepti-kordsus",
                      "code": "1"
                    }
                  ]
                }
              ],
              "medication": {
                "reference": {
                  "reference": "Medication/118"
                }
              },
              "subject": {
                "reference": "Patient/94465"
              },
              "effectivePeriod": {
                "start": "2024-03-08T03:00:00+03:00",
                "end": "2024-05-13T03:00:00+03:00"
              },
              "dateAsserted": "2024-03-08T09:05:59+03:00",
              "informationSource": [
                {
                  "reference": "#med-statement-kinnitaja"
                }
              ],
              "reason": [
                {
                  "concept": {
                    "coding": [
                      {
                        "system": "https://fhir.ee/CodeSystem/rhk10",
                        "code": "X52"
                      }
                    ]
                  }
                }
              ],
              "dosage": [
                {
                  "patientInstruction": "Ikka valutab",
                  "timing": {
                    "repeat": {
                      "boundsDuration": {
                        "value": 10,
                        "unit": "d",
                        "system": "http://unitsofmeasure.org",
                        "code": "d"
                      },
                      "frequency": 1,
                      "period": 1,
                      "periodUnit": "d",
                      "timeOfDay": [
                        "09:00:00"
                      ]
                    }
                  },
                  "route": {
                    "coding": [
                      {
                        "system": "https://fhir.ee/CodeSystem/manustamistee",
                        "code": "subkutaanne"
                      }
                    ]
                  },
                  "doseAndRate": [
                    {
                      "doseQuantity": {
                        "value": 1,
                        "unit": "ampull",
                        "system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
                        "code": "AM"
                      }
                    }
                  ]
                }
              ]
            }
          },
          { /* näide lisatavast ravimiskeemi reast, millele järgneb ka Medication ressurss */
            "fullUrl": "urn:uuid:e8740459-8bfb-4692-a643-dbe486838414",
            "resource": {
              "resourceType": "MedicationStatement",
              "meta": {
                "versionId": "10",
                "lastUpdated": "2024-05-08T16:24:49+03:00",
                "profile": [
                  "https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
                ]
              },
              "contained": [
                {
                  "resourceType": "PractitionerRole",
                  "id": "med-statement-kinnitaja",
                  "meta": {
                    "profile": [
                      "https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
                    ]
                  },
                  "active": true,
                  "practitioner": {
                    "identifier": [
                      {
                        "system": "https://fhir.ee/sid/pro/est/pho",
                        "value": "D98765" /*siia MEDRE kood*/
                      }
                    ],
                    "display": "Mari Maasikas"
                  },
                  "organization": {
                    "identifier": [
                      {
                        "system": "https://fhir.ee/sid/org/est/br",
                        "value": "11073901" /*siia asutuse reg.kood*/
                      }
                    ],
                    "display": "Doktor Sirje Lille Hambaravi OÜ"
                  },
                  "specialty": [ /*siia MEDRE'st tulnud erialad, igaüks eraldi*/
                    {
                      "coding": [
                        {
                          "system": "https://fhir.ee/CodeSystem/ee-medre-specialty",
                          "code": "E170",
                          "display": "Kardioloogia"
                        }
                      ]
                    }
                  ],
                  "contact": [
                    {
                      "telecom": [
                        {
                          "system": "email",
                          "value": "mari.maasikas@example.org"
                        },
                        {
                          "system": "phone",
                          "value": "555 123456",
                          "use": "work"
                        }
                      ]
                    }
                  ]
                }
              ],
              "extension": [
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-medication-statement-status",
                  "valueCodeableConcept": {
                    "coding": [
                      {
                        "system": "https://fhir.ee/CodeSystem/ravimiskeemi-rea-staatused",
                        "code": "KINNITAMATA"
                      }
                    ]
                  }
                },
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time",
                  "valueDateTime": "2024-06-07T03:00:00+03:00"
                },
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-medication-left",
                  "valueInteger": 1
                },
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
                  "valueInteger": 1
                },
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-authorization",
                  "valueCodeableConcept": {
                    "coding": [
                      {
                        "system": "https://fhir.ee/CodeSystem/retsepti-volituse-liik",
                        "code": "public"
                      }
                    ]
                  }
                },
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-intent",
                  "valueCode": "order"
                },
                {
                  "extension": [
                    {
                      "url": "substitutionAllowed",
                      "valueBoolean": true
                    }
                  ],
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-substitution-allowed"
                },
                {
                  "extension": [
                    {
                      "url": "verificationTime",
                      "valueDateTime": "2024-05-08T10:18:07+03:00"
                    },
                    {
                      "url": "verificationAuthor",
                      "valueReference": {
                        "reference": "PractitionerRole/N16054",
                        "display": "ARTUR TEHIK"
                      }
                    }
                  ],
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
                },
                {
                  "extension": [
                    {
                      "url": "verificationTime",
                      "valueDateTime": "2024-05-08T10:23:34+03:00"
                    },
                    {
                      "url": "verificationAuthor",
                      "valueReference": {
                        "reference": "PractitionerRole/N16054",
                        "display": "ARTUR TEHIK"
                      }
                    }
                  ],
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
                },
                {
                  "extension": [
                    {
                      "url": "verificationTime",
                      "valueDateTime": "2024-05-08T15:20:41+03:00"
                    },
                    {
                      "url": "verificationAuthor",
                      "valueReference": {
                        "reference": "PractitionerRole/N16054",
                        "display": "ARTUR TEHIK"
                      }
                    }
                  ],
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
                },
                {
                  "extension": [
                    {
                      "url": "verificationTime",
                      "valueDateTime": "2024-05-08T15:22:04+03:00"
                    },
                    {
                      "url": "verificationAuthor",
                      "valueReference": {
                        "reference": "PractitionerRole/N16054",
                        "display": "ARTUR TEHIK"
                      }
                    }
                  ],
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
                },
                {
                  "extension": [
                    {
                      "url": "verificationTime",
                      "valueDateTime": "2024-05-08T15:25:32+03:00"
                    },
                    {
                      "url": "verificationAuthor",
                      "valueReference": {
                        "reference": "PractitionerRole/N16054",
                        "display": "ARTUR TEHIK"
                      }
                    }
                  ],
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
                },
                {
                  "extension": [
                    {
                      "url": "verificationTime",
                      "valueDateTime": "2024-05-08T16:24:49+03:00"
                    },
                    {
                      "url": "verificationAuthor",
                      "valueReference": {
                        "reference": "PractitionerRole/D10076",
                        "display": "MADIS RIKKO"
                      }
                    }
                  ],
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
                }
              ],
              "status": "recorded",
              "category": [
                {
                  "coding": [
                    {
                      "system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
                      "code": "p"
                    }
                  ]
                },
                {
                  "coding": [
                    {
                      "system": "https://fhir.ee/CodeSystem/statement-origin-category",
                      "code": "pc"
                    }
                  ]
                },
                {
                  "coding": [
                    {
                      "system": "https://fhir.ee/CodeSystem/retsepti-liik",
                      "code": "2"
                    }
                  ]
                },
                {
                  "coding": [
                    {
                      "system": "https://fhir.ee/CodeSystem/retsepti-kordsus",
                      "code": "1"
                    }
                  ]
                }
              ],
              "medication": {
                "reference": {
                  "reference": "urn:uuid:a1dfb1df-9ef5-4b1f-b24b-3f0ede8d926e"
                }
              },
              "subject": {
                "reference": "Patient/94465"
              },
              "effectivePeriod": {
                "start": "2024-03-08T03:00:00+03:00"
              },
              "dateAsserted": "2024-03-08T09:09:43+03:00",
              "informationSource": [
                {
                  "reference": "#med-statement-kinnitaja"
                }
              ],
              "reason": [
                {
                  "concept": {
                    "coding": [
                      {
                        "system": "https://fhir.ee/CodeSystem/rhk10",
                        "code": "X50"
                      }
                    ]
                  }
                }
              ],
              "dosage": [
                {
                  "timing": {
                    "repeat": {
                      "frequency": 1,
                      "period": 1,
                      "periodUnit": "wk"
                    }
                  },
                  "route": {
                    "coding": [
                      {
                        "system": "https://fhir.ee/CodeSystem/manustamistee",
                        "code": "suukaudne"
                      }
                    ]
                  },
                  "doseAndRate": [
                    {
                      "doseQuantity": {
                        "value": 1,
                        "unit": "ampull",
                        "system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
                        "code": "AM"
                      }
                    }
                  ]
                }
              ]
            }
          },
          { /* näide lisatavast ravimiskeemi rea ravimi infost, mis on seotud raivmiskeemi reaga */
            "fullUrl": "urn:uuid:a1dfb1df-9ef5-4b1f-b24b-3f0ede8d926e",
            "resource": {
              "resourceType": "Medication",
              "meta": {
                "profile": [
                  "https://fhir.ee/StructureDefinition/ee-tis-medication-epc"
                ]
              },
              "extension": [
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification",
                  "valueCodeableConcept": {
                    "coding": [
                      {
                        "system": "https://fhir.ee/CodeSystem/atc",
                        "code": "N07BC02"
                      }
                    ]
                  }
                },
                {
                  "url": "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name",
                  "valueString": "METADON DAK 1 MG/ML"
                }
              ],
              "identifier": [
                {
                  "system": "http://ravimiregister.ee/pakendid",
                  "value": "1034109"
                }
              ],
              "doseForm": {
                "coding": [
                  {
                    "system": "https://fhir.ee/CodeSystem/ravimvormid",
                    "code": "767",
                    "display": "suukaudne lahus"
                  }
                ]
              },
              "totalVolume": {
                "value": 1,
                "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
                "code": "TK"
              },
              "ingredient": [
                {
                  "item": {
                    "concept": {
                      "coding": [
                        {
                          "system": "https://fhir.ee/CodeSystem/toimeained",
                          "code": "11969",
                          "display": "metadoon"
                        }
                      ]
                    }
                  },
                  "isActive": true,
                  "strengthRatio": {
                    "numerator": {
                      "value": 1,
                      "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
                      "code": "mg"
                    },
                    "denominator": {
                      "value": 1,
                      "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
                      "code": "ml"
                    }
                  }
                }
              ]
            }
          }
        ]
      }
    }
  ]
}
```
Näidisväljund
**Ravimiskeemi kinnitamise väljund**:
```
{
  "resourceType": "Bundle",
  "type": "collection",
  "entry": [
    {
      /* Ravimiskeemi Kinnitamise fakti info */
      "fullUrl": "List/12345",
      "resource": {
        "resourceType": "List",
        "id": "12345",
        "meta": {
          "versionId": "1",
          "lastUpdated": "2024-05-13T14:42:59+03:00",
          "profile": [
            "https://fhir.ee/StructureDefinition/ee-tis-medication-list"
          ]
        },
        "contained": [
          {
            "resourceType": "PractitionerRole",
            "id": "med-list-kinnitaja",
            "meta": {
              "profile": [
                "https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
              ]
            },
            "active": true,
            "practitioner": {
              "identifier": [
                {
                  "system": "https://fhir.ee/sid/pro/est/pho",
                  "value": "D98765" /*siia MEDRE kood*/
                }
              ],
              "display": "Mari Maasikas"
            },
            "organization": {
              "identifier": [
                {
                  "system": "https://fhir.ee/sid/org/est/br",
                  "value": "11073901" /*siia asutuse reg.kood*/
                }
              ],
              "display": "Doktor Sirje Lille Hambaravi OÜ"
            },
            "specialty": [ /*siia MEDRE'st tulnud erialad, igaüks eraldi*/
              {
                "coding": [
                  {
                    "system": "https://fhir.ee/CodeSystem/ee-medre-specialty",
                    "code": "E170",
                    "display": "Kardioloogia"
                  }
                ]
              }
            ],
            "contact": [
              {
                "telecom": [
                  {
                    "system": "email",
                    "value": "mari.maasikas@example.org"
                  },
                  {
                    "system": "phone",
                    "value": "555 123456",
                    "use": "work"
                  }
                ]
              }
            ]
          }
        ],
        "status": "current",
        "mode": "snapshot",
        "title": "Ravimiskeem",
        "subject": [
          {
            "reference": "Patient/94465"
          }
        ],
        "date": "2024-05-13T00:00:00+03:00",
        "source": {
          "reference": "#med-list-kinnitaja"
        },
        "entry": [
          {
            "flag": {
              "coding": [
                {
                  "system": "urn:oid:1.2.36.1.2001.1001.101.104.16592",
                  "code": "01",
                  "display": "Unchanged"
                }
              ]
            },
            "item": {
              "reference": "MedicationStatement/123"
            },
            "date": "2023-11-30"
          },
          {
            "flag": {
              "coding": [
                {
                  "system": "urn:oid:1.2.36.1.2001.1001.101.104.16592",
                  "code": "04",
                  "display": "Prescribed"
                }
              ]
            },
            "item": {
              "reference": "MedicationStatement/1456/_history/1"
            },
            "date": "2024-05-13"
          },
          {
            "flag": {
              "coding": [
                {
                  "system": "urn:oid:1.2.36.1.2001.1001.101.104.16592",
                  "code": "05",
                  "display": "Ceased"
                }
              ]
            },
            "item": {
              "reference": "MedicationStatement/119/_history/5"
            },
            "deleted": false,
            "date": "2024-05-13"
          }
        ]
      }
    },
    {
      "fullUrl": "MedicationStatement/119",
      "resource": {
        "resourceType": "MedicationStatement",
        "id": "119",
        "meta": {
          "versionId": "5",
          "lastUpdated": "2024-05-13T14:42:59+03:00",
          "profile": [
            "https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
          ]
        },
        "contained": [
          {
            "resourceType": "PractitionerRole",
            "id": "med-statement-kinnitaja",
            "meta": {
              "profile": [
                "https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
              ]
            },
            "active": true,
            "practitioner": {
              "identifier": [
                {
                  "system": "https://fhir.ee/sid/pro/est/pho",
                  "value": "D98765" /*siia MEDRE kood*/
                }
              ],
              "display": "Mari Maasikas"
            },
            "organization": {
              "identifier": [
                {
                  "system": "https://fhir.ee/sid/org/est/br",
                  "value": "11073901" /*siia asutuse reg.kood*/
                }
              ],
              "display": "Doktor Sirje Lille Hambaravi OÜ"
            },
            "specialty": [ /*siia MEDRE'st tulnud erialad, igaüks eraldi*/
              {
                "coding": [
                  {
                    "system": "https://fhir.ee/CodeSystem/ee-medre-specialty",
                    "code": "E170",
                    "display": "Kardioloogia"
                  }
                ]
              }
            ],
            "contact": [
              {
                "telecom": [
                  {
                    "system": "email",
                    "value": "mari.maasikas@example.org"
                  },
                  {
                    "system": "phone",
                    "value": "555 123456",
                    "use": "work"
                  }
                ]
              }
            ]
          }
        ],
        "extension": [
          {
            "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time",
            "valueDateTime": "2024-06-07T03:00:00+03:00"
          },
          {
            "url": "https://fhir.ee/StructureDefinition/ee-tis-medication-left",
            "valueInteger": 10
          },
          {
            "url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
            "valueInteger": 10
          },
          {
            "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-authorization",
            "valueCodeableConcept": {
              "coding": [
                {
                  "system": "https://fhir.ee/CodeSystem/retsepti-volituse-liik",
                  "code": "public"
                }
              ]
            }
          },
          {
            "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-intent",
            "valueCode": "order"
          },
          {
            "extension": [
              {
                "url": "substitutionAllowed",
                "valueBoolean": true
              }
            ],
            "url": "https://fhir.ee/StructureDefinition/ee-tis-substitution-allowed"
          },
          { /*NB! Näites on kõik kinnitamised teinud sama isik - reaalsuses on päris kinnitajad erinevad */
            "extension": [
              {
                "url": "verificationTime",
                "valueDateTime": "2024-05-08T09:13:11+03:00"
              },
              {
                "url": "verificationAuthor",
                "valueReference": {
                  "identifier": [
                    {
                      "system": "https://fhir.ee/sid/pro/est/pho",
                      "value": "D98765"
                    },
                    {
                      "system": "https://fhir.ee/sid/org/est/br",
                      "value": "11073901"
                    }
                  ],
                  "display": "Mari Maasikas, Kardioloogia, Õendus"
                }
              }
            ],
            "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
          },
          {
            "extension": [
              {
                "url": "verificationTime",
                "valueDateTime": "2024-05-08T10:18:07+03:00"
              },
              {
                "url": "verificationAuthor",
                "valueReference": {
                  "identifier": [
                    {
                      "system": "https://fhir.ee/sid/pro/est/pho",
                      "value": "D98765"
                    },
                    {
                      "system": "https://fhir.ee/sid/org/est/br",
                      "value": "11073901"
                    }
                  ],
                  "display": "Mari Maasikas, Kardioloogia, Õendus"
                }
              }
            ],
            "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
          },
          {
            "extension": [
              {
                "url": "verificationTime",
                "valueDateTime": "2024-05-08T10:23:34+03:00"
              },
              {
                "url": "verificationAuthor",
                "valueReference": {
                  "identifier": [
                    {
                      "system": "https://fhir.ee/sid/pro/est/pho",
                      "value": "D98765"
                    },
                    {
                      "system": "https://fhir.ee/sid/org/est/br",
                      "value": "11073901"
                    }
                  ],
                  "display": "Mari Maasikas, Kardioloogia, Õendus"
                }
              }
            ],
            "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
          },
          {
            "extension": [
              {
                "url": "verificationTime",
                "valueDateTime": "2024-05-08T15:20:41+03:00"
              },
              {
                "url": "verificationAuthor",
                "valueReference": {
                  "identifier": [
                    {
                      "system": "https://fhir.ee/sid/pro/est/pho",
                      "value": "D98765"
                    },
                    {
                      "system": "https://fhir.ee/sid/org/est/br",
                      "value": "11073901"
                    }
                  ],
                  "display": "Mari Maasikas, Kardioloogia, Õendus"
                }
              }
            ],
            "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
          },
          {
            "extension": [
              {
                "url": "verificationTime",
                "valueDateTime": "2024-05-13T14:42:59+03:00"
              },
              {
                "url": "verificationAuthor",
                "valueReference": {
                  "identifier": [
                    {
                      "system": "https://fhir.ee/sid/pro/est/pho",
                      "value": "D98765" /*siia MEDRE kood*/
                    },
                    {
                      "system": "https://fhir.ee/sid/org/est/br",
                      "value": "11073901" /*siia asutuse reg.kood*/
                    }
                  ],
                  "display": "Mari Maasikas, Kardioloogia, Õendus"
                }
              }
            ],
            "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
          }
        ],
        "status": "draft",
        "category": [
          {
            "coding": [
              {
                "system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
                "code": "f"
              }
            ]
          },
          {
            "coding": [
              {
                "system": "https://fhir.ee/CodeSystem/statement-origin-category",
                "code": "pc"
              }
            ]
          },
          {
            "coding": [
              {
                "system": "https://fhir.ee/CodeSystem/retsepti-liik",
                "code": "2"
              }
            ]
          },
          {
            "coding": [
              {
                "system": "https://fhir.ee/CodeSystem/retsepti-kordsus",
                "code": "1"
              }
            ]
          }
        ],
        "medication": {
          "reference": {
            "reference": "Medication/118"
          }
        },
        "subject": {
          "reference": "Patient/94465"
        },
        "effectivePeriod": {
          "start": "2024-03-08T03:00:00+03:00",
          "end": "2024-05-13T03:00:00+03:00"
        },
        "dateAsserted": "2024-03-08T09:05:59+03:00",
        "informationSource": [
          {
            "reference": "#med-statement-kinnitaja"
          }
        ],
        "reason": [
          {
            "concept": {
              "coding": [
                {
                  "system": "https://fhir.ee/CodeSystem/rhk10",
                  "code": "X52"
                }
              ]
            }
          }
        ],
        "dosage": [
          {
            "patientInstruction": "Ikka valutab",
            "timing": {
              "repeat": {
                "boundsDuration": {
                  "value": 10,
                  "unit": "d",
                  "system": "http://unitsofmeasure.org",
                  "code": "d"
                },
                "frequency": 1,
                "period": 1,
                "periodUnit": "d",
                "timeOfDay": [
                  "09:00:00"
                ]
              }
            },
            "route": {
              "coding": [
                {
                  "system": "https://fhir.ee/CodeSystem/manustamistee",
                  "code": "subkutaanne"
                }
              ]
            },
            "doseAndRate": [
              {
                "doseQuantity": {
                  "value": 1,
                  "unit": "ampull",
                  "system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
                  "code": "AM"
                }
              }
            ]
          }
        ]
      }
    },
    { /* näide lisatavast ravimiskeemi reast, millele järgneb ka Medication ressurss */
      "fullUrl": "MedicationStatement/1456",
      "resource": {
        "resourceType": "MedicationStatement",
        "id": "1456",
        "meta": {
          "versionId": "1",
          "lastUpdated": "2024-05-13T14:42:59+03:00",
          "profile": [
            "https://fhir.ee/StructureDefinition/ee-tis-medication-statement"
          ]
        },
        "contained": [
          {
            "resourceType": "PractitionerRole",
            "id": "med-statement-kinnitaja",
            "meta": {
              "profile": [
                "https://fhir.ee/StructureDefinition/ee-tis-practitioner-role"
              ]
            },
            "active": true,
            "practitioner": {
              "identifier": [
                {
                  "system": "https://fhir.ee/sid/pro/est/pho",
                  "value": "D98765" /*siia MEDRE kood*/
                }
              ],
              "display": "Mari Maasikas"
            },
            "organization": {
              "identifier": [
                {
                  "system": "https://fhir.ee/sid/org/est/br",
                  "value": "11073901" /*siia asutuse reg.kood*/
                }
              ],
              "display": "Doktor Sirje Lille Hambaravi OÜ"
            },
            "specialty": [ /*siia MEDRE'st tulnud erialad, igaüks eraldi*/
              {
                "coding": [
                  {
                    "system": "https://fhir.ee/CodeSystem/ee-medre-specialty",
                    "code": "E170",
                    "display": "Kardioloogia"
                  }
                ]
              }
            ],
            "contact": [
              {
                "telecom": [
                  {
                    "system": "email",
                    "value": "mari.maasikas@example.org"
                  },
                  {
                    "system": "phone",
                    "value": "555 123456",
                    "use": "work"
                  }
                ]
              }
            ]
          }
        ],
        "extension": [
          {
            "url": "https://fhir.ee/StructureDefinition/ee-tis-medication-statement-status",
            "valueCodeableConcept": {
              "coding": [
                {
                  "system": "https://fhir.ee/CodeSystem/ravimiskeemi-rea-staatused",
                  "code": "KINNITAMATA"
                }
              ]
            }
          },
          {
            "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-validity-time",
            "valueDateTime": "2024-06-07T03:00:00+03:00"
          },
          {
            "url": "https://fhir.ee/StructureDefinition/ee-tis-medication-left",
            "valueInteger": 1
          },
          {
            "url": "https://fhir.ee/StructureDefinition/ee-tis-total-prescribed-amount",
            "valueInteger": 1
          },
          {
            "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-authorization",
            "valueCodeableConcept": {
              "coding": [
                {
                  "system": "https://fhir.ee/CodeSystem/retsepti-volituse-liik",
                  "code": "public"
                }
              ]
            }
          },
          {
            "url": "https://fhir.ee/StructureDefinition/ee-tis-prescription-intent",
            "valueCode": "order"
          },
          {
            "extension": [
              {
                "url": "substitutionAllowed",
                "valueBoolean": true
              }
            ],
            "url": "https://fhir.ee/StructureDefinition/ee-tis-substitution-allowed"
          },
          {
            "extension": [
              {
                "url": "verificationTime",
                "valueDateTime": "2024-05-13T14:42:59+03:00"
              },
              {
                "url": "verificationAuthor",
                "valueReference": {
                  "identifier": [
                    {
                      "system": "https://fhir.ee/sid/pro/est/pho",
                      "value": "D98765"
                    },
                    {
                      "system": "https://fhir.ee/sid/org/est/br",
                      "value": "11073901"
                    }
                  ],
                  "display": "Mari Maasikas, Kardioloogia, Õendus"
                }
              }
            ],
            "url": "https://fhir.ee/StructureDefinition/ee-tis-verification"
          }
        ],
        "status": "recorded",
        "category": [
          {
            "coding": [
              {
                "system": "https://fhir.ee/CodeSystem/ravikuuri-tyyp",
                "code": "p"
              }
            ]
          },
          {
            "coding": [
              {
                "system": "https://fhir.ee/CodeSystem/statement-origin-category",
                "code": "pc"
              }
            ]
          },
          {
            "coding": [
              {
                "system": "https://fhir.ee/CodeSystem/retsepti-liik",
                "code": "2"
              }
            ]
          },
          {
            "coding": [
              {
                "system": "https://fhir.ee/CodeSystem/retsepti-kordsus",
                "code": "1"
              }
            ]
          }
        ],
        "medication": {
          "reference": {
            "reference": "Medication/1234"
          }
        },
        "subject": {
          "reference": "Patient/94465"
        },
        "effectivePeriod": {
          "start": "2024-03-08T03:00:00+03:00"
        },
        "dateAsserted": "2024-03-08T09:09:43+03:00",
        "informationSource": [
          {
            "reference": "#med-statement-kinnitaja"
          }
        ],
        "reason": [
          {
            "concept": {
              "coding": [
                {
                  "system": "https://fhir.ee/CodeSystem/rhk10",
                  "code": "X50"
                }
              ]
            }
          }
        ],
        "dosage": [
          {
            "timing": {
              "repeat": {
                "frequency": 1,
                "period": 1,
                "periodUnit": "wk"
              }
            },
            "route": {
              "coding": [
                {
                  "system": "https://fhir.ee/CodeSystem/manustamistee",
                  "code": "suukaudne"
                }
              ]
            },
            "doseAndRate": [
              {
                "doseQuantity": {
                  "value": 1,
                  "unit": "ampull",
                  "system": "https://fhir.ee/CodeSystem/retsept-annustamise-yhik",
                  "code": "AM"
                }
              }
            ]
          }
        ]
      }
    },
    { /* näide lisatavast ravimiskeemi rea ravimi infost, mis on seotud raivmiskeemi reaga */
      "fullUrl": "Medication/1234",
      "resource": {
        "resourceType": "Medication",
        "id": "1234",
        "meta": {
          "versionId": "1",
          "lastUpdated": "2024-05-13T14:42:59+03:00",
          "profile": [
            "https://fhir.ee/StructureDefinition/ee-tis-medication-epc"
          ]
        },
        "extension": [
          {
            "url": "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-classification",
            "valueCodeableConcept": {
              "coding": [
                {
                  "system": "https://fhir.ee/CodeSystem/atc",
                  "code": "N07BC02"
                }
              ]
            }
          },
          {
            "url": "https://fhir.ee/StructureDefinition/ee-tis-medicinal-product-name",
            "valueString": "METADON DAK 1 MG/ML"
          }
        ],
        "identifier": [
          {
            "system": "http://ravimiregister.ee/pakendid",
            "value": "1034109"
          }
        ],
        "doseForm": {
          "coding": [
            {
              "system": "https://fhir.ee/CodeSystem/ravimvormid",
              "code": "767",
              "display": "suukaudne lahus"
            }
          ]
        },
        "totalVolume": {
          "value": 1,
          "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
          "code": "TK"
        },
        "ingredient": [
          {
            "item": {
              "concept": {
                "coding": [
                  {
                    "system": "https://fhir.ee/CodeSystem/toimeained",
                    "code": "11969",
                    "display": "metadoon"
                  }
                ]
              }
            },
            "isActive": true,
            "strengthRatio": {
              "numerator": {
                "value": 1,
                "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
                "code": "mg"
              },
              "denominator": {
                "value": 1,
                "system": "https://fhir.ee/CodeSystem/retsept-mahu-ja-massiyhik",
                "code": "ml"
              }
            }
          }
        ]
      }
    }
  ]
}
```

