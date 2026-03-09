---
difficulty: L3
frequency: 首次
repeated: false
is_hard: true
last_review: 2026-02-19
next_review: 2026-02-20
tags:
  - 内存指针
  - malloc
  - 字符串
  - 效率
  - NULL检查
cs50_link: "[[10_编程/笔记/cs50-week4-memory-notes/05-malloc-free]]"
---

## 🎯 Problem（问题）

实现字符串复制函数时的多个漏洞：

```c
char *my_strdup(const char *s)
{
    char *c;
    int i;
    c = malloc(strlen(s) + 1);  // ❌ 没有检查 NULL
    
    for(i=0; i<strlen(s); i++)  // ❌ 每次循环都重新计算 strlen
    {  
        c[i]=s[i];
    }
    c[i]='\0';
    return c;  // ❌ 如果 malloc 失败，返回的是 NULL
}
```

---

## 💥 发生了什么

### 漏洞1：未检查malloc返回值
- **危险**：如果内存不足，`malloc`返回`NULL`
- **后果**：`c[i]=s[i]`试图向地址0写入 → **段错误**

### 漏洞2：循环中重复计算strlen
- **问题**：`strlen(s)`每次循环都遍历字符串
- **后果**：时间复杂度从O(n)变成**O(n²)**

### 漏洞3：调用者无法知道失败
- **问题**：如果`malloc`失败，函数返回`NULL`
- **后果**：调用者如果没检查，继续使用返回值 → 崩溃

---

## 🤔 当时我是怎么想的

> "malloc肯定会成功，没必要检查..."
> "strlen很快，调用几次没关系..."
> 
> **盲区**：
> - 不知道内存可能耗尽（嵌入式/大规模程序常见）
> - 不知道`strlen`是O(n)操作，重复调用代价高
> - 没有养成"不信任任何资源分配"的防御式思维

---

## 🔍 Analysis（分析）

### 表面原因
> 未检查malloc返回值 + 循环中低效计算

### 深层原理

**malloc的本质**：
- 向操作系统申请内存
- 操作系统可能拒绝（内存不足/碎片化）
- **必须**检查返回值

**strlen的本质**：
- 遍历字符串直到找到`\0`
- 时间复杂度O(n)
- 如果字符串很长，重复调用代价很高

### 模式识别
> **malloc三步走**：> 1. 分配内存
> 2. **立即**检查NULL
> 3. 使用后再free
> 
> **strlen使用原则**：需要多次使用时，先存到变量里。

---

## ✅ Refix（修正）

```c
// ✅ 标准安全写法
char *my_strdup(const char *s) {
    // 防御：检查输入
    if (s == NULL) return NULL;
    
    // 步骤1：分配内存
    size_t len = strlen(s);  // ✅ 只算一次
    char *c = malloc(len + 1);
    
    // 步骤2：立即检查NULL
    if (c == NULL) {
        return NULL;  // 让调用者知道出错了
    }
    
    // 步骤3：复制字符串（使用标准库更高效）
    strcpy(c, s);  // 或 memcpy(c, s, len + 1)
    
    return c;
}

// ✅ 调用者的责任
char *copy = my_strdup(original);
if (copy == NULL) {
    printf("内存分配失败！\n");
    // 处理错误...
} else {
    // 安全使用copy
    printf("复制结果：%s\n", copy);
    free(copy);  // 别忘了free！
}
```

---

## 💡 Insight（高阶认知）

### 同类变式
- **其他需要检查的资源分配**
  ```c
  FILE *fp = fopen("file.txt", "r");
  if (fp == NULL) { /* 处理错误 */ }
  
  int *arr = calloc(n, sizeof(int));
  if (arr == NULL) { /* 处理错误 */ }
  ```

- **更多优化技巧**
  ```c
  // 更高效的内存复制
  memcpy(c, s, len + 1);  // 比循环更快（硬件优化）
  
  // 或者直接用标准库
  #include <string.h>
  char *copy = strdup(s);  // POSIX标准，自动处理（但别忘了free！）
  ```

### 横向链接
- **CS50笔记**：[[10_编程/笔记/cs50-week4-memory-notes/05-malloc-free]]（malloc/free详解）
- **CS50笔记**：[[10_编程/笔记/cs50-week4-memory-notes/04-strings]]（字符串操作）
- **CS50笔记**：[[10_编程/笔记/cs50-week4-memory-notes/07-valgrind]]（内存泄漏检测）
- **关联错题**：[[2.4] 空指针解引用]（NULL检查的重要性）

### 工程启示
> **防御式编程3原则**：> 1. **不信任输入**：检查所有指针参数是否为NULL
> 2. **不信任资源分配**：检查malloc/fopen等返回值
> 3. **不信任调用者**：函数文档明确说明返回值可能为NULL
> 
> **性能优化原则**：
> - 避免在循环中调用复杂函数
> - 使用标准库（通常比手写循环更高效）
> - 优先考虑算法复杂度，再考虑微优化

---

## 🔔 复习提醒

- [ ] 立即复盘（理解正确做法） (@2026-02-19)
- [ ] 快速回顾（遮住答案，能否说出坑点） (@2026-02-20)
- [ ] 代码复现（手写安全版本） (@2026-02-22)
- [ ] 变式测试（其他资源分配场景） (@2026-02-26)
- [ ] 考前速览（只看思维盲区） (@2026-03-06)

---

## 📊 复习记录

| 日期 | 操作 | 掌握度 | 备注 |
|------|------|--------|------|
| 2026-02-19 | 录入 | ⭐⭐☆ | 首次记录，理解了malloc三步走 |
| 2026-02-20 | 复习 | - | 待复习 |

---

## 🎯 关键记忆点

| 要点 | 口诀/公式 |
|------|----------|
| **malloc后** | **立即**检查NULL |
| **strlen复杂度** | O(n)，别在循环里调用 |
| **字符串复制** | 用strcpy/memcpy，别手写循环 |
| **调用者责任** | 收到指针先检查NULL |
| **malloc三步走** | 分配→检查→使用→free |
