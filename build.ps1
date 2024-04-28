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
  | Set-Content norm.txt -Encoding 'UTF-8'


