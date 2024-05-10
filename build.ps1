$pdf = 'stakx-ecma-335.pdf'
if (-not (Test-Path $pdf)) {
    throw "Create $pdf by printing https://carlwa.com/ecma-335/ to PDF from chrome"
}

$txt = 'tmp.txt'
# scoop install poppler or yay -S pdftotext
if (-not (Test-Path $txt)) {
    Write-Host "Converting PDF to text..."
    pdftotext -raw -layout $pdf $txt
}

Get-Content -Raw $txt
  | sed -e 's/[“”]/"/g' -e "s/[‘’]/'/g" # Normalize smart quotes
  | sed -e "s/`f//g" # Remove form feed control chars
  | sed --null-data --regexp-extended "s/\n([a-z])/ \1/g" # Remove newline before lowercase
  | Set-Content norm.txt -Encoding 'UTF-8'


