---
title: "5）malloc / free：堆内存与生命周期"
type: 编程学习笔记
language: C
module: 内存地址
created: 2026-03-07
review_after: 2026-03-11
tags:
  - 编程
  - C语言
  - malloc
  - free
  - 学习笔记
source: CS50 / AI 陪学整理
---

# 5）malloc / free：堆内存与生命周期

## 🎯 一句话结论

> `malloc` 申请的是堆内存；用完必须 `free`，而且 `free` 后原指针不会自动变成 `NULL`。

## 📌 这节只解决什么

- 什么时候该用 `malloc`
- 为什么 `malloc` 后要判 `NULL`
- 为什么 `free` 后还要小心悬空指针

## ✅ 最小正确写法

```c
int *a = malloc(3 * sizeof(int));
if (a == NULL) return 1;

a[0] = 1;

free(a);
a = NULL;
```

## 🔁 代码桥

- `malloc(n)`
  - 向堆申请 `n` 字节
- `malloc(3 * sizeof(int))`
  - 不是“申请 3 个格子”
  - 本质是申请 `3 个 int 所需的总字节数`
- `free(a)`
  - 释放的是 `a` 指向的那块堆内存
  - 不是把变量 `a` 删除

## ⚠️ 易混点

| A | B | 怎么区分 |
|---|---|---|
| 栈变量 | `malloc` 得到的内存 | 前者自动结束；后者要手动 `free` |
| `a = NULL` | `free(a)` | 前者只是改指针值；后者才是真释放内存 |
| 内存泄漏 | 悬空指针 | 前者忘了释放；后者释放后还在用旧地址 |

## 💥 高频坑

- `malloc` 后不判 `NULL`
- `free` 后继续 `*a` 或 `a[0]`
- 只写 `a = NULL`，却没真正 `free`

## 🧪 自测

- [ ] 我能解释 `malloc(3 * sizeof(int))` 在申请什么
- [ ] 我能说出为什么 `free` 后最好置 `NULL`
- [ ] 我能区分“泄漏”和“释放后继续用”

## 🔗 关联

- [[10_编程/笔记/cs50-week4-memory-notes/02-memory-model]]
- [[10_编程/笔记/cs50-week4-memory-notes/06-oob-overflow]]
- [[10_编程/笔记/cs50-week4-memory-notes/07-valgrind]]
