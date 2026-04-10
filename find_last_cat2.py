import re

# 读取 script.js 文件
with open('script.js', 'r', encoding='utf-8') as f:
    content = f.read()

# 找到所有分类2的条目
matches = re.findall('"category": "cat2"', content)
print(f'Found {len(matches)} cat2 entries')

# 找到最后一个分类2的位置
last_match = content.rfind('"category": "cat2"')
print(f'Last cat2 at position: {last_match}')

# 打印上下文
context = content[last_match-100:last_match+500]
print(context)
