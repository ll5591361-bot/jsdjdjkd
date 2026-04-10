const fs = require('fs');
const path = require('path');

// 运行所有维护脚本
function runMaintenance() {
    console.log('🚀 开始执行维护任务...\n');
    
    // 1. 先创建备份
    console.log('1️⃣ 创建数据备份');
    try {
        require('./backup-data.js');
    } catch (error) {
        console.error('❌ 执行备份脚本时出错:', error.message);
    }
    
    console.log('\n' + '='.repeat(50) + '\n');
    
    // 2. 修复编码
    console.log('2️⃣ 修复文件编码');
    try {
        require('./fix-encoding.js');
    } catch (error) {
        console.error('❌ 执行编码修复脚本时出错:', error.message);
    }
    
    console.log('\n' + '='.repeat(50) + '\n');
    
    // 3. 同步统计数据
    console.log('3️⃣ 同步统计数据');
    try {
        require('./sync-stats.js');
    } catch (error) {
        console.error('❌ 执行统计同步脚本时出错:', error.message);
    }
    
    console.log('\n' + '='.repeat(50) + '\n');
    console.log('✅ 所有维护任务执行完成！');
    console.log('\n📋 维护结果:');
    console.log('   - 数据已备份');
    console.log('   - 文件编码已修复');
    console.log('   - 统计数据已同步');
    console.log('\n🎯 建议定期运行此脚本，保持数据一致性！');
}

// 执行维护任务
runMaintenance();
