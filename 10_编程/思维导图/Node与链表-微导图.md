---
title: Node 与链表-微导图
mindmap-plugin: basic
type: 编程学习笔记
language: C
created: 2026-03-10
tags:
  - 编程
  - C语言
  - 链表
  - 结构体
  - Markmind
---

# Node 与链表

## 先记一句
- `next` 存的是下一个结点的地址

## 链表是什么
- 一串结点靠地址连起来
- 不是靠连续位置排起来
- 适合插入、删除
- 不适合按下标直接跳

## 一个结点里有什么
- `data`
    - 当前结点自己的数据
- `next`
    - 下一个结点的地址

## 为什么是 `*next`
- 这里只存地址
- 指针大小固定
- 所以编译器能先处理

## 为什么不是 `next`
- 那会把完整结点再塞进结点里
- 会一层套一层
- 结构体大小算不出来

## 到头怎么表示
- `next = NULL`
- 表示后面没有结点了

## 最小写法
- `struct Node { int data; struct Node *next; };`

## 最小连接
- `struct Node a = {10, NULL};`
- `struct Node b = {20, NULL};`
- `a.next = &b;`

## 做题抓手
- 先看 `next` 要的是不是地址
- 再看这里用 `.` 还是 `->`
- 最后看尾结点是不是 `NULL`
