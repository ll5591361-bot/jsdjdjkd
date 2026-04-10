# 读取 script.js 文件
with open('script.js', 'r', encoding='utf-8') as f:
    lines = f.readlines()

# 找到分类2的最后一个单词
last_cat2_line = -1
current_word = ""

for i, line in enumerate(lines):
    if '"category": "cat2"' in line:
        # 向上查找单词
        for j in range(i-10, i):
            if '"word": "' in lines[j]:
                current_word = lines[j].split('"word": "')[1].split('"')[0]
                last_cat2_line = i
                break

print(f"Last cat2 word: {current_word}")
print(f"Last cat2 line: {last_cat2_line}")

# 打印上下文
if last_cat2_line != -1:
    start = max(0, last_cat2_line - 10)
    end = min(len(lines), last_cat2_line + 20)
    print("\nContext:")
    for i in range(start, end):
        print(f"{i+1}: {lines[i].rstrip()}")
