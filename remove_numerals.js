const fs = require('fs');

const data = JSON.parse(fs.readFileSync('words-data.json', 'utf8'));

// 过滤掉教育类别中的数词
const filteredWords = data.words.filter(word => {
    return !(word.category === 'education' && word.pos === 'numeral');
});

data.words = filteredWords;

fs.writeFileSync('words-data.json', JSON.stringify(data, null, 2), 'utf8');

console.log(`Remaining words: ${filteredWords.length}`);
