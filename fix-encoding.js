const fs = require('fs');
const path = require('path');

// 检查并修复编码的函数
function fixEncoding(filePath) {
    try {
        // 读取文件（强制使用UTF-8编码）
        const content = fs.readFileSync(filePath, 'utf8');
        
        // 检查是否有乱码（简单检测中文字符）
        const hasChinese = /[\u4e00-\u9fa5]/.test(content);
        
        // 写入文件（确保使用UTF-8编码）
        fs.writeFileSync(filePath, content, {
            encoding: 'utf8'
        });
        
        console.log(`✅ 已修复 ${path.basename(filePath)} 的编码`);
        console.log(`   - 包含中文字符: ${hasChinese}`);
        
    } catch (error) {
        console.error(`❌ 修复 ${path.basename(filePath)} 时出错:`, error.message);
    }
}

// 需要检查的JSON文件
const jsonFiles = [
    'words.json',
    'words-data.json',
    'ai-words.json',
    'color-words.json',
    'sports_words_batch1.json'
];

console.log('开始检查和修复文件编码...\n');

// 处理每个文件
jsonFiles.forEach(file => {
    const filePath = path.join(__dirname, file);
    if (fs.existsSync(filePath)) {
        fixEncoding(filePath);
    } else {
        console.log(`⚠️ 文件 ${file} 不存在`);
    }
});

console.log('\n编码检查和修复完成！');
