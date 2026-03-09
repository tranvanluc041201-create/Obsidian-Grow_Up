---
difficulty: L3
frequency: 首次
repeated: false
is_hard: true
last_review: 2026-02-19
next_review: 2026-02-20
tags: [逻辑控制, do-while, continue, 嵌套循环]
cs50_link: ""
---

## 🎯 Problem（问题）

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

## 🤔 当时我是怎么想的

> "continue会跳到while条件检查..."> "do-while会循环多次..."> 
> **盲区**：continue跳到循环条件检查，但!i在i=2,3,4时都为假，所以只执行一次。

---

## 🔍 Analysis（分析）

### continue在do-while中的行为
```c
do {
    if (cond) continue;  // 跳到 while 条件检查
    ...
} while (cond2);  // 检查条件，决定是否再次执行
```

---

## ✅ Refix（修正）

```c
// 逐行跟踪，不要凭直觉
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
| 2026-02-19 | 录入 | ⭐⭐☆ | 首次记录 |
| 2026-02-20 | 复习 | - | 待复习 |
