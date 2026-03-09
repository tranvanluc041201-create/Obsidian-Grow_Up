---
title: "Q11 Do-While与Continue"
difficulty: L3
frequency: 首次
repeated: false
is_hard: true
last_review: 2026-02-19
next_review: 2026-02-20
tags: [逻辑控制, do-while, continue, 嵌套循环]
related_note: ""
type: 编程错题
language: C
module: 逻辑控制
created: 2026-02-19
---
# Q11 Do-While与Continue

## 🎯 题目 / 场景

Do-While与Continue的组合：

```c
int i, n=0;
for(i=2; i<5; i++) {
    do {
        if (i%3) continue;  // i%3 != 0时continue
        n++;
    } while(!i);  // !i == 0（假），只执行一次
    n++;
}
// 结果：n=4
```

---

## 💥 发生了什么

**执行过程**：
```
i=2: 2%3=2(真)→continue。!2=0(假)，do-while结束。n++(n=1)
i=3: 3%3=0(假)→n++(n=2)。!3=0(假)，do-while结束。n++(n=3)
i=4: 4%3=1(真)→continue。!4=0(假)，do-while结束。n++(n=4)
```

---

## 🤔 我当时怎么想的

> "continue会跳到while条件检查..."
> "do-while会循环多次..."
> **盲区**：continue跳到循环条件检查，但!i在i=2,3,4时都为假，所以只执行一次。

---

## 🔍 根因分析

### continue在do-while中的行为
```c
do {
    if (cond) continue;  // 跳到 while 条件检查
    ...
} while (cond2);  // 检查条件，决定是否再次执行
```

---

## ✅ 正确规则与修正

```c
// 逐行跟踪，不要凭直觉
```

---

### 怎么自检

- [ ] 我能解释每一处修改的原因
- [ ] 我能手写出最小正确版本
- [ ] 我能说出同类题的触发信号

## 🔁 一题多变 / 横向关联（视情况补充）

### 同类变式
- 把 `continue` 换成 `break`，再判断执行次数和最终输出
- 同类题链接：[[10_编程/错题本/03_Logic_Control/Q9 复杂循环嵌套计数]]

### 横向关联
- 对应笔记：[[10_编程/笔记/cs50-week4-memory-notes/01-overview-map]]
- 相近错题：[[10_编程/错题本/03_Logic_Control/Q9 复杂循环嵌套计数]]

## 🔔 复习提醒

- [ ] 立即复盘（理解正确做法） 📅 2026-02-19
- [ ] 快速回顾（遮住答案，能否说出坑点） 📅 2026-02-20
- [ ] 考前速览（只看思维盲区） 📅 2026-03-06

---

## 📊 复习记录

| 日期 | 操作 | 掌握度 | 备注 |
|------|------|--------|------|
| 2026-02-19 | 录入 | ⭐⭐☆ | 首次记录 |
| 2026-02-20 | 复习 | - | 待复习 |




