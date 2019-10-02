$dir = Get-Location 
set-Location $dir
$input = Get-Item src\*.md | Resolve-Path -Relative



pandoc $input -o out/Projektvereinbarung.pdf `
    --metadata-file=metadata.yml `
    --from markdown `
    --template eisvogel `
    --listings `
    --number-sections `
    -V lang=de `
    -V papersize:a4 `
    -V book `
    --toc `
    --toc-depth=2 `
    --bibliography=biblio.bib  `
    --csl=ieee.csl `
    --highlight-style breezedark