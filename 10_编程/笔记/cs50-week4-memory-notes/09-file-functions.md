---
title: "9）文件函数：先分家族，再背格式"
type: 编程学习笔记
language: C
module: 输入输出
created: 2026-03-07
review_after: 2026-03-11
tags:
  - 编程
  - C语言
  - 文件函数
  - 学习笔记
source: AI 陪学整理
---

# 9）文件函数：先分家族，再背格式

## 🎯 一句话结论

> 文件函数先别一股脑硬背，先分三家：按格式、按字符串、按数据块。

## 📌 这节只解决什么

- 题目一来，先该想哪一类函数
- 为什么 `fp` 有时在最前，有时在最后
- `fread / fwrite` 为什么最容易记混

## ✅ 最小正确写法

```c
fprintf(fp, "%s,%s\n", name, number);
fgets(line, sizeof(line), fp);
fwrite(a, sizeof(int), 4, fp);
```

## 🔁 代码桥

### 先看“按格式”

- `fprintf / fscanf`
- 特征：`fp` 在最前

### 再看“按字符串”

- `fgets / fputs`
- 特征：`fp` 在最后

### 最后看“按数据块”

- `fread / fwrite`
- 固定顺序：`ptr, size, count, fp`

## ⚠️ 易混点

### `fprintf / fscanf` vs `fgets / fputs`

- 前者：按格式
- 后者：按字符串
- 一句话区分：看到格式串 `%d %s`，优先想前者

### `fread / fwrite` 的返回值

- 返回的是“读/写了多少块”
- 不是“多少字节”
- 一句话区分：`count` 写的是块数，返回值也看块数

## 💥 高频坑

- `fprintf / fscanf` 忘了 `fp` 在最前
- `fgets / fputs` 忘了 `fp` 在最后
- `fgetc` 和 `fgets` 粗心混掉
- `fread / fwrite` 参数顺序写错

## 🧪 自测

- [ ] 我能把三大家族分清
- [ ] 我能说出 `fgets` 的三个参数分别是什么
- [ ] 我能解释 `fread` 为什么要写 `size` 和 `count`

## 🔗 关联

- [[10_编程/笔记/cs50-week4-memory-notes/08-file-io-fopen]]
- [[10_编程/笔记/cs50-week4-memory-notes/10-file-functions-code-bridge]]
- [[10_编程/笔记/cs50-week4-memory-notes/11-file-io-practice-archive]]
