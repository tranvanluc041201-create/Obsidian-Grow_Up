---
title: "8）File I/O：fopen 模式（\"r\"/\"w\"/\"a\"）"
type: 编程学习笔记
language: C
module: 输入输出
created: 2026-03-07
review_after: 2026-03-08
tags:
  - 编程
  - C语言
  - CS50
  - 学习笔记
source: CS50 / 恢复整理
---

# 8）File I/O：fopen 模式（"r"/"w"/"a"）

## 🎯 一句话结论

> `r / w / a` 不要混：`r` 要求文件先存在，`w` 会清空，`a` 会追加。

## 📌 这节课到底在解决什么

- 解决“文件怎么打开”和“为什么同样是写文件，结果却不一样”
- 先能判断该用 `r`、`w` 还是 `a`

## 🤔 核心概念

### 文件读写主线

1. `fopen` 打开文件
2. 读写函数处理内容
3. `fclose` 关闭文件

### 最小模板

```c
FILE *fp = fopen("data.txt", "r");
if (fp == NULL) return 1;

/* 读或写 */

fclose(fp);
```

## ✅ 正确做法

### "r"：只读

- 文件必须先存在
- 打不开返回 `NULL`

### "w"：覆盖写

- 文件不存在会新建
- 文件已存在会先清空

### "a"：追加写

- 文件不存在会新建
- 文件已存在会从末尾继续写

### 两次运行效果

```text
mode="w" -> 第二次写会覆盖第一次
mode="a" -> 第二次写会接在第一次后面
```

## ⚠️ 常见坑

- `if (fp = NULL)` 写成赋值
- 想追加却写成 `"w"`
- 想读文件却忘了判 `NULL`
- 以为 `"w"` 一定错，其实它适合“重建快照”

## 🔍 高阶视角（视情况补充）

- 如果以后做小项目，`"w"` 常配合临时文件一起用，避免写坏原文件
- 项目实践清单与长模板代码已移到：[[10_编程/笔记/cs50-week4-memory-notes/11-file-io-practice-archive]]

## 🧠 我的卡点

- 我能否一眼判断该用 `r / w / a`
- 我会不会把 `==` 写成 `=`

## 🔁 24小时复习

- 我能否手写 `fopen + 判 NULL + fclose` 的共同骨架
- 我能否说出 `r / w / a` 的区别

## 🔗 关联

- [[10_编程/笔记/cs50-week4-memory-notes/09-file-functions]]
- [[10_编程/笔记/cs50-week4-memory-notes/10-file-functions-code-bridge]]
- [[10_编程/笔记/cs50-week4-memory-notes/11-file-io-practice-archive]]
