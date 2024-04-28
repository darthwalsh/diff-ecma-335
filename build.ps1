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

Get-Content -Raw $txt > norm.txt
