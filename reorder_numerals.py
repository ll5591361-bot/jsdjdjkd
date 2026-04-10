import json
import re

# 读取文件
with open('words-data.json', 'r', encoding='utf-8') as f:
    content = f.read()

# 解析JSON
data = json.loads(content)
words = data['words']

# 分离数词和其他单词
numerals = []
others = []

for word in words:
    if word.get('pos') == 'numeral':
        numerals.append(word)
    else:
        others.append(word)

print(f"找到 {len(numerals)} 个数词")
print(f"其他单词: {len(others)} 个")

# 定义数词顺序
numeral_order = [
    # 基数词 0-19
    'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine',
    'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen',
    'seventeen', 'eighteen', 'nineteen',
    # 整十基数词
    'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety',
    # 大数
    'hundred', 'thousand', 'million',
    # 序数词
    'first', 'second', 'third', 'fourth', 'fifth', 'sixth', 'seventh', 'eighth', 'ninth', 'tenth',
    # 其他数量词
    'half', 'quarter', 'double', 'triple', 'dozen', 'single', 'pair', 'couple', 'several', 'both'
]

# 创建数词字典
numeral_dict = {n['word']: n for n in numerals}

# 按顺序排列数词
sorted_numerals = []
for word_name in numeral_order:
    if word_name in numeral_dict:
        sorted_numerals.append(numeral_dict[word_name])
        print(f"添加: {word_name}")
    else:
        print(f"警告: 未找到 {word_name}")

print(f"\n排序后数词数量: {len(sorted_numerals)}")

# 找到插入位置（在interjection之后，preposition之前）
insert_index = 0
for i, word in enumerate(others):
    if word.get('pos') == 'interjection':
        insert_index = i + 1

print(f"插入位置: {insert_index}")

# 合并列表
new_words = others[:insert_index] + sorted_numerals + others[insert_index:]

print(f"新单词总数: {len(new_words)}")

# 保存回文件
data['words'] = new_words
with open('words-data.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=4)

print("\n完成！数词已按数字顺序重新排列。")
