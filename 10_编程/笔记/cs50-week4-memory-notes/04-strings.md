---
title: "4）字符串：char 数组、\\0、strcmp"
type: 编程学习笔记
language: C
module: 内存地址
created: 2026-03-07
review_after: 2026-03-11
tags:
  - 编程
  - C语言
  - 字符串
  - 学习笔记
source: CS50 / AI 陪学整理
---

# 4）字符串：char 数组、\0、strcmp

## 🎯 一句话结论

> C 字符串本质是以 `'\0'` 结尾的 `char` 数组；比较内容要用 `strcmp`，不是 `==`。

## 📌 这节只解决什么

- 什么才算 C 字符串
- 为什么字符串比较不能直接用 `==`
- `strlen` 为什么不算 `'\0'`

## ✅ 最小正确写法

```c
char s[] = "abc";

printf("%zu\n", strlen(s)); // 3

if (strcmp(s, "abc") == 0) {
    printf("same\n");
}
```

## 🔁 代码桥

- `"abc"`
  - 内存里其实是 `a b c \0`
- `strlen(s)`
  - 统计的是字符个数
  - 不算结尾的 `'\0'`
- `strcmp(a, b)`
  - 比较内容
  - 返回 `0` 才表示一样

## ⚠️ 易混点

| A | B | 怎么区分 |
|---|---|---|
| `sizeof(s)` | `strlen(s)` | 前者看总字节数；后者看字符串长度，不含 `'\0'` |
| `==` | `strcmp` | 前者常比较地址；后者比较内容 |
| `NULL` | `'\0'` | 前者是空指针；后者是字符串结束符 |

## 💥 高频坑

- 把 `==` 当成字符串内容比较
- 忘了字符串末尾有 `'\0'`
- 数组空间只按字符数开，没给 `'\0'` 留位

## 🧪 自测

- [ ] 我能说出 `"abc"` 在内存里有几个字符单元
- [ ] 我能解释 `sizeof` 和 `strlen` 的区别
- [ ] 我能写出正确的字符串内容比较

## 🔗 关联

- [[10_编程/笔记/cs50-week4-memory-notes/03-pointers-null]]
- [[10_编程/笔记/cs50-week4-memory-notes/15-sizeof-special]]
- [[10_编程/错题本/02_Memory_Address/2.5 字符串初始化越界]]
