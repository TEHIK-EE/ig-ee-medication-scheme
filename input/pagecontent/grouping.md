# Grupeerimise loogika ravimiskeemis

{% include fsh-link-references.md %}

## Sissejuhatus
Ravimiskeemis on kasutusel eraldi loogika, mis grupeerib ehk viib kokku andmeid, mis käsitlevad sisu poolest sama ravi või samu ravimeid.

**Probleem mida lahendatakse:**

- Retseptikeskus (edaspidi RK) ja Ravimiskeem jäävad mõnda aega paralleelselt kasutusse - Ravimiskeemi vaatest tekib ridu, mis on sama sisuga, kuid dubleerivad üksteist
- Ravimiskeemi esmasel avamisel mõne patsiendi alt on kuvatud ainult retseptide põhine andmestik - seal võib olla palju korduseid, eriti nt püsiravimite korral
- See peegeldub ka Terviseportaalis Patsiendi vaatesse, kus ravimid on mitmekordselt ja tekitavad segadust

**Lahenduse keskne idee** 

Sama toimeainete, ravimvormi ning tugevusega andmestik tuleks kokku grupeerida, seda üle Retseptikeskuse retseptide ning ravimiskeemi FHIR ressursside.

See väljendub eri päringutes järgmiselt:
- [Kinnitatud ravimiskeemi pärimine](OperationDefinition-MedicationStatement-confirmed-medication-scheme.html) - grupeeritakse kokku sama toimeainete, ravimvormi ja tugevusega andmed
- [Ravimiskeemi andmete kinnitamine](OperationDefinition-MedicationStatement-confirm.html) - kõik sisendisse tulnud muudatused kontrollitakse vastu kinnitatud ravimiskeemi pärimisel saadavat tulemust, mis on grupeeritud
- [Ravimiskeemi ajaloo pärimine](OperationDefinition-MedicationStatement-history.html) - sama toimeainete ning ravimvormiga andmed saavad uue tunnuse (FHIR identifier), mille järgi klientsüsteem saab aru, et tegemist on kokku grupeeritavate ridadega. Tugevust siin päringus ei arvestata
Ravimvormide osas kehtib eraldi loogika, mille alusel otsustatakse, mida kokku viiakse ja mida mitte, vt lehe lõpust Ravimvormide grupeerimise loogika

## Detailsed ärireeglid ning stsenaariumid 
Grupeerimise loogikast parema ülevaate saamiseks on välja toodud eri olukorrad ehk stsenaariumid ning nendega seotud ärireeglid koos illustreerivate andmemudeli joonistega.
- Stsenaariumite kirjelduse eeldusena on võetud, et kogu andmestik (FHIR andmed, FHIR andmetega seotud retseptikeskuse andmed, otse retseptikeskusesse loodud andmed) on juba kätte päritud, kirjeldus keskendub sellele, mida andmetega tehakse. 
- Stsenaariumid on kirjeldatud nn inkrementaalsena, justkui neid oleks tehtud järjestikku.
- Stsenaariumite ärireeglites ei ole dubleerimisi - eeldus on, et nt stsenaariumis B2 kehtivad ka kõik eelnevalt välja toodud reeglid (A1, B1, A2)

### Ärireeglid
All on loetelu Grupeerimise loogika ärireeglitest
- Kokku grupeeritud andmetest tekib alati ainult üks MedicationStatement
- MedicationStatement andmed tulevad kõige hilisemast andmestikust - kas siis retsept või FHIR andmed
- Seotud andmete viited on eraldi extension-s [ExtensionEETISGroupedItems]
- Pärimisel ja grupeerimisel andmeid ei salvestata
- *kas siia tuua sisse List.Entry.flag=generated? ja EETISVerification? st muud andmed, mida pärimisel grupeerimise loogika täidab?*
- Juhul kui grupeerimisel on andmeid nii FHIR kui ka Retseptikeskusest, võetakse aluseks kõige hilisem FHIR MedicationStatement ning kirjutatakse selle andmed üle kõige hilisema Retseptikeskuse retseptiga, säilitades ja täiendades seniseid seoseid ja viiteid, sh FHIR ID
- Kokku grupeeritud FHIR andmetest tekib alati ainult üks MedicationStatement, konsolideeritavad MedicationStatement seosed lähevad reference'na ExtensionEETISGroupedItems extension'sse
- Kokku grupeeritud FHIR andmetega seotud retseptide viited viiakse kokku ExtensionEETISGroupedItems (või on siin veel derivedFrom kuidagi sees?) 
- Kinnitamisel märgitakse kokku grupeeritud FHIR andmetes MedicationStatement.effective.end kinnitamise ajaga ning kinnitamise fakti juures List.entry.flag=consolidated? ehk peale kinnitamist ei ole grupeeritud MedicationStatement-d enam aktiivsed
- Viia kinnitamise alla
    - Ravimiskeemi kinnitamisel võrreldakse sisendisse antud seisu alati hetkel kinnitatud skeemiga, mis on läbinud grupeerimise loogika
    - FHIR andmete salvestamine toimub ainult kinnitamisel
        - mh salvestatakse maha EETISVerification
    - Kinnitamisel märgitakse MedicationStatement.status=draft→recorded
    - Kinnitatud skeemi pärimisel Retseptikeskuse andmete pealt genereeritud ja klientsüsteemi poolt muutmata jäetud seisu salvestatakse kinnitamise juurde List.entry.flag=unchanged?
    - Pikendamisel ei muudeta eelmiseid seotud retsepte
    - Pikendamisel tekkivad retseptide seosed lisatakse eelmiste seoste juurde (mitte ei asenda neid)
    - Muutmisel püütakse eelmiseid seotud retsepte annulleerida (nii ExtensionEETISGroupedItems kui ka derivedFrom seose kaudu)
    - Muutmisel juurde tekkivad retseptide seosed lisatakse eelmiste seoste juurde (mitte ei asenda neid), st annulleeritud retseptide seosed jäetakse alles
    - Tühistamisel püütakse eelmiseid seotud retsepte annulleerida (nii ExtensionEETISGroupedItems kui ka derivedFrom seose kaudu)
    - Kinnitamisel märgitakse kokku grupeeritud FHIR andmetes MedicationStatement.effective.end kinnitamise ajaga ning kinnitamise fakti juures List.entry.flag=consolidated? ehk peale kinnitamist ei ole grupeeritud MedicationStatement-d enam aktiivsed

### A1 - olemas on ainult RK retseptid - Kinnitatud ravimiskeemi pärimine
**Olukorra kirjeldus ja oodatud tulemus**

Esmakordne vaade Patsiendi andmetele on alati puhtalt Retseptikeskuse andmete pealt, kus FHIR andmeid ei ole veel tekkida jõudnud. Oodatud tulemuseks on kõige värskemate andmete nägemine kõige "pealmistena", kuid seis on genereeritud - FHIR andmeid pärimise käigus ei teki

**Seotud ärireeglid**
- Kokku grupeeritud andmetest tekib alati ainult üks MedicationStatement
- MedicationStatement andmed tulevad kõige hilisemast andmestikust - kas siis retsept või FHIR andmed
- Seotud andmed on eraldi extension-s [ExtensionEETISGroupedItems]
- Pärimisel ja grupeerimisel andmeid ei salvestata
- *kas siia tuua sisse List.Entry.flag=generated?*

**Andmete vaade**

| Stsenaarium                        | Andmete seis ajalises järjestuses                                                                          | Oodatud tulemus                                                                                                                                                                                                                                                                                              |
| ---------------------------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| A1 - olemas on ainult RK retseptid | RK retsept A - 1011111111 <br>RK retsept B - 1022222222 <br>RK retsept C - 1033333333<br>FHIR andmeid pole | Väljundis on üks genereeritud MedicationStatement:<br>\* ID-ks on Retsept C identifier<br>\* andmed on Retsept C pealt<br>\* seotud retseptide all (ExtensionEETISGroupedItems) on kõik retseptid

\* kas siia peaks kajastama ka muud andmed, nt EETISVerification?<br>\* MedicationStatement.status=draft? |

<div>
<img src="grupeeriminea1.svg"  alt="Grupeerimise andmemudel A1" width="60%">
<p>Väljundi andmemudel</p>
<p></p>
</div>

### A2 - olemas on ainult RK retseptid, nendes muudatusi ei tehta - Ravimiskeemi kinnitamine
**Olukorra kirjeldus ja oodatud tulemus**

Päritud on A1 stsenaariumi vaade ning andmeid on ainult lisatud, pärimisel saadud andmetes muudatusi ei ole tehtud. Oodatud tulemuseks on A1 stsenaariumis päritud seisu FHIR andmetesse salvestamine.

**Seotud ärireeglid**
- Ravimiskeemi kinnitamisel võrreldakse sisendisse antud seisu alati hetkel kinnitatud skeemiga, mis on läbinud grupeerimise loogika
- FHIR andmete salvestamine toimub ainult kinnitamisel
    - mh salvestatakse maha EETISVerification
- Kinnitamisel märgitakse MedicationStatement.status=draft→recorded

**Andmete vaade**

| Stsenaarium                                                   | Sisend                                                                                                                                                                                                                                                                                                                                | Andmete seis enne kinnitamist<br>ajalises järjestuses                                                      | Oodatud tulemus (andmete seis pärast kinnitamist)                                                                                                                                                                                                             |
| ------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| A2 - olemas on ainult RK retseptid, nendes muudatusi ei tehta | MedicationStatement, kus:<br><br>identifier.value": "1033333333" (kõige hilisema retsepti ID)<br>andmed tuleks RK retseptilt C<br>.derivedFrom: tühi<br>.extension[uus]:<br>identifier.value": "1011111111",<br>identifier.value": "1022222222",<br>identifier.value": "1033333333"<br>Viimane kinnitamine:  RK C - 1033333333 alusel | RK retsept A - 1011111111 <br>RK retsept B - 1022222222 <br>RK retsept C - 1033333333<br>FHIR andmeid pole | Tekivad FHIR andmed:<br>üks MedicationStatement, mis on salvestatud sisendisse tulnud andmetega<br>List/1<br>mille sees on MedicationStatment ja flag=unchanged<br>MedicationStatement on seotud kõikide seniste retspetidega läbi ExtensionEETISGroupedItems |

<div>
<img src="grupeeriminea2.svg"  alt="Grupeerimise andmemudel A2" width="60%">
<p>Lõpptulemuse andmemudel</p>
<p></p>
</div>

### B1 - olemas uus FHIR kinnitamine (A2) ja peale seda loodud RK retseptid - Kinnitatud ravimiskeemi pärimine
**Olukorra kirjeldus ja oodatud tulemus**

Patsiendi andmeid on juba kinnitatud, ehk et on olemas FHIR andmetesse salvestatud grupeeritud seis ning peale seda on otse Retseptikeskusesse andmeid lisatud, mis FHIR andmetes ei kajastu.

Oodatud tulemuseks on nn hübriid-vaade, kus aluseks on võetud FHIR andmestik, kuid seda on üle kirjutatud kõige värskemate andmetega Retseptikeskusest. Eesmärk on etteulatuvalt arvestada järgmise kinnitamisega ning anda ette vajalikud FHIR ID-d selle jaoks.

**Seotud ärireeglid**
- Juhul kui grupeerimisel on andmeid nii FHIR kui ka Retseptikeskusest, võetakse aluseks kõige hilisem FHIR MedicationStatement ning kirjutatakse selle andmed üle kõige hilisema Retseptikeskuse retseptiga, säilitades ja täiendades seniseid seoseid ja viiteid, sh FHIR ID
- kas siia tuua sisse List.Entry.flag=generated?

**Andmete vaade**

| Stsenaarium                                                             | Andmete seis ajalises järjestuses                                                                                                                                                                                          | Oodatud tulemus                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| ----------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| B1 - olemas uus FHIR kinnitamine (A2) ja peale seda loodud RK retseptid | RK retsept A - 1011111111 <br>RK retsept B - 1022222222 <br>RK retsept C - 1033333333<br>FHIR List/1<br>FHIR MedicationStatement/1 (seotud retseptidega A, B, C)<br>RK retsept D - 1044444444<br>RK retsept E - 1055555555 | Väljundis on üks MedicationStatement:<br>\* ID-ks on MedicationStatement/1 (et hiljem kinnitamisel läheks muudatused õigesse kohta)<br>\* Selle andmed on Retsept E pealt<br>\* seotud retseptide all (ExtensionEETISGroupedItems) on kõik retseptid: A, B, C, D, E<br>\* kinnitatud ravimiskeemil tehakse RK päring alates List/1 loomise hetkest edasi ehk alates viimasest FHIR kinnitamisest<br><br>\* kas siia peaks kajastama ka muud andmed, nt EETISVerification?<br>\* MedicationStatement.status=draft?<br> |

<div>
<img src="grupeerimineb1.svg"  alt="Grupeerimise andmemudel B1" width="60%">
<p>Väljundi andmemudel</p>
<p></p>
</div>

### B2 - olemas uus FHIR kinnitamine ja peale seda loodud RK retseptid, nendes muudatusi ei tehta - Ravimiskeemi kinnitamine
**Olukorra kirjeldus ja oodatud tulemus**

Päritud on B1 stsenaariumi vaade ning andmeid on ainult lisatud, pärimisel saadud andmetes muudatusi ei ole tehtud. Oodatud tulemuseks on B1 stsenaariumis päritud seisu FHIR andmetesse salvestamine.

**Seotud ärireeglid**
- Kinnitatud skeemi pärimisel Retseptikeskuse andmete pealt genereeritud ja klientsüsteemi poolt muutmata jäetud seisu salvestatakse kinnitamise juurde List.entry.flag=unchanged?

**Andmete vaade**

| Stsenaarium                                                                                   | Sisend                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Andmete seis enne kinnitamist<br>ajalises järjestuses                                                                                                                                                                      | Oodatud tulemus (andmete seis pärast kinnitamist)                                                                                                                                                                                                                            |
| --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| B2 - olemas uus FHIR kinnitamine ja peale seda loodud RK retseptid, nendes muudatusi ei tehta | MedicationStatement, kus:<br>id=MedicationStatement/1 ja<br>identifier.value": "1033333333" (viimasel kinnitamisel kõige hilisema retsepti ID)<br>andmed tuleks RK retseptilt E<br>.derivedFrom: tühi<br>.extension[uus]:<br>identifier.value": "1011111111",<br>identifier.value": "1022222222",<br>identifier.value": "1033333333"<br>identifier.value": "1044444444"<br>identifier.value": "1055555555"<br>Viimane kinnitamine:  RK  E - 1055555555 alusel | RK retsept A - 1011111111 <br>RK retsept B - 1022222222 <br>RK retsept C - 1033333333<br>FHIR List/1<br>FHIR MedicationStatement/1 (seotud retseptidega A, B, C)<br>RK retsept D - 1044444444<br>RK retsept E - 1055555555 | Tekivad FHIR andmed:<br>MedicationStatement/1 saab salvestatud uue seisuga (retseptilt E)<br>tekib List/2<br>mille sees on MedicationStatment ja flag=unchanged (vist?)<br>MedicationStatement on seotud kõikide seniste retspetidega (A..E) läbi ExtensionEETISGroupedItems |

<div>
<img src="grupeerimineb2.svg"  alt="Grupeerimise andmemudel B2" width="60%">
<p>Lõpptulemuse andmemudel</p>
<p></p>
</div>

### B2.1 - olemas uus FHIR kinnitamine ja peale seda loodud RK retseptid, sama rida on ka pikendatud - Ravimiskeemi kinnitamine
**Olukorra kirjeldus ja oodatud tulemus**

Päritud on B1 stsenaariumi vaade ning sealt saadud rida on ka klientsüsteemis(TJT) pikendatud. Oodatud tulemuseks on B1 stsenaariumis päritud seisu koos muudatustega FHIR andmetesse salvestamine ja uute Retseptikeskuse andmete loomine, seoste salvestamine

**Seotud ärireeglid**
- Pikendamisel ei muudeta eelmiseid seotud retsepte
- Pikendamisel tekkivad retseptide seosed lisatakse eelmiste seoste juurde (mitte ei asenda neid)

**Andmete vaade**

| Stsenaarium                                                                                   | Sisend                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Andmete seis enne kinnitamist<br>ajalises järjestuses                                                                                                                                                                      | Oodatud tulemus (andmete seis pärast kinnitamist)                                                                                                                                                                                                                            |
| --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| B2.1 - olemas uus FHIR kinnitamine ja peale seda loodud RK retseptid, nendes muudatusi ei tehta | MedicationStatement, kus:<br>id=MedicationStatement/1 ja<br>identifier.value": "1033333333" (viimasel kinnitamisel kõige hilisema retsepti ID)<br>andmed tuleks RK retseptilt E<br>.derivedFrom: tühi<br>.extension[uus]:<br>identifier.value": "1011111111",<br>identifier.value": "1022222222",<br>identifier.value": "1033333333"<br>identifier.value": "1044444444"<br>identifier.value": "1055555555"<br>Viimane kinnitamine:  RK  E - 1055555555 alusel | RK retsept A - 1011111111 <br>RK retsept B - 1022222222 <br>RK retsept C - 1033333333<br>FHIR List/1<br>FHIR MedicationStatement/1 (seotud retseptidega A, B, C)<br>RK retsept D - 1044444444<br>RK retsept E - 1055555555 | Tekivad FHIR andmed:<br>MedicationStatement/1 saab salvestatud uue seisuga (retseptilt E)<br>tekib List/2<br>mille sees on MedicationStatment ja flag=unchanged (vist?)<br>MedicationStatement on seotud kõikide seniste retspetidega (A..E) läbi ExtensionEETISGroupedItems |

StsenaariumSisendAndmete seis enne kinnitamist ajalises järjestusesOodatud tulemus (andmete seis pärast kinnitamist)B2.1 - olemas uus FHIR kinnitamine ja peale seda loodud RK retseptid, sama rida on ka pikendatud MedicationStatement, kus:id=MedicationStatement/1 jaidentifier.value": "1033333333" (viimasel kinnitamisel kõige hilisema retsepti ID)andmed tuleks RK retseptilt E, mille on üle kirjutanud TJT pikendamine.derivedFrom: tühi.extension[uus]:identifier.value": "1011111111",identifier.value": "1022222222",identifier.value": "1033333333"identifier.value": "1044444444"identifier.value": "1055555555"partOf: täidetud pikendamise tulemuselViimane kinnitamine:  RK  E - 1055555555 aluselRK retsept A - 1011111111 RK retsept B - 1022222222 RK retsept C - 1033333333FHIR List/1FHIR MedicationStatement/1 (seotud retseptidega A, B, C)RK retsept D - 1044444444RK retsept E - 1055555555Tekivad RK andmed läbi MedIN: uued pikendamisel tekkivad retseptid(F)Tekivad FHIR andmed:MedicationStatement/1 saab salvestatud uue seisuga (retseptilt E+TJT-s pikendatud andmed)tekib List/2 mille sees on MedicationStatment ja flag=changed MedicationStatement on seotud kõikide seniste retspetidega (A..E) läbi ExtensionEETISGroupedItemsMedicationStatement on läbi derivedFrom seotud uute loodud retseptidega (F)

Lõpptulemuse andmemudelit ei ole eraldi välja toodud, kuivõrd sarnasus stsenaariumiga B2 on väga suur.

### B2.2 - olemas uus FHIR kinnitamine ja peale seda loodud RK retseptid, sama rida on ka muudetud - Ravimiskeemi kinnitamine
**Olukorra kirjeldus ja oodatud tulemus**

Päritud on B1 stsenaariumi vaade ning sealt saadud rida on ka klientsüsteemis(TJT) muudetud. Oodatud tulemuseks on B1 stsenaariumis päritud seisu koos muudatustega FHIR andmetesse salvestamine, eelmiste Retseptikeskuse andmete annulleerimine ning uute Retseptikeskuse andmete loomine, seoste salvestamine.

**Seotud ärireeglid**
- Muutmisel püütakse eelmiseid seotud retsepte annulleerida (nii ExtensionEETISGroupedItems kui ka derivedFrom seose kaudu)
- Muutmisel juurde tekkivad retseptide seosed lisatakse eelmiste seoste juurde (mitte ei asenda neid), st annulleeritud retseptide seosed jäetakse alles

**Andmete vaade**

| Stsenaarium                                                                                    | Sisend                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | Andmete seis enne kinnitamist<br>ajalises järjestuses                                                                                                                                                                      | Oodatud tulemus (andmete seis pärast kinnitamist)                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| ---------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| B2.2 - olemas uus FHIR kinnitamine ja peale seda loodud RK retseptid, sama rida on ka muudetud | MedicationStatement, kus:<br>id=MedicationStatement/1 ja<br>identifier.value": "1033333333" (viimasel kinnitamisel kõige hilisema retsepti ID)<br>andmed tuleks RK retseptilt E, mille on üle kirjutanud TJT-s tehtud muudatused<br>.derivedFrom: tühi<br>.extension[uus]:<br>identifier.value": "1011111111",<br>identifier.value": "1022222222",<br>identifier.value": "1033333333"<br>identifier.value": "1044444444"<br>identifier.value": "1055555555"<br>Viimane kinnitamine:  RK  E - 1055555555 alusel | RK retsept A - 1011111111 <br>RK retsept B - 1022222222 <br>RK retsept C - 1033333333<br>FHIR List/1<br>FHIR MedicationStatement/1 (seotud retseptidega A, B, C)<br>RK retsept D - 1044444444<br>RK retsept E - 1055555555 | Tekivad RK andmed läbi MedIN:<br>uued muutmisel tekkivad retseptid(F)<br>RK-s püütakse eelmised retseptid annulleerida (A..E)<br><br>Tekivad FHIR andmed:<br>MedicationStatement/1 saab salvestatud uue seisuga (retseptilt E+TJT-s muudetud andmed)<br>tekib List/2<br>mille sees on MedicationStatment ja flag=changed<br>MedicationStatement on seotud kõikide seniste retspetidega (A..E) läbi ExtensionEETISGroupedItems<br>MedicationStatement on läbi derivedFrom seotud uute loodud retseptidega(F) |

Lõpptulemuse andmemudelit ei ole eraldi välja toodud, kuivõrd sarnasus stsenaariumiga B2 on väga suur.

### B2.3 - olemas uus FHIR kinnitamine ja peale seda loodud RK retseptid, sama rida on ka tühistatud - Ravimiskeemi kinnitamine
**Olukorra kirjeldus ja oodatud tulemus**

Päritud on B1 stsenaariumi vaade ning sealt saadud rida on ka klientsüsteemis(TJT) tühistatud. Oodatud tulemuseks on B1 stsenaariumis päritud seisu koos muudatustega FHIR andmetesse salvestamine, eelmiste Retseptikeskuse andmete annulleerimine, seoste salvestamine.

**Seotud ärireeglid**
- Tühistamisel püütakse eelmiseid seotud retsepte annulleerida (nii ExtensionEETISGroupedItems kui ka derivedFrom seose kaudu)

**Andmete vaade**

| Stsenaarium                                                                                      | Sisend                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | Andmete seis enne kinnitamist<br>ajalises järjestuses                                                                                                                                                                      | Oodatud tulemus (andmete seis pärast kinnitamist)                                                                                                                                                                                                                                                                                                                                    |
| ------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| B2.3 - olemas uus FHIR kinnitamine ja peale seda loodud RK retseptid, sama rida on ka tühistatud | MedicationStatement, kus:<br>id=MedicationStatement/1 ja<br>identifier.value": "1033333333" (viimasel kinnitamisel kõige hilisema retsepti ID)<br>andmed tuleks RK retseptilt E, mille on üle kirjutanud TJT-s tehtud muudatused<br>.derivedFrom: tühi<br>.extension[uus]:<br>identifier.value": "1011111111",<br>identifier.value": "1022222222",<br>identifier.value": "1033333333"<br>identifier.value": "1044444444"<br>identifier.value": "1055555555"<br>Viimane kinnitamine:  RK  E - 1055555555 alusel | RK retsept A - 1011111111 <br>RK retsept B - 1022222222 <br>RK retsept C - 1033333333<br>FHIR List/1<br>FHIR MedicationStatement/1 (seotud retseptidega A, B, C)<br>RK retsept D - 1044444444<br>RK retsept E - 1055555555 | Tekivad RK andmed läbi MedIN:<br>RK-s püütakse eelmised retseptid annulleerida (A..E)<br><br>Tekivad FHIR andmed:<br>MedicationStatement/1 saab salvestatud uue seisuga (retseptilt E+TJT-s muudetud andmed)<br>tekib List/2<br>mille sees on MedicationStatment ja flag=ceased<br>MedicationStatement on seotud kõikide seniste retspetidega (A..E) läbi ExtensionEETISGroupedItems |


Lõpptulemuse andmemudelit ei ole eraldi välja toodud, kuivõrd sarnasus stsenaariumiga B2 on väga suur.

### C1 - olemas grupeerimise loogikale eelnenud kujul FHIR kinnitamine ja peale seda loodud RK retseptid - Kinnitatud ravimiskeemi pärimine
**Olukorra kirjeldus ja oodatud tulemus**

**NB!** Tulenevalt ravimiskeemi juurutamise ajakavast tuleb arvestada olukorraga, kus Ravimiskeemis on enne grupeerimise funktsionaalsuse toodangusse jõudmist juba salvestatud FHIR andmeid, kus andmed ei ole grupeeritud kujul. Need tuleb kokku viia leitud Retseptikeskuse andmetega selliselt, et tekiks ilma kordusteta andmestik.

Oodatud tulemuseks on üle olemasolevate FHIR andmete ja Retseptikeskuse andmete nn hübriid-vaade, kus aluseks on võetud FHIR andmestik, mis on grupeeritud ning seda on ka üle kirjutatud kõige värskemate andmetega Retseptikeskusest. Eesmärk on etteulatuvalt arvestada järgmise kinnitamisega ning anda ette vajalikud FHIR ID-d selle jaoks.

**Seotud ärireeglid**
- Kokku grupeeritud FHIR andmetest tekib alati ainult üks MedicationStatement, konsolideeritavad MedicationStatement seosed lähevad reference'na ExtensionEETISGroupedItems extension'sse
- Kokku grupeeritud FHIR andmetega seotud retseptide viited viiakse kokku ExtensionEETISGroupedItems (või on siin veel derivedFrom kuidagi sees?) 
- MedicationStatement andmed tulevad kõige hilisemast andmestikust - kas siis retsept või FHIR andmed

**ANdmete vaade**

| Stsenaarium                                                                  | Andmete seis ajalises järjestuses                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Oodatud tulemus                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| ---------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| C1 - olemas tänasel kujul FHIR kinnitamine ja peale seda loodud RK retseptid | RK retsept A - 1011111111 <br>RK retsept B - 1022222222 <br>FHIR List/1<br>FHIR MedicationStatement/1 (seotud retseptiga A)<br>FHIR MedicationStatement/2 (seotud retseptiga B)<br>FHIR MedicationStatement/3 (seotud retseptiga C)<br>FHIR kaudu loodi ka RK retsept C - 1033333333<br>RK retsept D - 1044444444<br>RK retsept E - 1055555555<br>FHIR List/2<br>FHIR MedicationStatement/4 (seotud retseptiga D)<br>FHIR MedicationStatement/5 (seotud retseptiga E)<br>FHIR MedicationStatement/6 (seotud retseptiga F)<br>FHIR kaudu loodi ka RK retsept F - 1066666666<br>RK retsept G - 1077777777 | Väljundis on üks MedicationStatement:<br>\* ID-ks on MedicationStatement/6 (et hiljem kinnitamisel läheks muudatused õigesse kohta)<br>\* Selle andmed on Retsept G pealt<br>\* seotud retseptide all (ExtensionEETISGroupedItems) on kõik RK-s otse loodud retseptid: A, B, D, E, G<br>JA kõik eelmised MedicationStatement reference-d, mis on kehtivad:<br>MedicationStatement/1<br>MedicationStatement/2<br>MedicationStatement/3<br>MedicationStatement/4<br>MedicationStatement/5<br>\* derivedFrom on kõik läbi FHIR loodud retseptide (C, F)<br><br>\* kinnitatud ravimiskeemil tehakse RK päring alates List/2 loomise hetkest edasi ehk alates viimasest FHIR kinnitamisest<br><br>\* kas siia peaks kajastama ka muud andmed, nt EETISVerification?<br>\* MedicationStatement.status=draft?<br> |

<div>
<img src="grupeeriminec1.svg"  alt="Grupeerimise andmemudel C1" width="60%">
<p>Väljundi andmemudel</p>
<p></p>
</div>

### C2 - olemas grupeerimise loogikale eelnenud kujul FHIR kinnitamine ja peale seda loodud RK retseptid, sama rida on ka muudetud - Ravimiskeemi kinnitamine
**Olukorra kirjeldus ja oodatud tulemus**

NB! Tulenevalt ravimiskeemi juurutamise ajakavast tuleb arvestada olukorraga, kus Ravimiskeemis on enne grupeerimise funktsionaalsuse toodangusse jõudmist juba salvestatud FHIR andmeid, kus andmed ei ole grupeeritud kujul. Need tuleb kokku viia leitud Retseptikeskuse andmetega selliselt, et tekiks ilma kordusteta andmestik.

Päritud on C1 stsenaariumi vaade ning sealt saadud rida on ka klientsüsteemis(TJT) muudetud. Oodatud tulemuseks on C1 stsenaariumis päritud seisu koos muudatustega FHIR andmetesse salvestamine, eelmiste Retseptikeskuse andmete annulleerimine ning uute Retseptikeskuse andmete loomine, seoste salvestamine, ühtlasi ka kokku grupeeritud FHIR andmete konsolideerituks märkimine.

**Seotud ärireeglid**
- Kinnitamisel märgitakse kokku grupeeritud FHIR andmetes MedicationStatement.effective.end kinnitamise ajaga ning kinnitamise fakti juures List.entry.flag=consolidated? ehk peale kinnitamist ei ole grupeeritud MedicationStatement-d enam aktiivsed
Andmete vaade

**Andmete vaade**

| Stsenaarium                                                                                            | Sisend                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | Andmete seis enne kinnitamist<br>ajalises järjestuses                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | Oodatud tulemus (andmete seis pärast kinnitamist)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| C2 - olemas tänasel kujul FHIR kinnitamine ja peale seda loodud RK retseptid, sama rida on ka muudetud | MedicationStatement, kus:<br>id=MedicationStatement/6<br>andmed tuleks RK retseptilt G, mille on üle kirjutanud TJT-s tehtud muudatused<br>.derivedFrom:<br>identifier.value": "1066666666"<br>.extension[uus]:<br>identifier.value": "1011111111",<br>identifier.value": "1022222222",<br>identifier.value": "1033333333"<br>identifier.value": "1044444444"<br>identifier.value": "1055555555"<br>lisaks ka<br>MedicationStatment/1 (A)<br>MedicationStatment/2 (B)<br>MedicationStatment/3 (C)<br>MedicationStatment/4 (D)<br>MedicationStatment/5 (E)<br><br><br><br>Viimane kinnitamine:  RK  G - 1077777777 alusel | RK retsept A - 1011111111 <br>RK retsept B - 1022222222 <br>FHIR List/1<br>FHIR MedicationStatement/1 (seotud retseptiga A)<br>FHIR MedicationStatement/2 (seotud retseptiga B)<br>FHIR MedicationStatement/3 (seotud retseptiga C)<br>FHIR kaudu loodi ka RK retsept C - 1033333333<br>RK retsept D - 1044444444<br>RK retsept E - 1055555555<br>FHIR List/2<br>FHIR MedicationStatement/4 (seotud retseptiga D)<br>FHIR MedicationStatement/5 (seotud retseptiga E)<br>FHIR MedicationStatement/6 (seotud retseptiga F)<br>FHIR kaudu loodi ka RK retsept F - 1066666666<br>RK retsept G - 1077777777 | Tekivad RK andmed läbi MedIN:<br>uued muutmisel tekkivad retseptid(H)<br>RK-s püütakse eelmised retseptid annulleerida (A..G)<br><br>Tekivad FHIR andmed:<br>MedicationStatement/6 saab salvestatud uue seisuga (retseptilt G+TJT-s muudetud andmed)<br>tekib List/3<br>mille sees on MedicationStatement/6 ja flag=changed (eelmised read flag=consolidated)<br>MedicationStatement/6 on seotud kõikide seniste retspetidega (A, B, D, E, G)<br>MedicationStatment/6 on läbi derivedFrom seotud uute loodud retseptidega ja eelmise läbi FHIR loodud retseptidega (C, F, H) |

<div>
<img src="grupeeriminec2.svg"  alt="Grupeerimise andmemudel C2" width="60%">
<p>Väljundi andmemudel</p>
<p></p>
</div>

## Ravimiskeemi ajaloos kasutatav grupeerimise loogika
Ravimiskeemi ajaloos on kasutusel sama grupeerimise loogika, mis kinnitatud ravimiskeemi puhul, järgmiste erisustega:
- Ravimiskeemi ajaloos ei grupeerita andmeid reaalselt kokku, vaid määratakse igale ravimiskeemi reale, mis väljundisse läheb, eraldi grupeerimise identifikaator
- Ravimiskeemi ajaloos ei võeta grupeerimisel arvesse tugevust, vaid grupeeritakse eri tugevusega kuid kattuva ravimvormi ja toimeainete kombinatsiooniga ravimid
Äriline eeldus on olnud, et ravimiskeemi ajaloos kuvatav kinnitamiste ja kinnitatud ravimiskeemide andmestik ei vaja sellisel viisil grupeerimist.
Küll aga on täiendava andmestikuna kaasa pandud grupeerimise identifikaator, et TJT Ravimiskeemi vaates oleks võimalik ajajoonel visuaalselt kokku viia grupeeritavad read (mis väljale?)

## Ravimvormide grupeerimise loogika
Üldistatud kujul grupeeritakse ravimiskeemi ridu, millel on sama toimeainete ja tugevuste kombinatsioon, ja millel on:
- Detailne ravimvorm, mis sisaldab sõna "modifitseeritult vabastav" (näited all tabelis)
- Detailne ravimvorm, mis sisaldab sõna "prolongeeritult vabastav" (näited all tabelis)
- Detailse ravimvormiga seotud üldine ravimvorm sama (nt pehme närimiskapsel ja kõvakapsel on mõlemad üldise ravimvormi "kapsel" all)
    - sh üldiste ravimvormidega kapsel ja tablett grupeeritakse samuti kokku
    - read, kus on kasutatud rea küljes otse üldist ravimvormi, viiakse samuti sama üldise ravimvormi omavate ridadega kokku

| Id                                     | Üldine ravimvorm                                                                   | identifier loomine                                                                     |
| -------------------------------------- | ------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------- |
| **Üldise ravimvormi alusel kokku grupeeritavad** |
| 10000                                            | tablett                | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-tablett-kapsel"<br>**NB!** siin grupeeritakse kokku tabletid ja kapslid, v.a. erandid alt |
| 10001                                            | kapsel                 |
| 10002                                            | suposiit               | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-suposiit"                                                                               |
| 10003                                            | kreem                  | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-kreem"                                                                                  |
| 10004                                            | geel                   | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-geel"                                                                                   |
| 10005                                            | salv                   | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-salv"                                                                                   |
| 10006                                            | pasta                  | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-pasta"                                                                                  |
| 10007                                            | emulsioon              | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-emulsioon"                                                                              |
| 10008                                            | suspensioon            | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-suspensioon"                                                                            |
| 10009                                            | aerosool               | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-aerosool"                                                                               |
| 10010                                            | sprei                  | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-sprei"                                                                                  |
| 10011                                            | tilgad                 | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-tilgad"                                                                                 |
| 10012                                            | lahus                  | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-lahus"                                                                                  |
| 10013                                            | pulber                 | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-pulber"                                                                                 |
| 10014                                            | graanulid              | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-graanulid"                                                                              |
| 10015                                            | vaht                   | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-vaht"                                                                                   |
| 10016                                            | vedelik                | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-vedelik"                                                                                |
| 10017                                            | lahusti                | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-lahusti"                                                                                |
| 10018                                            | kontsentraat           | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-kontsentraat"                                                                           |
| 10019                                            | plaaster               | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-plaaster"                                                                               |
| 10020                                            | gaas                   | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-gaas"                                                                                   |
| 10021                                            | kile                   | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-kile"                                                                                   |
| 10022                                            | ravivahend             | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-ravivahend"                                                                             |
| 10023                                            | tampoon                | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-tampoon"                                                                                |
| 10024                                            | test                   | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-test"                                                                                   |
| 10025                                            | pulk                   | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-pulk"                                                                                   |
| 10026                                            | käsn                   | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-käsn"                                                                                   |
| 10027                                            | lakk                   | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-lakk"                                                                                   |
| 10028                                            | muu                    | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-muu"                                                                                    |
| 10029                                            | implantaat             | toimeaine nimi + üldine ravimvorm, nt "ibuprofeen-implantaat"                                                                             |


| Id                                     | Detailne ravimvorm                                                                   | identifier loomine                                                                     |
| -------------------------------------- | ------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------- |
| **Detailse ravimvormi alusel erandid** |
| 1218                                   | toimeainet modifitseeritult vabastav pehmekapsel                                     | Grupeerime kokku toimeaine nimi + "modif.vabastav", nt "ibuprofeen-modif.vabastav"     |
| 1219                                   | toimeainet modifitseeritult vabastav tablett                                         |
| 1217                                   | toimeainet modifitseeritult vabastav kõvakapsel                                      |
| 1220                                   | toimeainet modifitseeritult vabastavad graanulid                                     |
| 1699                                   | toimeainet modifitseeritult vabastavad suukaudse suspensiooni graanulid              |
| 1222                                   | toimeainet prolongeeritult vabastav kõvakapsel                                       | Grupeerime kokku toimeaine nimi + "prolong.vabastav", nt "ibuprofeen-prolong.vabastav" |
| 1223                                   | toimeainet prolongeeritult vabastav pehmekapsel                                      |
| 1224                                   | toimeainet prolongeeritult vabastav tablett                                          |
| 1225                                   | toimeainet prolongeeritult vabastavad graanulid                                      |
| 1226                                   | toimeainet prolongeeritult vabastavad silmatilgad                                    |
| 1446                                   | suukaudse suspensiooni toimeainet prolongeeritult vabastavad graanulid               |
| 1462                                   | toimeainet prolongeeritult vabastava süstesuspensiooni pulber ja lahusti             |
| 1483                                   | toimeainet prolongeeritult vabastav süstesuspensioon                                 |
| 1529                                   | toimeainet prolongeeritult vabastava süstesuspensiooni pulber ja lahusti pen-süstlis |
| 1537                                   | toimeainet prolongeeritult vabastava süstesuspensiooni pulber ja lahusti süstlis     |
| 1700                                   | toimeainet prolongeeritult vabastava süstesuspensiooni pulber                        |
| 1717                                   | silmatilgad, toimeainet prolongeeritult vabastav lahus üheannuselises konteineris    |
| 1734                                   | suukaudse suspensiooni toimeainet prolongeeritult vabastavad graanulid kotikeses     |
| 1735                                   | toimeainet prolongeeritult vabastavad graanulid kotikeses                            |
| 1736                                   | toimeainet prolongeeritult vabastav süstesuspensioon süstlis                         |
| 1755                                   | toimeainet prolongeeritult vabastav süstelahus                                       |
| 1779                                   | toimeainet prolongeeritult vabastav süstesuspensioon pen-süstlis                     |
| 1808                                   | toimeainet prolongeeritult vabastav haavalahus                                       |
| 1810                                   | toimeainet prolongeeritult vabastav süstedispersioon                                 |
| 1813                                   | toimeainet prolongeeritult vabastav suukaudne suspensioon                            |
| 1827                                   | toimeainet prolongeeritult vabastava suukaudse suspensiooni graanulid                |


### Loendid:
- [Ravimvormid](https://akk.tehik.ee/classifier/resources/value-sets/ravimvormid/versions/23.0.0/concepts)
- [Üldised ravimvormid](https://akk.tehik.ee/classifier/resources/code-systems/uldised-ravimvormid/versions/22.0.0/concepts)