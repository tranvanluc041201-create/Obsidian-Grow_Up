---
title: "结构体赋值与传参：成员复制、指针字段与值传递"
type: 编程学习笔记
language: C
module: 内存地址
created: 2026-03-07
review_after: 2026-03-08
tags:
  - 编程
  - C语言
  - CS50
  - 学习笔记
source: CS50 / 恢复整理
---

# 结构体赋值与传参：成员复制、指针字段与值传递

*理解结构体赋值、传参、返回值的内存行为*

---

# 🎯 一句话结论

**结构体赋值是成员逐个复制**：`s2 = s1` 会把 `s1` 的每个字段值复制给 `s2`。如果字段里有普通成员，它们彼此独立；如果字段里有指针，只会复制指针值，不会自动复制指针指向的数据。

---

## 💥 问题场景

### 场景 1：误以为是指针拷贝

**错误的理解**：
> "`s2 = s1` 后，修改 `s2` 会影响 `s1`，因为是浅拷贝"

**实际代码**：
```c
typedef struct {
    int x;
    int y;
} Point;

Point a = {10, 20};
Point b = a;    // 值拷贝！b是a的完整副本
b.x = 99;       // 只改b，不影响a

printf("a.x = %d\n", a.x);  // 输出：a.x = 10 ✅
printf("b.x = %d\n", b.x);  // 输出：b.x = 99
```

**关键认知**：
- ❌ 不是指针赋值（不共享内存）
- ✅ 是完整复制（两个独立变量）

---

### 场景 2：嵌套结构体的拷贝

```c
typedef struct {
    int id;
    Point position;  // 嵌套结构体
} Entity;

Entity e1 = {1, {10, 20}};
Entity e2 = e1;  // 递归值拷贝！

e2.position.x = 99;
printf("e1.position.x = %d\n", e1.position.x);  // 输出：10 ✅
```

**结论**：嵌套结构体也会递归拷贝，每一层都是独立的。

---

### 场景 3：含指针字段的结构体（真正的浅拷贝问题）

```c
typedef struct {
    int id;
    char *name;  // 指针字段！
} Person;

Person p1;
p1.id = 1;
p1.name = malloc(20);
strcpy(p1.name, "Alice");

Person p2 = p1;  // 值拷贝，但name指针被复制了！

// 现在 p1.name 和 p2.name 指向同一块内存！
strcpy(p2.name, "Bob");
printf("p1.name = %s\n", p1.name);  // 输出：Bob 😱

free(p1.name);   // p2.name 变成野指针！
// 如果再用 p2.name → 崩溃
```

**这里的问题不是“结构体不会拷贝”，而是“指针字段只复制地址”**。

---

## 🤔 为什么（通俗理解）

### 内存视角

```c
Point a = {10, 20};   // 内存：a → [10][20]
Point b = a;          // 内存：b → [10][20] （独立的副本）
```

**类比**：
- `a` 是一本笔记本，写着 "x=10, y=20"
- `b = a` 是**手抄了一本新的**，内容一样，但两本独立
- 修改 `b` 那本，不影响 `a` 那本

### 与指针的区别

```c
Point a = {10, 20};
Point *p = &a;     // p 是借书卡，指向 a
Point b = a;         // b 是新买的书，内容复制了 a

*p.x = 99;           // a 变成 {99, 20} （通过指针修改）
b.x = 100;           // a 还是 {99, 20} （b是独立的）
```

---

## ✅ 正确做法

### 基础用法

```c
typedef struct {
    int x;
    int y;
} Point;

// 定义和初始化
Point p1 = {10, 20};

// 值拷贝
Point p2 = p1;

// 修改不影响原变量
p2.x = 99;  // p1 还是 {10, 20}
```

### 函数传参（值传递）

```c
void move(Point p, int dx, int dy) {
    p.x += dx;  // 修改的是副本！
    p.y += dy;
}

Point p = {0, 0};
move(p, 10, 20);
printf("p = {%d, %d}\n", p.x, p.y);  // 输出：{0, 0}（没变！）
```

**如果需要修改原变量，用指针**：
```c
void move(Point *p, int dx, int dy) {
    p->x += dx;  // 通过指针修改原变量
    p->y += dy;
}

Point p = {0, 0};
move(&p, 10, 20);
printf("p = {%d, %d}\n", p.x, p.y);  // 输出：{10, 20} ✅
```

### 函数返回值（值返回）

```c
Point create_point(int x, int y) {
    Point p = {x, y};
    return p;  // 返回值的拷贝
}

Point p1 = create_point(10, 20);  // p1 是返回值的副本
```

---

## 🔍 高阶视角

### 内存布局对比

```c
// 结构体值
Point a = {10, 20};   // 栈上：8字节（假设int4字节）
Point b = a;          // 栈上：另外8字节

// 结构体指针
Point a = {10, 20};   // 栈上：8字节
Point *p = &a;         // 栈上：8字节（64位指针）
Point *q = p;         // 栈上：8字节（和p指向同一块内存）
```

### 什么时候需要深拷贝？

**当结构体包含指针，且指针指向动态内存时**：

```c
typedef struct {
    char *name;      // 指针！
    int *scores;     // 指针！
} Student;

// 深拷贝函数
Student student_deep_copy(Student *src) {
    Student dst;
    
    // 为name分配新内存并复制
    dst.name = malloc(strlen(src->name) + 1);
    strcpy(dst.name, src->name);
    
    // 为scores分配新内存并复制
    dst.scores = malloc(sizeof(int) * 5);
    memcpy(dst.scores, src->scores, sizeof(int) * 5);
    
    return dst;
}
```

---

## 📝 你的理解笔记区
- 
- 

---

## 🔁 24小时复习

- 我能否用自己的话说出这节的核心规则：
- 我能否手写一个最小示例：
- 我能否说出最容易错的一点：

## 🔗 关联知识点
- → [指针基础](10_编程/笔记/cs50-week4-memory-notes/03-pointers-null.md) - 理解指针 vs 值的区别
- → [malloc/free](10_编程/笔记/cs50-week4-memory-notes/05-malloc-free.md) - 动态内存管理
- → [字符串](10_编程/笔记/cs50-week4-memory-notes/04-strings.md) - 字符指针的特殊性

---

## 🏷️ 标签
#结构体 #值拷贝 #深拷贝 #指针 #CS50 #二级考点

---

## 考试要点 ⭐

**二级C语言常考**：
1. 结构体赋值的本质是值拷贝 ✅
2. 函数参数默认是值传递（传副本）
3. 需要通过指针才能修改原结构体
4. 结构体指针用 `->` 访问成员

**常见陷阱**：
```c
void swap(Point a, Point b) {  // ❌ 错误：交换的是副本
    Point tmp = a;
    a = b;
    b = tmp;
}

void swap(Point *a, Point *b) {  // ✅ 正确：通过指针修改原变量
    Point tmp = *a;
    *a = *b;
    *b = tmp;
}
```



