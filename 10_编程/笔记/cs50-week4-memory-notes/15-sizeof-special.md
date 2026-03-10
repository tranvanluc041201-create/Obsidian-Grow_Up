---
title: "15）sizeof、strlen、数组、指针"
type: 编程学习笔记
language: C
module: 内存地址
created: 2026-03-07
review_after: 2026-03-11
tags:
  - 编程
  - C语言
  - sizeof
  - strlen
  - 学习笔记
source: AI 陪学整理
---

# 15）sizeof、strlen、数组、指针

## 🎯 一句话结论

> `sizeof` 看的是类型/对象占多少字节；`strlen` 看的是字符串有多少个字符，不算结尾 `'\0'`。

## 📌 这节只解决什么

- 为什么 `sizeof(arr)` 和 `sizeof(p)` 经常不一样
- 为什么 `strlen` 不算 `'\0'`
- 为什么数组传参后 `sizeof` 容易失真

## ✅ 最小正确写法

```c
char s[] = "abc";
char *p = s;

printf("%zu\n", sizeof(s));  // 4
printf("%zu\n", sizeof(p));  // 8（64 位常见）
printf("%zu\n", strlen(s));  // 3
```

## 🔁 代码桥

- `sizeof(s)`
  - 看整个对象占多少字节
  - `s` 是数组时，看整数组
- `sizeof(p)`
  - `p` 是指针时，只看指针本身大小
- `strlen(s)`
  - 从开头数到 `'\0'` 前为止
  - 不把 `'\0'` 算进去

## ⚠️ 易混点

| A | B | 怎么区分 |
|---|---|---|
| `sizeof(arr)` | `sizeof(*p)` | 前者看整个数组；后者看一个元素的类型大小 |
| `sizeof(s)` | `strlen(s)` | 前者可能把 `'\0'` 也算上；后者不算 |
| 数组本体 | 函数参数里的“数组” | 传参后常退化成指针 |

## 💥 高频坑

- 把 `strlen` 当成“数组总大小”
- 在函数参数里还以为 `sizeof(arr)` 是整个数组大小
- 看见 `sizeof(*p)` 没反应，其实它就是“指向类型的大小”

## 🧪 自测

- [ ] 我能解释为什么 `"abc"` 的 `sizeof` 是 4、`strlen` 是 3
- [ ] 我能解释 `sizeof(*p)` 为什么常等于“一个元素大小”
- [ ] 我能说出数组传参后为什么容易变成指针大小

## 🔗 关联

- [[10_编程/笔记/cs50-week4-memory-notes/03-pointers-null]]
- [[10_编程/笔记/cs50-week4-memory-notes/04-strings]]
- [[10_编程/错题本/02_Memory_Address/2.7 sizeof指针误解]]
