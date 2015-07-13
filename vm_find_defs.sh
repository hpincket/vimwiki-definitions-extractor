#!/bin/sh

usage="
vm_find_defs.sh source dest \n
Where:\n
source -- is the name of a directory containing vimwiki text files\n
dest -- is the name of the directory to be used for output files\n
"
 
if [ "$#" -ne 2 ]; then 
    echo $usage
    exit
fi 

loc=$1
dest=$2
default='wiki-cards'

now=$(date +"%Y-%m-%d")

mkdir -p "$dest"

tail -n +1 "$loc"/* |
sed 's/^==>.*/DECK::'$default'/' | 
awk '
BEGIN {
    FS = "::";
    VALUE = 0;
    WORD = ""
    DEF = ""
    DECK = "";
}
{
    if (NF<=1 && VALUE == 1) {
        if(WORD == "DECK") {
            DECK = DEF;
        } else {
            printf("%s\t%s\n",WORD,DEF) >> ("'$dest'/" DECK "-'$now'.tsv");
        }
        VALUE = 0;
    } else if (NF==2) {
        # If new definition
        if ($1 != ""){
          # Clean up old definition
          if(VALUE == 1){
            if(WORD == "DECK") {
                DECK = DEF;
            } else {
                printf("%s\t%s\n",WORD,DEF) >> ("'$dest'/" DECK "-'$now'.tsv");
            }
            VALUE = 0;
          }
          # New Definition
          WORD = $1;
          DEF = $2;
        } else if(VALUE == 1){
          DEF=DEF $2;
        }
        VALUE = 1;
    }
}
END{}
'
