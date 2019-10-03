$dir = Get-Location 
set-Location $dir
$exclude = @("001-abstract.md", "005-zusammenfassung.md")
$input = Get-Item "src\*.md" -Exclude $exclude | Resolve-Path -Relative




pandoc $input -o out/Report.pdf `
    --include-before-body=".\src\001-abstract.md" `
    --include-before-body=".\src\005-zusammenfassung.md" `
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
    -f markdown-implicit_figures `
    --filter pandoc-citeproc
