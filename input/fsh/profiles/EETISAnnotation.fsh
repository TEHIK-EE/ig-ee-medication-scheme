Profile: EETISAnnotation
Parent: Annotation
Id: ee-tis-annotation
Description: "Kommentaar/märkus. Note or comment with time and author."
* ^version = "1.0.0"
* ^status = #draft
* ^date = "2024-01-31T13:55:03.1985103+00:00"
* . ^short = "Note/comment"
* . ^definition = "Kommentaar/märkus.Kommentaar terve ravimiskeemi kohta. Erineb ravimiskeemi üksiku rea kommentaarist, vt. Communication-profiili."
* author[x] ^short = "Healthcare professional who added comment. Use string to express the name and role of HCP"
    //author ^definition = "Kommentaari lisaja. Kasutada stringi näitamaks THT nime ja rolli"
//* note.time 0..1 
* time ^short = "Time when the comment was added."
* time ^definition = "Kommentaari lisamise aeg"
* text ^short = "Comment about medication scheme"
* text ^definition = "Kommentaari sisu"
