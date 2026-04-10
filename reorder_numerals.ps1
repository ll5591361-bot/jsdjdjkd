# 读取JSON文件
$jsonContent = Get-Content -Path "words-data.json" -Raw -Encoding UTF8
$data = $jsonContent | ConvertFrom-Json

# 分离数词和其他单词
$numerals = @()
$others = @()

foreach ($word in $data.words) {
    if ($word.pos -eq "numeral") {
        $numerals += $word
    } else {
        $others += $word
    }
}

Write-Host "Found $($numerals.Count) numerals"
Write-Host "Other words: $($others.Count)"

# 定义数词顺序
$numeralOrder = @(
    'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine',
    'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen',
    'seventeen', 'eighteen', 'nineteen',
    'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety',
    'hundred', 'thousand', 'million',
    'first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh', 'eighth', 'ninth', 'tenth',
    'half', 'quarter', 'double', 'triple', 'dozen', 'single', 'pair', 'couple', 'several', 'both'
)

# 创建数词字典
$numeralDict = @{}
foreach ($n in $numerals) {
    $numeralDict[$n.word] = $n
}

# 按顺序排列数词
$sortedNumerals = @()
foreach ($wordName in $numeralOrder) {
    if ($numeralDict.ContainsKey($wordName)) {
        $sortedNumerals += $numeralDict[$wordName]
        Write-Host "Added: $wordName"
    } else {
        Write-Host "Warning: Not found $wordName"
    }
}

Write-Host "Sorted numerals count: $($sortedNumerals.Count)"

# 找到插入位置（在interjection之后）
$insertIndex = 0
for ($i = 0; $i -lt $others.Count; $i++) {
    if ($others[$i].pos -eq "interjection") {
        $insertIndex = $i + 1
    }
}

Write-Host "Insert position: $insertIndex"

# 合并列表
$part1 = $others | Select-Object -First $insertIndex
$part2 = $others | Select-Object -Skip $insertIndex
$newWords = @()
$newWords += $part1
$newWords += $sortedNumerals
$newWords += $part2

Write-Host "Total words: $($newWords.Count)"

# 保存回文件
$data.words = $newWords
$newJson = $data | ConvertTo-Json -Depth 10
$newJson | Set-Content -Path "words-data.json" -Encoding UTF8

Write-Host "Done! Numerals reordered by number sequence."
