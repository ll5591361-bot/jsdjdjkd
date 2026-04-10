import re

# 读取 script.js 文件
with open('script.js', 'r', encoding='utf-8') as f:
    content = f.read()

# 提取所有单词和分类
word_category_pattern = re.compile(r'"word": "([^"]+)",[\s\S]*?"category": "([^"]+)"', re.MULTILINE)
matches = word_category_pattern.findall(content)

# 收集所有代词
pronouns = []
for word, category in matches:
    if category == 'pronoun':
        pronouns.append(word)

# 检查重复
seen = set()
duplicates = set()

for pronoun in pronouns:
    if pronoun in seen:
        duplicates.add(pronoun)
    else:
        seen.add(pronoun)

# 输出结果
print(f"Total pronouns: {len(pronouns)}")
print(f"Unique pronouns: {len(seen)}")
if duplicates:
    print(f"Duplicate pronouns: {sorted(duplicates)}")
else:
    print("No duplicate pronouns found.")
