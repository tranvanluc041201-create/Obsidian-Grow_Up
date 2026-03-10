---
title: "14）自引用结构体与 Node 结点"
type: 编程学习笔记
language: C
module: 内存地址
created: 2026-03-10
review_after: 2026-03-11
tags:
  - 编程
  - C语言
  - 结构体
  - 链表
  - 学习笔记
source: AI 陪学整理
---

# 14）自引用结构体与 Node 结点

## 🎯 一句话结论

> `next` 里放的是“下一个结点的地址”，不是“下一个结点本体”。

## 📌 这节只解决什么

- 什么是“结点（Node）”
- 为什么能写 `struct Node *next`
- 为什么不能写 `struct Node next`

## ✅ 最小正确写法

```c
struct Node {
    int data;
    struct Node *next;
};
```

## 🔁 代码桥

- `Node` / 结点
  - 可以先理解成“链表里的一个小格子”
  - 这个小格子里通常放两类东西：
    - 自己的数据
    - 指向下一个结点的地址
- `int data`
  - 这里放当前结点自己的数据
  - `int` 只是最常见写法，不是固定死的
- `struct Node *next`
  - `next` 里放“下一个结点地址”
  - 最后一个结点后面没有了，通常写 `NULL`

## ⚠️ 易混点

| A | B | 怎么区分 |
|---|---|---|
| `struct Node *next` | `struct Node next` | 前者只放地址，可以；后者要把完整结点塞进去，会无限套 |
| `a.next = &b;` | `a.next = b;` | `next` 要的是地址，所以要写 `&b` |
| `.` | `->` | 变量本体用 `.`；结构体指针用 `->` |

## 💥 高频坑

- 把 `next` 当成“下一个结点本体”
- 忘了 C 区分大小写：`Node` 和 `node` 不是一回事
- 结构体定义末尾漏分号：`};`

## 一个最小串起来的例子

```c
struct Node {
    int data;
    struct Node *next;
};

struct Node a = {10, NULL};
struct Node b = {20, NULL};

a.next = &b;
```

现在的意思是：

- `a` 这个结点里存着 `10`
- `a.next` 指向 `b`
- `b` 是后一个结点
- `b.next = NULL` 表示到头了

## 🧪 自测

- [ ] 我能说出“结点”是什么
- [ ] 我能解释为什么 `struct Node *next` 可以写
- [ ] 我能解释为什么 `struct Node next` 不可以

## 🔗 关联

- [[10_编程/笔记/cs50-week4-memory-notes/13-struct-value-copy]]
- [[10_编程/思维导图/NCRE-结构体联合typedef与链表记忆图]]
- [[10_编程/思维导图/NCRE-跨图串联记忆图]]
