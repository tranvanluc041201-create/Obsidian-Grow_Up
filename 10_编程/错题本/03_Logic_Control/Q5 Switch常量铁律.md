---
title: "Q5 Switch常量铁律"
difficulty: L2
frequency: 首次
repeated: false
is_hard: false
last_review: 2026-02-19
next_review: 2026-02-20
tags: [逻辑控制, switch, case, 常量表达式]
related_note: ""
type: 编程错题
language: C
module: 逻辑控制
created: 2026-02-19
---
# Q5 Switch常量铁律

## 🎯 题目 / 场景

switch case中使用变量表达式：

```c
int x = 5;
switch(x) {
    case x > 2: printf("Big"); break;    // ❌ 错误！
    case x < 2: printf("Small"); break;  // ❌ 错误！
}
```

**结果**：编译报错

---

## 💥 发生了什么

**错误**：case后面必须跟**整型常量表达式**，不能包含变量。

`x > 2` 包含变量x，编译器在编译时无法确定其值。

---

## 🤔 我当时怎么想的

> "switch应该像if-else一样智能..."
> "case后面可以放条件表达式..."
> **盲区**：不知道case标签必须是编译期常量。

---

## 🔍 根因分析

### case标签规则

| 合法 | 不合法 |
|------|--------|
| `case 1:` | `case x:`（变量） |
| `case 'A':` | `case x > 2:`（含变量表达式） |
| `case 1+2:`（常量表达式） | `case func():`（函数调用） |

### 为什么？
switch-case编译时生成**跳转表**，case值必须是常量。

---

## ✅ 正确规则与修正

```c
// ❌ 错误用法
switch(x) {
    case x > 2: ...  // 编译错误！
}

// ✅ 正确：用if-else
if (x > 2) {
    printf("Big");
} else if (x < 2) {
    printf("Small");
}

// ✅ 正确：switch用于离散值
switch(x) {
    case 1: ...
    case 2: ...
    case 5: printf("Five"); break;
}
```

---

### 怎么自检

- [ ] 我能解释每一处修改的原因
- [ ] 我能手写出最小正确版本
- [ ] 我能说出同类题的触发信号

## 🔁 一题多变 / 横向关联（视情况补充）

### 同类变式
- 把 `case` 标签改成变量表达式，判断为什么会报错
- 同类题链接：[[10_编程/错题本/03_Logic_Control/3.2 Switch Case逻辑或写法]]

### 横向关联
- 对应笔记：[[10_编程/笔记/cs50-week4-memory-notes/01-overview-map]]
- 相近错题：[[10_编程/错题本/03_Logic_Control/3.2 Switch Case逻辑或写法]]

## 🔔 复习提醒

- [ ] 立即复盘（理解正确做法） 📅 2026-02-19
- [ ] 快速回顾（遮住答案，能否说出坑点） 📅 2026-02-20
- [ ] 考前速览（只看思维盲区） 📅 2026-03-06

---

## 📊 复习记录

| 日期 | 操作 | 掌握度 | 备注 |
|------|------|--------|------|
| 2026-02-19 | 录入 | ⭐⭐⭐ | L2较简单，已掌握 |




