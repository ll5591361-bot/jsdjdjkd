$content = Get-Content 'words-data.json' -Raw
$matches = [regex]::Matches($content, '"pos": "verb"')
Write-Host "Total verbs: $($matches.Count)"
