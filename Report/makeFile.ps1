$dir = Get-Location 
set-Location $dir
$input = Get-Item src\*.md | Resolve-Path -Relative



pandoc $input -o out/Projektvereinbarung.pdf `
    --from markdown `
    --template eisvogel `
    --listings `
    --number-sections `
    -V lang=de `
    -V papersize:a4 `
    --toc `
    --toc-depth=2 `
    --bibliography=biblio.bib  `
    --csl=ieee.csl `
    --highlight-style breezedark