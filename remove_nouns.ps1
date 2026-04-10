# 读取 words-data.json
$jsonContent = Get-Content 'words-data.json' -Raw -Encoding UTF8 | ConvertFrom-Json

# 获取所有单词
$allWords = $jsonContent.words

# 分离名词和非名词
$nouns = $allWords | Where-Object { $_.pos -eq 'noun' }
$nonNouns = $allWords | Where-Object { $_.pos -ne 'noun' }

Write-Host "当前名词数量: $($nouns.Count)"
Write-Host "非名词数量: $($nonNouns.Count)"
Write-Host "总单词数量: $($allWords.Count)"

# 只保留前438个名词（删除100个）
$nounsToKeep = $nouns | Select-Object -First 438
$nounsToRemove = $nouns | Select-Object -Skip 438

Write-Host ""
Write-Host "要删除的名词数量: $($nounsToRemove.Count)"
Write-Host "要保留的名词数量: $($nounsToKeep.Count)"

# 显示要删除的单词
Write-Host ""
Write-Host "要删除的单词:"
for ($i = 0; $i -lt $nounsToRemove.Count; $i++) {
    Write-Host "$($i + 1). $($nounsToRemove[$i].word)"
}

# 合并保留的名词和所有非名词
$newWords = $nounsToKeep + $nonNouns

Write-Host ""
Write-Host "删除后的总单词数量: $($newWords.Count)"

# 创建新的JSON对象
$newJson = @{
    words = $newWords
}

# 保存回文件
$newJson | ConvertTo-Json -Depth 10 | Set-Content 'words-data.json' -Encoding UTF8

Write-Host ""
Write-Host "已删除100个名词，保留438个名词"
Write-Host "完成！"
