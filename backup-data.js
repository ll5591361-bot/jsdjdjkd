const fs = require('fs');
const path = require('path');

// 创建备份的函数
function createBackup() {
    try {
        // 获取当前时间戳
        const timestamp = new Date().toISOString()
            .replace(/[:.]/g, '-')
            .replace('T', '_');
        
        // 创建备份目录
        const backupDir = path.join(__dirname, 'backups');
        if (!fs.existsSync(backupDir)) {
            fs.mkdirSync(backupDir);
            console.log('✅ 创建备份目录:', backupDir);
        }
        
        // 需要备份的文件
        const filesToBackup = [
            'words.json',
            'words-data.json',
            'ai-words.json',
            'color-words.json'
        ];
        
        console.log('开始创建数据备份...\n');
        
        // 备份每个文件
        filesToBackup.forEach(file => {
            const sourcePath = path.join(__dirname, file);
            if (fs.existsSync(sourcePath)) {
                const backupFileName = `${file.replace('.json', '')}_${timestamp}.json`;
                const backupPath = path.join(backupDir, backupFileName);
                
                // 复制文件
                fs.copyFileSync(sourcePath, backupPath);
                console.log(`✅ 已备份 ${file} → ${backupFileName}`);
            } else {
                console.log(`⚠️ 文件 ${file} 不存在，跳过备份`);
            }
        });
        
        // 清理旧备份（保留最近5个）
        cleanupOldBackups(backupDir);
        
        console.log('\n✅ 备份完成！');
        
    } catch (error) {
        console.error('❌ 创建备份时出错:', error.message);
    }
}

// 清理旧备份的函数
function cleanupOldBackups(backupDir) {
    try {
        const files = fs.readdirSync(backupDir)
            .filter(file => file.endsWith('.json'))
            .map(file => ({
                name: file,
                path: path.join(backupDir, file),
                mtime: fs.statSync(path.join(backupDir, file)).mtime
            }))
            .sort((a, b) => b.mtime - a.mtime); // 按修改时间倒序
        
        // 保留最近5个备份
        const filesToDelete = files.slice(5);
        filesToDelete.forEach(file => {
            fs.unlinkSync(file.path);
            console.log(`🗑️  清理旧备份: ${file.name}`);
        });
        
    } catch (error) {
        console.error('❌ 清理旧备份时出错:', error.message);
    }
}

// 执行备份
createBackup();
