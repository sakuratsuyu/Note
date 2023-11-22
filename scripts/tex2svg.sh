FILEPATH=$1

CURRENT=`pwd`

DIRNAME=`dirname $FILEPATH`
TEX=`basename $FILEPATH`
FILENAME=`basename $FILEPATH .tex`

XDV=$FILENAME".xdv"
SVG=$FILENAME".svg"
AUX=$FILENAME".aux"
LOG=$FILENAME".log"

cd $DIRNAME

xelatex -no-pdf -interaction=batchmode -halt-on-error $TEX > /dev/null
dvisvgm $XDV -n -v 0 -o $SVG > /dev/null
rm $XDV $AUX $LOG
rm *.pdf *.synctex.gz 2> /dev/null

cd $CURRENT