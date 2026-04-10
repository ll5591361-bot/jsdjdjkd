$content = Get-Content 'words-data.json' -Raw
$matches = [regex]::Matches($content, '"pos": "adjective"')
Write-Host "Total adjectives: $($matches.Count)"
