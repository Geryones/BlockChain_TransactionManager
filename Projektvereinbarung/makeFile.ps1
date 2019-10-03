$dir = Get-Location 
set-Location $dir
$input = Get-Item src\*.md | Resolve-Path -Relative


pandoc $input -o out/Projektvereinbarung.pdf `
    --metadata-file=metadata.yml `
    --from markdown `
    --template="./templates/eisvogel.latex" `
    --listings `
    --number-sections `
    -V lang=de `
    -V papersize:a4 `
    -V book `
    -V classoption=oneside `
    --toc `
    --toc-depth=2 `
    --bibliography=biblio.bib  `
    --csl=ieee.csl `
    --highlight-style breezedark `
    --top-level-division=chapter `
    --filter pandoc-citeproc
