const fs = require('fs');

// 读取 words-data.json
const data = JSON.parse(fs.readFileSync('words-data.json', 'utf8'));

// 统计动词
const verbs = data.words.filter(w => w.pos === 'verb');
console.log('Total verbs:', verbs.length);

// 显示前10个和后10个动词
console.log('\nFirst 10 verbs:');
verbs.slice(0, 10).forEach(v => console.log(' -', v.word));

console.log('\nLast 10 verbs:');
verbs.slice(-10).forEach(v => console.log(' -', v.word));
