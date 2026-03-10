---
title: NCRE-结构体联合typedef与链表记忆图
mindmap-plugin: basic
type: 编程学习笔记
language: C
exam: NCRE二级C
created: 2026-03-09
tags:
  - 编程
  - C语言
  - NCRE
  - 思维导图
  - Markmind
  - 结构体
  - 联合
  - typedef
  - 链表
---

# 结构体 / 联合 / typedef / 链表

## 先抓主干
- 看见 struct
    - 多个成员绑成一组
- 看见 union
    - 多个成员共用一块内存
- 看见 typedef
    - 只是起别名
- 看见 链表
    - 结点靠 next 串起来

## 两组核心对比
- . vs ->
    - 结构体变量用 .
    - 结构体指针用 ->
- struct vs union
    - struct 成员各有空间
    - union 成员共用空间
- typedef vs 真定义新类型
    - typedef 主要是定义一种类型+命名
    - 不会多造一份数据

## 候选易混点
- p->n
    - 等价于 (*p).n
    - 先取到结构体，再取成员
- typedef int *P
    - P a, b
    - a 和 b 都是 int*
    - 要讲int*看成整体
- typedef int *T[10]
    - T 是“10个 int* 组成的数组”
    - 不是“指向数组的指针”
- struct Node *next
    - next 里放的是下一个结点地址
    - 能先写指针，是因为指针大小固定
    - 最后一个结点的 next 常是 NULL
- 插入结点
    - 这是“中间插入”的写法
    - new->next 先接后面
    - pre->next 再接新结点
- 删除结点
    - 这是“中间删除”的写法
    - pre->next 先接 cur->next
    - 再删当前结点
    - 如果是动态申请的，最后还要 free(cur)

## 还没学先展开
- 遍历链表
    - p = head
    - 每次走 p = p->next
    - 直到 p == NULL
- 头插
    - new->next = head
    - head = new
- 中间插入
    - new->next = pre->next
    - pre->next = new
- 中间删除
    - pre->next = cur->next
    - free(cur)

## 做题抓手
- 先看这是变量还是指针
- 再看成员该用 . 还是 ->
- 再看 typedef 真正替代了谁
- 最后看 next 有没有断链
