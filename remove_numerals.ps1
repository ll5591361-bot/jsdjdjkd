$jsonContent = Get-Content 'words-data.json' -Raw -Encoding UTF8 | ConvertFrom-Json

$filteredWords = @()
foreach ($word in $jsonContent.words) {
    if (-not ($word.category -eq 'education' -and $word.pos -eq 'numeral')) {
        $filteredWords += $word
    }
}

$jsonContent.words = $filteredWords

$jsonContent | ConvertTo-Json -Depth 10 | Set-Content 'words-data.json' -Encoding UTF8

Write-Host "Remaining words: $($filteredWords.Count)"
