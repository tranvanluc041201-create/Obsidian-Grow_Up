---
title: "5）malloc/free（堆：动态内存）"
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

# 5）malloc/free（堆：动态内存）



### 5.1 结论（新手必背）

* `malloc`：向堆申请一块连续内存，失败返回 `NULL`
	  形式malloc(12)=malloc(3*int)；
	  其中12为字节数,遇到各种类型自动转化为对应的字节数
* 用完 `free`：否则泄漏
* `free` 后继续用：use-after-free（更难查）

  **核心原理：** 内存生命周期管理失误。 在 C 语言的内存模型（Heap Layout）中，`free(a)` 的本质是将 `a` 指向的那块物理内存标记为 "可回收"（Available），归还给操作系统的分配器（Allocator）。

	**致命点：** `free(a)` **不会** 自动把指针变量 `a` 清零（置为 NULL）。`a` 仍然保留着那个地址（即“悬空指针” Dangling Pointer）。如果你继续使用 `*a` 或 `a[0]`，就是 UAF。

	**机械类比 (Mechanical Analogy)：**

	- **malloc：** 你向仓库租了一个储物柜（Memory），管理员给你一把钥匙（Pointer）。
    
	- **free：** 你退租了，告诉管理员“这柜子我不用了”。
    
	- **UAF：** 你手里还私藏了那把钥匙。
    
    - **情况 A（数据踩踏）：** 管理员已经把柜子租给了别人放精密仪器。你拿着旧钥匙打开柜子，往里面扔了一把锤子（Write），别人的仪器被砸烂了（数据损坏，极其难查）。
        
    - **情况 B（崩溃）：** 仓库管理员换了锁，你强行插钥匙，钥匙断了（Segmentation Fault，程序崩溃）。
        

	**C/C++ vs Python:**

	- **Python:** 有垃圾回收（GC）。当没人在用柜子时，GC 会自动收走钥匙并销毁柜子。你根本没机会犯 UAF。
    
	- **C/C++:** 手动挡赛车。你必须自己记着：退租后，立马把钥匙熔了（`a = NULL;`）。
---


### 5.2 最小正确模板（直接抄）

```c
int *a = malloc(n * sizeof(int));
if (a == NULL) return 1;

free(a);
a = NULL; // 新手推荐：防止后续误用（习惯）
```



### 5.3 最常见致命错误

* 忘了 `sizeof`：`malloc(n)` 却按 `n` 个 int 用（分配太小 -> 越界写）
* 忘了判 NULL
* 忘了 free

**我的薄弱点**：我最容易写错的是“申请完内存后忘了判 `NULL`，释放后又忘了把指针置空”

---



### 实践清单：阶段 D（内存中的“数据库”，malloc/free：把结构搭起来）

**目标**
- 把读取到的记录存入内存结构：`Record[]`（动态数组）
- 支持：list / find / del 的内存操作

**数据结构（建议）**

```c
typedef struct {
    char *name;    // 动态分配
    char *number;  // 动态分配
} Record;

typedef struct {
    Record *items; // 动态数组
    size_t size;
    size_t cap;
} DB;
```

**核心训练点**
- malloc 失败返回 NULL：每次分配都必须检查
- 拷贝字符串要留 '\0' 空间（len + 1）

**必做错误（故意触发 1：越界写）**
- malloc(len) 而不是 malloc(len + 1)
- 然后 strcpy 或手动补 '\0'
- 预期：Valgrind 报 Invalid write（常见 0 bytes after a block ...）

**必做错误（故意触发 2：泄漏）**
- 读入后忘记 free(record.name) / free(record.number) / free(db.items)
- 预期：Valgrind 报 definitely lost

**修复标准**
- Valgrind 结果：ERROR SUMMARY: 0 errors（至少做到无 invalid read/write，无 definitely lost）
- 退出前能释放所有分配的内存



### 实践清单：阶段 E（删除与扩容，realloc 的正确姿势）

**目标**
- del：删除指定 name 的记录
- add：除了追加文件，也要更新内存 DB（为以后做“全量保存”铺路）
- 支持扩容：cap 不够时 realloc

**realloc 正确姿势（必须背）**

```c
Record *tmp = realloc(db->items, new_cap * sizeof(Record));
if (tmp == NULL) {
    // 保留旧指针 db->items，不要覆盖它
    return false;
}
db->items = tmp;
db->cap = new_cap;
```

**必做错误（故意触发）**
- 直接 db->items = realloc(...)，realloc 失败会把旧指针丢失
- 结果：内存泄漏 / 状态损坏
- Valgrind 常见：definitely lost 或后续崩溃

**修复标准**
- realloc 失败时程序仍稳定（不会丢数据、不会崩）
- Valgrind 无泄漏

---



### 实践模板：db.h / db.c（内存 DB + realloc）

**位置**
- `src/db.h`
- `src/db.c`

**db.h**

```c
#ifndef PB_DB_H
#define PB_DB_H

#include <stdbool.h>
#include <stddef.h>

typedef struct {
    char *name;     /* Owned by DB */
    char *number;   /* Owned by DB */
} pb_record_t;

typedef struct {
    pb_record_t *items;
    size_t size;
    size_t cap;
} pb_db_t;

bool pb_db_init(pb_db_t *db);
void pb_db_deinit(pb_db_t *db);

bool pb_db_add_owned(pb_db_t *db, char *name, char *number); /* takes ownership */
bool pb_db_delete_by_name(pb_db_t *db, const char *name);

size_t pb_db_size(const pb_db_t *db);
const pb_record_t *pb_db_get(const pb_db_t *db, size_t idx);

bool pb_str_starts_with(const char *s, const char *prefix);

#endif /* PB_DB_H */
```

**db.c**

```c
#include "db.h"

#include <stdlib.h>
#include <string.h>

static void pb_record_free(pb_record_t *rec)
{
    if (rec == NULL) {
        return;
    }
    free(rec->name);
    rec->name = NULL;
    free(rec->number);
    rec->number = NULL;
}

bool pb_db_init(pb_db_t *db)
{
    if (db == NULL) {
        return false;
    }
    db->items = NULL;
    db->size = 0;
    db->cap = 0;
    return true;
}

void pb_db_deinit(pb_db_t *db)
{
    if (db == NULL) {
        return;
    }
    for (size_t i = 0; i < db->size; i++) {
        pb_record_free(&db->items[i]);
    }
    free(db->items);
    db->items = NULL;
    db->size = 0;
    db->cap = 0;
}

static bool pb_db_grow(pb_db_t *db, size_t min_cap)
{
    size_t new_cap = (db->cap == 0) ? 8 : db->cap;
    while (new_cap < min_cap) {
        new_cap *= 2;
    }

    pb_record_t *tmp = (pb_record_t *)realloc(db->items, new_cap * sizeof(pb_record_t));
    if (tmp == NULL) {
        return false; /* keep old db->items */
    }
    db->items = tmp;
    db->cap = new_cap;
    return true;
}

bool pb_db_add_owned(pb_db_t *db, char *name, char *number)
{
    if ((db == NULL) || (name == NULL) || (number == NULL)) {
        free(name);
        free(number);
        return false;
    }

    if (db->size == db->cap) {
        if (!pb_db_grow(db, db->size + 1)) {
            free(name);
            free(number);
            return false;
        }
    }

    db->items[db->size].name = name;
    db->items[db->size].number = number;
    db->size++;
    return true;
}

bool pb_db_delete_by_name(pb_db_t *db, const char *name)
{
    if ((db == NULL) || (name == NULL)) {
        return false;
    }

    for (size_t i = 0; i < db->size; i++) {
        if ((db->items[i].name != NULL) && (strcmp(db->items[i].name, name) == 0)) {
            pb_record_free(&db->items[i]);

            /* Shift left */
            if (i + 1 < db->size) {
                memmove(&db->items[i], &db->items[i + 1], (db->size - i - 1) * sizeof(pb_record_t));
            }
            db->size--;
            /* Clear tail slot to avoid double-free confusion */
            if (db->size < db->cap) {
                db->items[db->size].name = NULL;
                db->items[db->size].number = NULL;
            }
            return true;
        }
    }
    return false;
}

size_t pb_db_size(const pb_db_t *db)
{
    return (db == NULL) ? 0 : db->size;
}

const pb_record_t *pb_db_get(const pb_db_t *db, size_t idx)
{
    if ((db == NULL) || (idx >= db->size)) {
        return NULL;
    }
    return &db->items[idx];
}

bool pb_str_starts_with(const char *s, const char *prefix)
{
    if ((s == NULL) || (prefix == NULL)) {
        return false;
    }
    size_t p_len = strlen(prefix);
    return strncmp(s, prefix, p_len) == 0;
}
```

---

## 🔁 24小时复习

- 我能否用自己的话说出这节的核心规则：
- 我能否手写一个最小示例：
- 我能否说出最容易错的一点：

## 🔗 关联

- 相关错题：[[10_编程/错题本/02_Memory_Address/my_strdup实现漏洞]]
- 相关练习：课后自拟 1~2 个最小例子
- 相关笔记：[[10_编程/笔记/cs50-week4-memory-notes/07-valgrind]]



