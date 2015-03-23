# VimWiki definitions extractor
Finds all terms/definitions in a vimwiki and saves them in a tsv (to be added to anki)


Definitions in Vimwiki are formatted as follows

```
    word:: this is a definition

    word2::
    :: really
    :: really 
    :: long     
    :: definition
```

Note: Spaces won't matter for the script.


Cool feature: Add a DECK definition to your vimwiki files above normal
definitions to separate your terms. All following definitions will be placed in
that category until a new DECK is declared or a new file starts. Failing to
declare DECK will default definitions to a misc file.

Example:

```
== My Document ==
DECK::Animals

Fox::A small red furry creature

Hedgehogs::Spiky thing, good for throwing at enemies

DECK::Software

Fox::Mascot of a popular browser
```
