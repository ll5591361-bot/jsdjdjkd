const fs = require('fs');

// 读取 words-data.json
const data = JSON.parse(fs.readFileSync('words-data.json', 'utf8'));

// 获取所有单词
const allWords = data.words;

// 分离名词和非名词
const nouns = allWords.filter(w => w.pos === 'noun');
const nonNouns = allWords.filter(w => w.pos !== 'noun');

console.log(`当前名词数量: ${nouns.length}`);
console.log(`非名词数量: ${nonNouns.length}`);
console.log(`总单词数量: ${allWords.length}`);

// 只保留前388个名词（删除150个）
const nounsToKeep = nouns.slice(0, 388);
const nounsToRemove = nouns.slice(388);

console.log(`\n要删除的名词数量: ${nounsToRemove.length}`);
console.log(`要保留的名词数量: ${nounsToKeep.length}`);

// 显示要删除的单词
console.log('\n要删除的单词:');
nounsToRemove.forEach((w, i) => {
    console.log(`${i + 1}. ${w.word} (${w.category})`);
});

// 合并保留的名词和所有非名词
const newWords = [...nounsToKeep, ...nonNouns];

console.log(`\n删除后的总单词数量: ${newWords.length}`);

// 保存回文件
fs.writeFileSync('words-data.json', JSON.stringify({words: newWords}, null, 4), 'utf8');

console.log('\n已删除150个名词，保留388个名词');
console.log('完成！');
