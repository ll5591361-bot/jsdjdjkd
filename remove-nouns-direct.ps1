# 读取 JSON 文件
$jsonContent = Get-Content -Path "words-data.json" -Raw -Encoding UTF8

# 使用 .NET JSON 解析
$data = [System.Text.Json.JsonDocument]::Parse($jsonContent)
$words = $data.RootElement.GetProperty("words").EnumerateArray()

# 分离名词和非名词
$nouns = @()
$nonNouns = @()

foreach ($word in $words) {
    $pos = $word.GetProperty("pos").GetString()
    if ($pos -eq "noun") {
        $nouns += $word
    } else {
        $nonNouns += $word
    }
}

Write-Host "名词总数: $($nouns.Count)"
Write-Host "非名词总数: $($nonNouns.Count)"

# 保留前388个名词
$nounsToKeep = $nouns[0..387]
$nounsToRemove = $nouns[388..($nouns.Count-1)]

Write-Host "保留名词数: $($nounsToKeep.Count)"
Write-Host "删除名词数: $($nounsToRemove.Count)"

# 显示要删除的名词
Write-Host "`n要删除的名词:"
for ($i = 0; $i -lt $nounsToRemove.Count; $i++) {
    $w = $nounsToRemove[$i]
    $wordText = $w.GetProperty("word").GetString()
    $category = $w.GetProperty("category").GetString()
    Write-Host "$($i+1). $wordText ($category)"
}

# 合并保留的单词
$newWords = $nounsToKeep + $nonNouns
Write-Host "`n新总单词数: $($newWords.Count)"

# 构建新的 JSON
$newWordsJson = @()
foreach ($word in $newWords) {
    $wordObj = @{}
    foreach ($prop in $word.EnumerateObject()) {
        $key = $prop.Name
        $value = $prop.Value
        
        # 根据类型转换值
        if ($value.ValueKind -eq [System.Text.Json.JsonValueKind]::String) {
            $wordObj[$key] = $value.GetString()
        } elseif ($value.ValueKind -eq [System.Text.Json.JsonValueKind]::Array) {
            $arr = @()
            foreach ($item in $value.EnumerateArray()) {
                if ($item.ValueKind -eq [System.Text.Json.JsonValueKind]::String) {
                    $arr += $item.GetString()
                }
            }
            $wordObj[$key] = $arr
        }
    }
    $newWordsJson += $wordObj
}

$newData = @{ words = $newWordsJson }

# 转换为 JSON 并保存
$newJson = $newData | ConvertTo-Json -Depth 10
$newJson | Set-Content -Path "words-data.json" -Encoding UTF8

Write-Host "`n处理完成！文件已更新。"
