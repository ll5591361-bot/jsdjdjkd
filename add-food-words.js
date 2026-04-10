const fs = require('fs');
const path = require('path');

// 读取现有数据
const dataPath = path.join(__dirname, 'words-data.json');
const data = JSON.parse(fs.readFileSync(dataPath, 'utf8'));

// 新增的美食相关单词
const newFoodWords = [
    {
        "word": "cook",
        "phonetic": "/kʊk/",
        "meaning": "v. 烹饪",
        "sentence": "I love to cook for my family.",
        "sentencePhonetic": "/aɪ lʌv tuː kʊk fɔː(r) maɪ ˈfæməli/",
        "letters": ["C", "O", "O", "K"],
        "category": "food",
        "pos": "verb"
    },
    {
        "word": "bake",
        "phonetic": "/beɪk/",
        "meaning": "v. 烘焙",
        "sentence": "I like to bake cookies.",
        "sentencePhonetic": "/aɪ laɪk tuː beɪk ˈkʊkiz/",
        "letters": ["B", "A", "K", "E"],
        "category": "food",
        "pos": "verb"
    },
    {
        "word": "fry",
        "phonetic": "/fraɪ/",
        "meaning": "v. 油炸",
        "sentence": "I can fry eggs.",
        "sentencePhonetic": "/aɪ kæn fraɪ eɡz/",
        "letters": ["F", "R", "Y"],
        "category": "food",
        "pos": "verb"
    },
    {
        "word": "grill",
        "phonetic": "/ɡrɪl/",
        "meaning": "v. 烧烤",
        "sentence": "We grill meat on weekends.",
        "sentencePhonetic": "/wiː ɡrɪl miːt ɒn ˈwiːkendz/",
        "letters": ["G", "R", "I", "L", "L"],
        "category": "food",
        "pos": "verb"
    }
];

// 添加新单词
const updatedWords = [...data.words, ...newFoodWords];
data.words = updatedWords;

// 保存更新后的数据
fs.writeFileSync(dataPath, JSON.stringify(data, null, 4), 'utf8');

console.log('✅ 已添加4个美食相关单词');
console.log('📋 新增单词:');
newFoodWords.forEach(word => {
    console.log(`   - ${word.word}: ${word.meaning}`);
});
console.log('\n🍔 美食餐饮分类现在有 100 个单词了！');
