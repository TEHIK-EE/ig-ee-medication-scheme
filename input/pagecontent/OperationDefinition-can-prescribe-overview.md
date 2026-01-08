## Kirjeldus
Lisamise valideerimist päritakse uue ravimi lisamisel või kehtiva muutmisel. Selle operatsiooni käigus kontrollitakse kas sama ravimivormi ja toimeainetega ravim juba eksisteerib ravimiplaanis või mustandites.  Operatsiooni saab kasutada kas koos mustanditega või ilma. 

Eesmärk on pakkuda klientsüsteemidele võimalust taaskasutada MedIN sisemist loogikat ja kontrolle ja vältida äriloogika dubleerimist.

Operatsiooni üldine käik:

- Sisendisse antud patsiendi kohta leitakse MedIN serveri andmestikust kehtiv ravimiskeem
    - sisemiselt tehakse Kinnitatud ravimiskeemi pärimine, rakendades seal olevat loogikat, et saada kätte hetkel kehtiv ravimiskeemi seis
    - kinnitatud skeemi pärimist tehakse teatud määral optimeeritult:
        - ei pärita RK tühistamisi
        - ei pärita FHIR andmetele juurde RK andmeid (väljastused)
- Iga ravimiskeemist leitud ravimit võrreldakse sisendisse antud ravimiga, et tuvastada kas ravimivorm ja toimeained kattuvad. Nende kattumise korral kontrollitakse ka tugevuse kattumist.
    - toimeainete puhul kontrollitakse üks-ühele kattuvust, st:
        - üksiku toimeaine puhul võrdsust
        - kombinatsiooni puhul toimeainete ja nende järjekordade võrdsust
    - Ravimvormi kattuvuse tuvastamise aluseks on Ravimvormide grupeerimise loogika
- Kui ühtegi kattuvust ei ole tagastab operatsioon teate et konflikte ei ole.
- Kui leitakse kattuvusi, tagastatakse iga kattuva ravimi kohta sõnum.  
    - sh eristatakse kattuvusi toimeaine+ravimvorm ning toimeaine+ravimvorm+tugevus (vt MedIN.04 - Vigade kataloog )
- Kui sisendisse anti kaasa ka mustandid tehakse sama kattuvuste kontroll ka sisendist tulnud ravimi ja mustandite vahel.