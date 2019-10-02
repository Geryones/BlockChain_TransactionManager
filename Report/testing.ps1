$dir = split-path -parent $MyInvocation.MyCommand.Definition
$path = "{0}\src" -f $dir
$exclude = @("001-abstract.md", "005-zusammenfassung.md")
$input = Get-Item -Path $path -Exclude $exclude | Resolve-Path -Relative
$input