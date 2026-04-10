const fs = require('fs');
const path = require('path');

// 同步统计数据的函数
function syncStats() {
    try {
        // 读取实际数据文件
        const wordsDataPath = path.join(__dirname, 'words-data.json');
        const categoriesPath = path.join(__dirname, 'words.json');
        
        if (!fs.existsSync(wordsDataPath)) {
            throw new Error('words-data.json 文件不存在');
        }
        
        if (!fs.existsSync(categoriesPath)) {
            throw new Error('words.json 文件不存在');
        }
        
        const wordsData = JSON.parse(fs.readFileSync(wordsDataPath, 'utf8'));
        const categoriesData = JSON.parse(fs.readFileSync(categoriesPath, 'utf8'));
        
        // 统计各词性数量
        const posCounts = {};
        const categoryCounts = {};
        
        wordsData.words.forEach(word => {
            // 统计词性
            posCounts[word.pos] = (posCounts[word.pos] || 0) + 1;
            
            // 统计分类
            categoryCounts[word.category] = (categoryCounts[word.category] || 0) + 1;
        });
        
        console.log('📊 词性统计结果:');
        Object.entries(posCounts).forEach(([pos, count]) => {
            console.log(`   ${pos}: ${count} 个`);
        });
        
        console.log('\n📋 分类统计结果:');
        Object.entries(categoryCounts).forEach(([category, count]) => {
            console.log(`   ${category}: ${count} 个`);
        });
        
        // 更新词性分类统计
        categoriesData.posCategories.forEach(category => {
            const oldCount = category.totalWords;
            const newCount = posCounts[category.id] || 0;
            category.totalWords = newCount;
            
            if (oldCount !== newCount) {
                console.log(`\n🔄 更新 ${category.name} 统计: ${oldCount} → ${newCount}`);
            }
        });
        
        // 更新分类统计
        categoriesData.categories.forEach(category => {
            const oldCount = category.totalWords;
            const newCount = categoryCounts[category.id] || 0;
            category.totalWords = newCount;
            
            if (oldCount !== newCount) {
                console.log(`🔄 更新 ${category.name} 统计: ${oldCount} → ${newCount}`);
            }
        });
        
        // 更新总统计
        const totalWords = wordsData.words.length;
        categoriesData.stats.totalWords = totalWords;
        console.log(`\n📈 总单词数: ${totalWords}`);
        
        // 保存更新后的数据
        fs.writeFileSync(categoriesPath, JSON.stringify(categoriesData, null, 4), {
            encoding: 'utf8'
        });
        
        console.log('\n✅ 统计数据同步完成！');
        
    } catch (error) {
        console.error('❌ 同步统计数据时出错:', error.message);
    }
}

// 执行同步
syncStats();
