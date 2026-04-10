const fs = require('fs');

// 读取 words-data.json
const data = JSON.parse(fs.readFileSync('words-data.json', 'utf8'));

// 统计形容词
const adjectives = data.words.filter(w => w.pos === 'adjective');
console.log('Total adjectives:', adjectives.length);

// 显示最后10个形容词
console.log('\nLast 10 adjectives:');
adjectives.slice(-10).forEach(v => console.log(' -', v.word));
