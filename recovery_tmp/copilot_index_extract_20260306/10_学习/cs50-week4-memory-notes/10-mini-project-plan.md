## 10）写小项目的最小落地方案（推荐：通讯录/日志）



### 10.1 需求：追加保存 + 下次读取

* 保存：`fopen(..., "a") + fprintf(...) + fclose`
* 读取：`fopen(..., "r") + 循环 fscanf(...) + fclose`



### 10.2 最常见的“项目级坑”

* 用了 "w" 结果每次运行清空历史
* `fopen` 不判 NULL
* `fscanf` 不检查返回值导致死循环/读脏数据
* 输入不限制长度导致溢出

---



### 10.3 你接下来要做的第一步（现在就能开始）

**任务 1**
- 实现阶段 A + 故意触发 "w" 覆盖问题并写一句总结

**完成后要贴回来的 3 样东西（用于 code review）**
- `src/main.c` 中 add 的实现（相关函数即可）
- 你用 "w" 运行两次后的 `data/phonebook.csv` 内容
- 你改回 "a" 运行两次后的 `data/phonebook.csv` 内容



### 10.4 可选分支（如果你更想做别的项目）

- Todo List（CSV 持久化 + 删除 + 查找）
- 记账本（追加日志 a + 定期快照 w）
- 小型日志系统（a 写入 + r 过滤 + 二进制压缩导出）
- 第一轮建议先做 Phonebook Pro：最贴合 Week4 的“指针 + 文件 + 排错”

---



### 10.5 实践模板：一键生成 phonebook-pro 工程骨架（WSL2）

> 复制整段到 WSL2(Ubuntu) 终端执行：一键生成 phonebook-pro 工程骨架（含 main/io/db/parse 四文件 + Makefile）  
> 你也可以改目录名：把 `PROJ_DIR=phonebook-pro` 改成你想要的名字（根据现有的文件名即可）

```bash
set -e

PROJ_DIR="phonebook-pro"

mkdir -p "${PROJ_DIR}/src" "${PROJ_DIR}/data"

cat > "${PROJ_DIR}/Makefile" <<'EOF'
CC=clang
CFLAGS=-g -O0 -Wall -Wextra -Werror
CFLAGS+= $(EXTRA_CFLAGS)

BIN=phonebook
SRCS=src/main.c src/io.c src/db.c src/parse.c

$(BIN): $(SRCS)
	$(CC) $(CFLAGS) -o $(BIN) $(SRCS)

clean:
	rm -f $(BIN)

valgrind: $(BIN)
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(BIN) list

.PHONY: clean valgrind
EOF

cat > "${PROJ_DIR}/src/db.h" <<'EOF'
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
EOF

cat > "${PROJ_DIR}/src/db.c" <<'EOF'
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
EOF

cat > "${PROJ_DIR}/src/parse.h" <<'EOF'
#ifndef PB_PARSE_H
#define PB_PARSE_H

#include <stdbool.h>

/*
 * Parse a CSV line:  name,number\n
 * Output strings are heap-allocated and owned by caller.
 */
bool pb_parse_csv_line(const char *line, char **name_out, char **number_out);

#endif /* PB_PARSE_H */
EOF

cat > "${PROJ_DIR}/src/parse.c" <<'EOF'
#include "parse.h"

#include <ctype.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

/* ===== Demo bug switches (compile-time) =====
 * Enable with: make EXTRA_CFLAGS="-DPB_DEMO_BUG_NAME_ALLOC_OOB=1"
 *
 * PB_DEMO_BUG_NAME_ALLOC_OOB:
 *   Allocate name buffer without +1, then write '\0' -> OOB write (size 1).
 */
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
    /* NOTE: demo_oob_bug = true intentionally allocates len bytes, then writes '\0' at [len]. */
    size_t alloc_len = demo_oob_bug ? len : (len + 1);

    char *buf = (char *)malloc(alloc_len);
    if (buf == NULL) {
        return NULL;
    }

    if (len > 0) {
        memcpy(buf, begin, len);
    }

    /* This write is safe only if alloc_len == len + 1 */
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

    /* Find comma */
    const char *comma = strchr(p, ',');
    if (comma == NULL) {
        return false;
    }

    /* Left field: name */
    const char *name_begin = p;
    size_t name_len = (size_t)(comma - name_begin);

    /* Right field: number */
    const char *num_begin = pb_skip_left_spaces(comma + 1);
    size_t num_len = strlen(num_begin);

    /* Basic sanity: avoid huge lines (simple guard for beginners) */
    if ((name_len == 0) || (name_len > 200) || (num_len == 0) || (num_len > 200)) {
        return false;
    }

    /* Skip header row like: name,number */
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

    /* After trim, ensure not empty */
    if ((name[0] == '\0') || (number[0] == '\0')) {
        free(name);
        free(number);
        return false;
    }

    *name_out = name;
    *number_out = number;
    return true;
}
EOF

cat > "${PROJ_DIR}/src/io.h" <<'EOF'
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
EOF

cat > "${PROJ_DIR}/src/io.c" <<'EOF'
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
EOF

cat > "${PROJ_DIR}/src/main.c" <<'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "db.h"
#include "io.h"

/* ===== Demo bug switches (compile-time) =====
 * Enable with:
 *   make clean && make EXTRA_CFLAGS="-DPB_DEMO_BUG_INT_OOB=1"
 *
 * PB_DEMO_BUG_INT_OOB:
 *   Reproduce classic: "Invalid write of size 4" + "0 bytes after a block of size 12".
 *
 * PB_DEMO_BUG_LEAK:
 *   Reproduce "definitely lost" leak.
 */
#ifndef PB_DEMO_BUG_INT_OOB
#define PB_DEMO_BUG_INT_OOB 0
#endif

#ifndef PB_DEMO_BUG_LEAK
#define PB_DEMO_BUG_LEAK 0
#endif

/* Your weak point: file mode. Change this to "w" intentionally to see overwrite behavior. */
#define PB_ADD_FILE_MODE "a" /* try "w" to reproduce data loss */
#define PB_CSV_PATH "data/phonebook.csv"

static void pb_print_usage(const char *prog)
{
    fprintf(stderr,
        "Usage:\n"
        "  %s add <name> <number>\n"
        "  %s list\n"
        "  %s find <prefix>\n"
        "  %s del <name>\n"
        "  %s save\n"
        "\n"
        "Notes:\n"
        "  - add uses mode \"" PB_ADD_FILE_MODE "\" (change to \"w\" to reproduce overwrite bug).\n",
        prog, prog, prog, prog, prog);
}

static void pb_demo_int_oob(void)
{
#if PB_DEMO_BUG_INT_OOB
    int *x = (int *)malloc(3 * sizeof(int)); /* 12 bytes */
    if (x == NULL) {
        return;
    }
    /* 🚨 classic bug: write 4th int */
    x[3] = 0;
    free(x);
#endif
}

static void pb_demo_leak(void)
{
#if PB_DEMO_BUG_LEAK
    /* 🚨 leak on purpose */
    void *p = malloc(128);
    (void)p;
#endif
}

static int cmd_add(const char *name, const char *number)
{
    if (!pb_io_append_csv(PB_CSV_PATH, PB_ADD_FILE_MODE, name, number)) {
        fprintf(stderr, "add failed\n");
        return 1;
    }
    printf("OK: appended to %s\n", PB_CSV_PATH);
    return 0;
}

static int cmd_list(void)
{
    pb_db_t db;
    if (!pb_db_init(&db)) {
        return 1;
    }
    if (!pb_io_load_csv(PB_CSV_PATH, &db)) {
        pb_db_deinit(&db);
        fprintf(stderr, "load failed\n");
        return 1;
    }

    printf("== Phonebook (%zu records) ==\n", pb_db_size(&db));
    for (size_t i = 0; i < pb_db_size(&db); i++) {
        const pb_record_t *rec = pb_db_get(&db, i);
        if ((rec != NULL) && (rec->name != NULL) && (rec->number != NULL)) {
            printf("%zu) %s -> %s\n", i + 1, rec->name, rec->number);
        }
    }

    pb_db_deinit(&db);
    return 0;
}

static int cmd_find(const char *prefix)
{
    pb_db_t db;
    if (!pb_db_init(&db)) {
        return 1;
    }
    if (!pb_io_load_csv(PB_CSV_PATH, &db)) {
        pb_db_deinit(&db);
        fprintf(stderr, "load failed\n");
        return 1;
    }

    size_t hit = 0;
    printf("== Find prefix: \"%s\" ==\n", prefix);
    for (size_t i = 0; i < pb_db_size(&db); i++) {
        const pb_record_t *rec = pb_db_get(&db, i);
        if ((rec == NULL) || (rec->name == NULL) || (rec->number == NULL)) {
            continue;
        }
        if (pb_str_starts_with(rec->name, prefix)) {
            printf("%s -> %s\n", rec->name, rec->number);
            hit++;
        }
    }
    printf("hits: %zu\n", hit);

    pb_db_deinit(&db);
    return 0;
}

static int cmd_del(const char *name)
{
    pb_db_t db;
    if (!pb_db_init(&db)) {
        return 1;
    }
    if (!pb_io_load_csv(PB_CSV_PATH, &db)) {
        pb_db_deinit(&db);
        fprintf(stderr, "load failed\n");
        return 1;
    }

    bool ok = pb_db_delete_by_name(&db, name);
    if (!ok) {
        pb_db_deinit(&db);
        fprintf(stderr, "not found: %s\n", name);
        return 1;
    }

    if (!pb_io_save_csv_atomic(PB_CSV_PATH, &db)) {
        pb_db_deinit(&db);
        fprintf(stderr, "save failed\n");
        return 1;
    }

    pb_db_deinit(&db);
    printf("OK: deleted and saved\n");
    return 0;
}

static int cmd_save(void)
{
    pb_db_t db;
    if (!pb_db_init(&db)) {
        return 1;
    }
    if (!pb_io_load_csv(PB_CSV_PATH, &db)) {
        pb_db_deinit(&db);
        fprintf(stderr, "load failed\n");
        return 1;
    }
    if (!pb_io_save_csv_atomic(PB_CSV_PATH, &db)) {
        pb_db_deinit(&db);
        fprintf(stderr, "save failed\n");
        return 1;
    }
    pb_db_deinit(&db);
    printf("OK: saved snapshot (mode \"w\" internally via tmp)\n");
    return 0;
}

int main(int argc, char **argv)
{
    /* Optional demos to reproduce classic Valgrind outputs */
    pb_demo_int_oob();
    pb_demo_leak();

    if (argc < 2) {
        pb_print_usage(argv[0]);
        return 1;
    }

    if (strcmp(argv[1], "add") == 0) {
        if (argc != 4) {
            pb_print_usage(argv[0]);
            return 1;
        }
        return cmd_add(argv[2], argv[3]);
    }
    if (strcmp(argv[1], "list") == 0) {
        if (argc != 2) {
            pb_print_usage(argv[0]);
            return 1;
        }
        return cmd_list();
    }
    if (strcmp(argv[1], "find") == 0) {
        if (argc != 3) {
            pb_print_usage(argv[0]);
            return 1;
        }
        return cmd_find(argv[2]);
    }
    if (strcmp(argv[1], "del") == 0) {
        if (argc != 3) {
            pb_print_usage(argv[0]);
            return 1;
        }
        return cmd_del(argv[2]);
    }
    if (strcmp(argv[1], "save") == 0) {
        if (argc != 2) {
            pb_print_usage(argv[0]);
            return 1;
        }
        return cmd_save();
    }

    pb_print_usage(argv[0]);
    return 1;
}
EOF

# 初始化一个示例 CSV（可删）
cat > "${PROJ_DIR}/data/phonebook.csv" <<'EOF'
name,number
Alice,111
Bob,222
EOF

echo "✅ Project generated: ${PROJ_DIR}"
echo ""
echo "Next:"
echo "  cd ${PROJ_DIR}"
echo "  make"
echo "  ./phonebook list"
echo "  ./phonebook add Charlie 333"
echo "  ./phonebook list"
echo ""
echo "Valgrind (WSL):"
echo "  valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./phonebook list"
echo ""
echo "Reproduce classic Invalid write of size 4 (12 bytes block):"
echo "  make clean && make EXTRA_CFLAGS='-DPB_DEMO_BUG_INT_OOB=1'"
echo "  valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./phonebook list"
echo ""
echo "Reproduce leak definitely lost:"
echo "  make clean && make EXTRA_CFLAGS='-DPB_DEMO_BUG_LEAK=1'"
echo "  valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./phonebook list"
echo ""
echo "Reproduce name alloc OOB (size 1 write):"
echo "  make clean && make EXTRA_CFLAGS='-DPB_DEMO_BUG_NAME_ALLOC_OOB=1'"
echo "  valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./phonebook list"

---