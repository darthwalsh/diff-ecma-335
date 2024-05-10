$pdf = 'ECMA-335.pdf'
if (-not (Test-Path $pdf)) {
    Write-Host "Downloading ECMA-335..."
    Invoke-WebRequest -Uri 'https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf' -OutFile $pdf
}

$txt = 'ECMA-335.txt'
# scoop install poppler or yay -S pdftotext
if (-not (Test-Path $txt)) {
    Write-Host "Converting PDF to text..."
    pdftotext -raw -layout $pdf $txt
}

Get-Content -Raw $txt
  | grep -v 'Ecma International 2012' # Remove footers
  | sed -e "s/`f//g" # Remove form feed control chars
  | sed -e 's/[“”]/"/g' -e "s/[‘’]/'/g" # Normalize smart quotes
  | sed -e "s//→/g" # Normalize arrows
  | sed -e "s//-/g" # Normalize bullets
  | sed --null-data --regexp-extended "s/\n([a-z])/ \1/g" # Remove newline before lowercase
  | Set-Content norm.txt -Encoding 'UTF-8'
