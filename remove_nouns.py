import json

# 读取 words-data.json
with open('words-data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# 获取所有单词
all_words = data['words']

# 分离名词和非名词
nouns = [w for w in all_words if w.get('pos') == 'noun']
non_nouns = [w for w in all_words if w.get('pos') != 'noun']

print(f"当前名词数量: {len(nouns)}")
print(f"非名词数量: {len(non_nouns)}")

# 只保留前488个名词（删除50个）
nouns_to_keep = nouns[:488]
nouns_to_remove = nouns[488:]

print(f"要删除的名词数量: {len(nouns_to_remove)}")
print(f"要保留的名词数量: {len(nouns_to_keep)}")

# 合并保留的名词和所有非名词
new_words = nouns_to_keep + non_nouns

print(f"删除后的总单词数量: {len(new_words)}")

# 保存回文件
with open('words-data.json', 'w', encoding='utf-8') as f:
    json.dump({'words': new_words}, f, ensure_ascii=False, indent=4)

print("已删除50个名词，保留488个名词")
print("完成！")
