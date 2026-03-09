---
difficulty: L2
frequency: 首次
repeated: false
is_hard: false
last_review: 2026-02-19
next_review: 2026-02-20
tags: [逻辑控制, switch, case, 常量表达式]
cs50_link: ""
---

## 🎯 Problem（问题）

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

## 🤔 当时我是怎么想的

> "switch应该像if-else一样智能..."> "case后面可以放条件表达式..."> 
> **盲区**：不知道case标签必须是编译期常量。

---

## 🔍 Analysis（分析）

### case标签规则

| 合法 | 不合法 |
|------|--------|
| `case 1:` | `case x:`（变量） |
| `case 'A':` | `case x > 2:`（含变量表达式） |
| `case 1+2:`（常量表达式） | `case func():`（函数调用） |

### 为什么？
switch-case编译时生成**跳转表**，case值必须是常量。

---

## ✅ Refix（修正）

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

## 🔔 复习提醒

- [ ] 立即复盘（理解正确做法） (@2026-02-19)
- [ ] 快速回顾（遮住答案，能否说出坑点） (@2026-02-20)
- [ ] 考前速览（只看思维盲区） (@2026-03-06)

---

## 📊 复习记录

| 日期 | 操作 | 掌握度 | 备注 |
|------|------|--------|------|
| 2026-02-19 | 录入 | ⭐⭐⭐ | L2较简单，已掌握 |
