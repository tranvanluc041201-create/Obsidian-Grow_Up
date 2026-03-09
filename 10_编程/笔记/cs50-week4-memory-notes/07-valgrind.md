---
title: "7）Valgrind（读法 + Windows 怎么用）"
type: 编程学习笔记
language: C
module: 内存地址
created: 2026-03-07
review_after: 2026-03-08
tags:
  - 编程
  - C语言
  - CS50
  - 调试工具
source: CS50 / 恢复整理
---

# 7）Valgrind（读法 + Windows 怎么用）

## 🎯 一句话结论

> Valgrind 不负责“告诉你答案”，它负责帮你定位：**哪一行、哪一种内存错误、从哪分配出来的**。

---

## 📌 这节课到底在解决什么

- 主题：如何用工具定位越界、泄漏、未初始化
- 典型场景：程序崩溃、结果奇怪、怀疑 `malloc/free` 用错
- 如果不会，会错在哪里：只盯着报错英文看，不知道先看哪一行

---

## ✅ 三步读 Valgrind

1. 先看错误类型  
   - `Invalid write`：越界写 / 野指针 / 释放后继续写  
   - `Invalid read`：越界读 / 野指针  
   - `definitely lost`：确定泄漏  
   - `uninitialised value`：用了未初始化数据
2. 再看发生行  
   - `at file.c:line`
3. 最后看分配行  
   - `alloc'd by file.c:line`

---

## 🛠 最常用命令

```bash
clang -g -O0 -Wall -Wextra -o prog prog.c
valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./prog
```

### Windows 怎么办
- 首选：WSL2 + Ubuntu
- 替代：Dr. Memory

---

## ⚠️ 最容易错的地方

- 一上来就盯着最下面的总结，不看第一条错误
- 只看 “lost bytes”，不回头找 `malloc` 那行
- 忘了开 `-g`，导致定位不到源码行

---

## 🧠 我的卡点

- 我原来以为：Valgrind 只是“有错 / 没错”的提示器
- 实际上：它最值钱的是“错误类型 + 发生行 + 分配行”这三件事
- 我以后要先检查：第一条错误是什么、发生在哪一行

---

## 🔁 24小时复习

- 我能否说出 `Invalid write` 和 `definitely lost` 的区别：
- 我能否解释为什么要加 `-g`：
- 我能否手动演示一遍看报错顺序：

---

## 🔗 关联

- 相关错题：[[10_编程/错题本/02_Memory_Address/my_strdup实现漏洞]]
- 相关练习：课后自拟 1~2 个最小例子
- 相关笔记：[[10_编程/笔记/cs50-week4-memory-notes/06-oob-overflow]]

