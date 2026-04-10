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

# 输出结果
print(f"Actual number of pronouns in wordsData: {len(pronouns)}")
