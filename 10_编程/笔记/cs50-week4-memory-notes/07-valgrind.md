---
title: "7）Valgrind：先看哪一行"
type: 编程学习笔记
language: C
module: 内存地址
created: 2026-03-07
review_after: 2026-03-11
tags:
  - 编程
  - C语言
  - 调试工具
  - 学习笔记
source: AI 陪学整理
---

# 7）Valgrind：先看哪一行

## 🎯 一句话结论

> Valgrind 最值钱的不是“报错”两个字，而是：错在哪一类、发生在哪一行、源头从哪分配。

## 📌 这节只解决什么

- 报告到底该按什么顺序读
- `Invalid write`、`definitely lost` 这类词分别在说什么
- Windows 上怎么处理这个工具

## ✅ 最小使用法

```bash
clang -g -O0 -Wall -Wextra -o prog prog.c
valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./prog
```

## 🔁 代码桥

### 第一步：先看错误类型

- `Invalid write`
- `Invalid read`
- `definitely lost`
- `uninitialised value`

### 第二步：再看发生行

- 找 `at file.c:line`

### 第三步：最后看源头

- 找 `alloc'd by file.c:line`
- 这常能把你带回真正的 `malloc` 起点

## ⚠️ 易混点

### “第一条错误” vs “最后总结”

- 前者：通常更接近根因
- 后者：只是汇总
- 一句话区分：先抓第一条，再看总账

## 💥 高频坑

- 只盯着最下面的 leak 汇总
- 忘了开 `-g`
- 看见英文就慌，没先抓“类型 → 行号 → 源头”这三步

## 🧪 自测

- [ ] 我能说出读 Valgrind 的三步顺序
- [ ] 我能区分 `Invalid write` 和 `definitely lost`
- [ ] 我能解释为什么 `-g` 很重要

## 🔗 关联

- [[10_编程/笔记/cs50-week4-memory-notes/05-malloc-free]]
- [[10_编程/笔记/cs50-week4-memory-notes/06-oob-overflow]]
- [[10_编程/错题本/02_Memory_Address/my_strdup实现漏洞]]
