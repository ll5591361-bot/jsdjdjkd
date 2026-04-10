const fs = require('fs');

// 读取JSON文件
const data = JSON.parse(fs.readFileSync('words-data.json', 'utf8'));
const words = data.words;

// 分离数词和其他单词
const numerals = [];
const others = [];

for (const word of words) {
    if (word.pos === 'numeral') {
        numerals.push(word);
    } else {
        others.push(word);
    }
}

console.log(`Found ${numerals.length} numerals`);
console.log(`Other words: ${others.length}`);

// 定义数词顺序
const numeralOrder = [
    // 基数词 0-19
    'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine',
    'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen',
    'seventeen', 'eighteen', 'nineteen',
    // 整十基数词
    'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety',
    // 大数
    'hundred', 'thousand', 'million',
    // 序数词
    'first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh', 'eighth', 'ninth', 'tenth',
    // 其他数量词
    'half', 'quarter', 'double', 'triple', 'dozen', 'single', 'pair', 'couple', 'several', 'both'
];

// 创建数词字典
const numeralDict = {};
for (const n of numerals) {
    numeralDict[n.word] = n;
}

// 按顺序排列数词
const sortedNumerals = [];
for (const wordName of numeralOrder) {
    if (numeralDict[wordName]) {
        sortedNumerals.push(numeralDict[wordName]);
        console.log(`Added: ${wordName}`);
    } else {
        console.log(`Warning: Not found ${wordName}`);
    }
}

console.log(`\nSorted numerals count: ${sortedNumerals.length}`);

// 找到插入位置（在interjection之后）
let insertIndex = 0;
for (let i = 0; i < others.length; i++) {
    if (others[i].pos === 'interjection') {
        insertIndex = i + 1;
    }
}

console.log(`Insert position: ${insertIndex}`);

// 合并列表
const newWords = [
    ...others.slice(0, insertIndex),
    ...sortedNumerals,
    ...others.slice(insertIndex)
];

console.log(`Total words: ${newWords.length}`);

// 保存回文件
data.words = newWords;
fs.writeFileSync('words-data.json', JSON.stringify(data, null, 4), 'utf8');

console.log('\nDone! Numerals reordered by number sequence.');
