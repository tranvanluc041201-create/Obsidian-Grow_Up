## 8）File I/O：fopen 模式（"r"/"w"/"a"）+ 常见函数怎么用（重点：你薄弱点）

### 8.1 文件读写主线（记住这条流水线）

1. `fopen` 打开文件（失败返回 `NULL`）
2. `fprintf/fscanf`（文本）或 `fwrite/fread`（二进制）
3. `fclose` 关闭（刷新缓冲、释放资源）

### 8.2 fopen / fclose（最小模板）

```c
FILE *fp = fopen("data.txt", "r");
if (fp == NULL) {
    return 1;
}
// ...读写...
fclose(fp);
```

### 8.3 重点：mode 三兄弟（你必须背熟）

#### "r"：只读

* 文件必须存在，否则 `fopen` 返回 `NULL`
* 不创建文件

#### "w"：写入（覆盖写）

* 文件不存在：创建
* 文件存在：**先清空原内容**，再从头写

#### "a"：追加写（累计保存）

* 文件不存在：创建
* 文件存在：**保留原内容**，新内容写到末尾

> 你在视频里看到 “w 改 a” 的意义：
> **从“每次运行覆盖旧数据”变成“每次运行都累积保存”。**

### 8.4 两次运行的效果对照（ASCII）

```text
Run#1 写入 Alice,111

mode="w": phonebook.csv = Alice,111
mode="a": phonebook.csv = Alice,111

Run#2 写入 Bob,222

mode="w": phonebook.csv = Bob,222        <- Alice 被清空
mode="a": phonebook.csv =
  Alice,111
  Bob,222                                <- 累积保存
```

---

### 实践清单：阶段 A（追加写入，理解 "w" vs "a"）

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

**必做错误（故意触发）**
- 把 "a" 改成 "w"，运行两次 add
- 观察：第一次写入的记录消失（被清空覆盖）

**你要写在笔记里的结论（必须写）**
- "w"：存在则清空 → 适合“生成最新快照”
- "a"：存在则追加 → 适合“日志/累计记录”

**修复标准**
- 连续执行两次 add 后，CSV 中两条都存在

### 实践清单：阶段 F（全量保存，用 "w" 正确重建文件）

**目标**
- 当你在内存里做了 del / 修改等操作后，用 "w" 重建整个 CSV（这是 "w" 的正确用法）
- 命令：`./phonebook save`（或在 del 后自动 save）

**正确思路**
- "w" 不是错，它适合“写快照”：把内存 DB 全部写回文件
- 注意：写到临时文件再替换（避免写一半崩溃导致文件损坏）
- `data/phonebook.tmp` 写完 → rename 替换（Windows/WSL 上 rename 行为略有差异，先在 WSL 内完成）

**必做错误（故意触发）**
- 直接用 "w" 写回，但中途故意 return（模拟崩溃路径）
- 观察：文件可能只写了一半

**修复标准**
- save 后文件内容与内存一致
- 中途失败不会把旧文件直接清空成半成品（用 tmp 方案）

---

### 实践模板：io.h / io.c（文件 I/O 层）

**位置**
- `src/io.h`
- `src/io.c`

**io.h**

```c
#ifndef PB_IO_H
#define PB_IO_H

#include <stdbool.h>

#include "db.h"

/* Append one record to CSV using the given mode ("a" recommended, "w" for demo). */
bool pb_io_append_csv(const char *path, const char *mode, const char *name, const char *number);

/* Load CSV into DB (db must be init). Returns true even if file doesn't exist (treated as empty). */
bool pb_io_load_csv(const char *path, pb_db_t *db);

/* Save DB to CSV using temp file then rename. */
bool pb_io_save_csv_atomic(const char *path, const pb_db_t *db);

#endif /* PB_IO_H */
```

**io.c**

```c
#include "io.h"

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "parse.h"

/* Note: your weak point: file mode. Keep these centralized. */
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

    /* CSV line */
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
        /* treat missing file as empty DB (common for first run) */
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
            /* pb_db_add_owned frees on failure, but here it already took ownership only when success.
             * In our db implementation, on failure it frees both.
             */
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

    /* Optional header */
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

    /* On Linux (WSL), rename is atomic. If target exists, rename replaces it. */
    if (rename(tmp_path, path) != 0) {
        pb_print_errno("rename failed");
        (void)remove(tmp_path);
        return false;
    }
    return true;
}
```

---
