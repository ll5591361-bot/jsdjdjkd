# 读取 script.js 文件
with open('script.js', 'r', encoding='utf-8') as f:
    lines = f.readlines()

# 找到 wordsData 数组的开始和结束行
start_line = -1
end_line = -1
brace_count = 0
in_words_data = False

for i, line in enumerate(lines):
    if 'wordsData = [' in line:
        start_line = i
        in_words_data = True
        brace_count = 1
    elif in_words_data:
        brace_count += line.count('[')
        brace_count -= line.count(']')
        if brace_count == 0:
            end_line = i
            break

if start_line != -1 and end_line != -1:
    words_data_content = ''.join(lines[start_line:end_line+1])
    word_count = words_data_content.count('"word": "')
    print(f"Number of words in wordsData: {word_count}")
else:
    print("Could not find wordsData array.")
