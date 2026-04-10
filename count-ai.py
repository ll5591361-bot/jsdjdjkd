import json

with open(r'f:\Users\Administrator\AndroidStudioProjects\english-app-panel\ai-words.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

print(f'实际单词数量: {len(data["aiWords"])}')
print(f'记录的数量: {data["stats"]["totalAiWords"]}')
