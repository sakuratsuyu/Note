param($PATH)

$CURRENT = (Get-Location).Path
echo $CURRENT

$BASENAME = (Split-Path $PATH)
$TEX = (Split-Path $PATH -Leaf)
$FILENAME = (Split-Path $PATH -LeafBase)

$XDV = $FILENAME + ".xdv"
$SVG = $FILENAME + ".svg"
$AUX = $FILENAME + ".aux"
$LOG = $FILENAME + ".log"

cd $BASENAME

xelatex -no-pdf -interaction=batchmode -halt-on-error $TEX > $null
dvisvgm $XDV -n -v 0 -o $SVG > $null
Remove-Item $XDV,$AUX,$LOG
Remove-Item *.pdf,*synctex.gz

cd $CURRENT