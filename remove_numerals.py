import json

with open('words-data.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# 过滤掉教育类别中的数词
filtered_words = []
for word in data['words']:
    if word['category'] == 'education' and word['pos'] == 'numeral':
        continue  # 跳过教育类别中的数词
    filtered_words.append(word)

data['words'] = filtered_words

with open('words-data.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

print(f'Remaining words: {len(filtered_words)}')
