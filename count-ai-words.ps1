$data = Get-Content 'f:\Users\Administrator\AndroidStudioProjects\english-app-panel\ai-words.json' -Raw | ConvertFrom-Json
Write-Host "实际单词数量: $($data.aiWords.Count)"
Write-Host "记录的数量: $($data.stats.totalAiWords)"
