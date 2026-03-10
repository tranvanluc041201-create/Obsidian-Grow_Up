---
title: "11）文件 I/O 实践与模板归档"
type: 编程学习笔记
language: C
module: 输入输出
created: 2026-03-10
tags:
  - 编程
  - C语言
  - CS50
  - 归档
  - 项目实践
---

# 11）文件 I/O 实践与模板归档

> 这页只放两类内容：项目实践清单、较长模板代码。  
> 不承担“首次学习”功能。

## 实践清单：阶段 A（追加写入，理解 "w" vs "a"）

**目标**
- 实现：`./phonebook add name number`
- 把一条记录写入 `data/phonebook.csv`

**推荐实现（正确版本）**

```c
FILE *fp = fopen("data/phonebook.csv", "a");
if (fp == NULL) return 1;
fprintf(fp, "%s,%s\n", name, number);
fclose(fp);
```

**修复标准**
- 连续执行两次 add 后，CSV 中两条都存在

## 实践清单：阶段 B（读取与展示，理解 "r" + 判 NULL）

**目标**
- 实现：`./phonebook list`
- 从 `data/phonebook.csv` 读出每行并打印

**必须掌握的点**
- `fopen(...,"r")` 失败会返回 `NULL`
- 读取循环必须检查返回值

**推荐读取方式**

```c
char line[256];
while (fgets(line, sizeof(line), fp) != NULL) {
    // 解析 line
}
```

**修复标准**
- 文件不存在时：程序不崩，能输出“打开失败”并退出
- 文件存在时：能完整列出每条记录

## 实践清单：阶段 C（解析与校验）

**目标**
- 解析每行 `name,number`
- 做最基本校验：空字段、超长、非法字符

**修复标准**
- 脏数据不会把程序带崩
- 能对坏行跳过并提示

## 实践清单：阶段 F（全量保存，用 "w" 正确重建文件）

**目标**
- 在内存里做了 del / 修改后，用 `"w"` 重建整个 CSV

**正确思路**
- `"w"` 适合“写快照”
- 先写到临时文件，再替换原文件

**修复标准**
- save 后文件内容与内存一致
- 中途失败不会把旧文件清成半成品

## 实践清单：阶段 G（可选强化：二进制导入导出）

**目标**
- export-bin：把 DB 写成二进制
- import-bin：读回二进制恢复 DB

**提醒**
- 每次 `fread` 都检查返回元素数
- 新手阶段不建议直接写裸结构体做最终格式

## 模板：io.h / io.c（文件 I/O 层）

**位置**
- `src/io.h`
- `src/io.c`

```c
#ifndef PB_IO_H
#define PB_IO_H

#include <stdbool.h>

#include "db.h"

bool pb_io_append_csv(const char *path, const char *mode, const char *name, const char *number);
bool pb_io_load_csv(const char *path, pb_db_t *db);
bool pb_io_save_csv_atomic(const char *path, const pb_db_t *db);

#endif /* PB_IO_H */
```

```c
#include "io.h"

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "parse.h"

#define PB_MODE_READ   "r"
#define PB_MODE_WRITE  "w"
#define PB_MODE_APPEND "a"

static void pb_print_errno(const char *msg)
{
    if (msg == NULL) {
        return;
    }
    fprintf(stderr, "%s: %s\n", msg, strerror(errno));
}

bool pb_io_append_csv(const char *path, const char *mode, const char *name, const char *number)
{
    if ((path == NULL) || (mode == NULL) || (name == NULL) || (number == NULL)) {
        return false;
    }

    FILE *fp = fopen(path, mode);
    if (fp == NULL) {
        pb_print_errno("fopen failed");
        return false;
    }

    if (fprintf(fp, "%s,%s\n", name, number) < 0) {
        pb_print_errno("fprintf failed");
        (void)fclose(fp);
        return false;
    }

    if (fclose(fp) != 0) {
        pb_print_errno("fclose failed");
        return false;
    }
    return true;
}

bool pb_io_load_csv(const char *path, pb_db_t *db)
{
    if ((path == NULL) || (db == NULL)) {
        return false;
    }

    FILE *fp = fopen(path, PB_MODE_READ);
    if (fp == NULL) {
        return true;
    }

    char line[512];
    while (fgets(line, sizeof(line), fp) != NULL) {
        char *name = NULL;
        char *number = NULL;

        if (!pb_parse_csv_line(line, &name, &number)) {
            continue;
        }
        if (!pb_db_add_owned(db, name, number)) {
            (void)fclose(fp);
            return false;
        }
    }

    (void)fclose(fp);
    return true;
}

static bool pb_write_all_records(FILE *fp, const pb_db_t *db)
{
    if ((fp == NULL) || (db == NULL)) {
        return false;
    }

    if (fprintf(fp, "name,number\n") < 0) {
        return false;
    }

    for (size_t i = 0; i < pb_db_size(db); i++) {
        const pb_record_t *rec = pb_db_get(db, i);
        if ((rec == NULL) || (rec->name == NULL) || (rec->number == NULL)) {
            continue;
        }
        if (fprintf(fp, "%s,%s\n", rec->name, rec->number) < 0) {
            return false;
        }
    }
    return true;
}

bool pb_io_save_csv_atomic(const char *path, const pb_db_t *db)
{
    if ((path == NULL) || (db == NULL)) {
        return false;
    }

    char tmp_path[512];
    if (snprintf(tmp_path, sizeof(tmp_path), "%s.tmp", path) < 0) {
        return false;
    }

    FILE *fp = fopen(tmp_path, PB_MODE_WRITE);
    if (fp == NULL) {
        pb_print_errno("fopen(tmp) failed");
        return false;
    }

    bool ok = pb_write_all_records(fp, db);
    if (fclose(fp) != 0) {
        pb_print_errno("fclose(tmp) failed");
        ok = false;
    }
    if (!ok) {
        (void)remove(tmp_path);
        return false;
    }

    if (rename(tmp_path, path) != 0) {
        pb_print_errno("rename failed");
        (void)remove(tmp_path);
        return false;
    }
    return true;
}
```

## 模板：parse.h / parse.c（CSV 解析 + 校验）

**位置**
- `src/parse.h`
- `src/parse.c`

```c
#ifndef PB_PARSE_H
#define PB_PARSE_H

#include <stdbool.h>

bool pb_parse_csv_line(const char *line, char **name_out, char **number_out);

#endif /* PB_PARSE_H */
```

```c
#include "parse.h"

#include <ctype.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

#ifndef PB_DEMO_BUG_NAME_ALLOC_OOB
#define PB_DEMO_BUG_NAME_ALLOC_OOB 0
#endif

static void pb_trim_right(char *s)
{
    if (s == NULL) {
        return;
    }
    size_t n = strlen(s);
    while (n > 0) {
        unsigned char c = (unsigned char)s[n - 1];
        if ((c == '\n') || (c == '\r') || isspace(c)) {
            s[n - 1] = '\0';
            n--;
        } else {
            break;
        }
    }
}

static const char *pb_skip_left_spaces(const char *s)
{
    while ((s != NULL) && (*s != '\0') && isspace((unsigned char)*s)) {
        s++;
    }
    return s;
}

static char *pb_dup_range(const char *begin, size_t len, bool demo_oob_bug)
{
    size_t alloc_len = demo_oob_bug ? len : (len + 1);

    char *buf = (char *)malloc(alloc_len);
    if (buf == NULL) {
        return NULL;
    }

    if (len > 0) {
        memcpy(buf, begin, len);
    }

    buf[len] = '\0';
    pb_trim_right(buf);
    return buf;
}

bool pb_parse_csv_line(const char *line, char **name_out, char **number_out)
{
    if ((line == NULL) || (name_out == NULL) || (number_out == NULL)) {
        return false;
    }
    *name_out = NULL;
    *number_out = NULL;

    const char *p = pb_skip_left_spaces(line);
    if (*p == '\0') {
        return false;
    }

    const char *comma = strchr(p, ',');
    if (comma == NULL) {
        return false;
    }

    const char *name_begin = p;
    size_t name_len = (size_t)(comma - name_begin);

    const char *num_begin = pb_skip_left_spaces(comma + 1);
    size_t num_len = strlen(num_begin);

    if ((name_len == 0) || (name_len > 200) || (num_len == 0) || (num_len > 200)) {
        return false;
    }

    if ((name_len == 4) && (strncmp(name_begin, "name", 4) == 0)) {
        return false;
    }

    char *name = pb_dup_range(name_begin, name_len, PB_DEMO_BUG_NAME_ALLOC_OOB != 0);
    if (name == NULL) {
        return false;
    }
    char *number = pb_dup_range(num_begin, num_len, false);
    if (number == NULL) {
        free(name);
        return false;
    }

    if ((name[0] == '\0') || (number[0] == '\0')) {
        free(name);
        free(number);
        return false;
    }

    *name_out = name;
    *number_out = number;
    return true;
}
```

## 关联

- [[10_编程/笔记/cs50-week4-memory-notes/08-file-io-fopen]]
- [[10_编程/笔记/cs50-week4-memory-notes/09-file-functions]]
- [[10_编程/笔记/cs50-week4-memory-notes/10-file-functions-code-bridge]]
