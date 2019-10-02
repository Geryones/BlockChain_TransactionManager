$dir = Get-Location 
set-Location $dir
$exclude = @("001-abstract.md", "005-zusammenfassung.md")
$input = Get-Item "src\*.md" -Exclude $exclude | Resolve-Path -Relative



pandoc $input -o out/Projektvereinbarung.pdf `
    --include-before-body=".\src\001-abstract.md" `
    --include-before-body=".\src\005-zusammenfassung.md" `
    --metadata-file=metadata.yml `
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