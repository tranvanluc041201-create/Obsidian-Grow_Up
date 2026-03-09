## 9）常见文件函数：怎么选、怎么用（给小项目直接套）

### 9.1 fprintf / fscanf（文本：人能看懂）

#### fprintf（像 printf，但写到文件）

```c
FILE *fp = fopen("phonebook.csv", "a");
if (fp == NULL) return 1;

fprintf(fp, "%s,%s\n", name, number);

fclose(fp);
```

#### fscanf（像 scanf，但从文件读；新手关键：看返回值 + 限制长度）

* 返回值：成功匹配并赋值的项数
* `%s` 必须加宽度限制，防溢出

读一个单词：

```c
char word[32];
if (fscanf(fp, "%31s", word) != 1) {
    // EOF 或格式不匹配
}
```

读简单 CSV（一种入门写法，复杂 CSV 不建议死磕 fscanf）：

```c
char name[32], number[32];
int ret = fscanf(fp, "%31[^,],%31s", name, number);
if (ret == 2) {
    // 读到一条记录
}
```

### 实践清单：阶段 B（读取与展示，理解 "r" + 判 NULL）

**目标**
- 实现：`./phonebook list`
- 从 `data/phonebook.csv` 读出每行并打印

**必须掌握的点**
- `fopen(...,"r")` 失败会返回 `NULL`（文件不存在/路径错误/权限问题）
- 读取循环必须检查返回值（避免死循环/脏数据）

**推荐读取方式（入门版，简单稳定）**
- 用 `fgets` 读一整行，再解析（比死磕 `fscanf` 稳）

```c
char line[256];
while (fgets(line, sizeof(line), fp) != NULL) {
    // 解析 line
}
```

**必做错误（故意触发）**
- 把路径写错：`data/phonebok.csv`
- 观察：`fopen` 返回 `NULL`
- 你要练：判 NULL 并输出错误信息（别继续读）
- 不判 NULL 就用 `fgets`
- 结果：很容易崩或行为异常（取决于实现）

**修复标准**
- 文件不存在时：程序不崩，能输出“打开失败”并退出
- 文件存在时：能完整列出每条记录

### 实践清单：阶段 C（解析与校验，把“数据脏”当成常态）

**目标**
- 解析每行 `name,number`
- 做最基本校验：空字段、超长、非法字符（按你需要）

**必做错误（故意触发）**
- CSV 放一行超长 name（> 你缓冲区长度）
- 观察：如果你用 `%s` 或数组越界，会触发异常或 Valgrind 报错
- 练习：用固定缓冲 + 长度限制；或拒绝该行并提示

**修复标准**
- 脏数据不会把程序带崩
- 能对“坏行”跳过并提示（或直接报错退出，至少要可控）

### 9.2 fwrite / fread（二进制：机器搬运快）

#### 规则（必须背）

* `fwrite(ptr, size, nmemb, fp)`：写 nmemb 个元素，每个 size 字节
* 返回值：成功写入的“元素个数”（不是字节数）

写结构体：

```c
typedef struct { int id; float score; } Record;
Record r = {1, 99.5f};

FILE *fp = fopen("rec.bin", "wb");
if (fp == NULL) return 1;

if (fwrite(&r, sizeof(r), 1, fp) != 1) {
    // 写失败
}
fclose(fp);
```

读结构体：

```c
Record r2;
FILE *fp = fopen("rec.bin", "rb");
if (fp == NULL) return 1;

if (fread(&r2, sizeof(r2), 1, fp) != 1) {
    // EOF 或读失败
}
fclose(fp);
```

### 实践清单：阶段 G（可选强化：二进制导入导出，fread/fwrite）

**目标**
- export-bin：把 DB 写成二进制（更快、更小）
- import-bin：读回二进制恢复 DB

**二进制格式建议（新手稳定版，避免写裸结构体）**
- 写入：记录数 N（uint32）
- 循环 N 次：
  - name_len（uint32） + name bytes（含 `'\0'` 或不含都可，但要统一）
  - num_len（uint32） + number bytes

**不建议** 直接 `fwrite(&record, sizeof(record), 1, fp)`：结构体对齐/指针地址没意义、跨平台更麻烦（上面的结构体示例仅用于快速演示）

**必做错误（故意触发）**
- 忽略 `fread` 返回值：文件不完整时会读出半条记录，导致后续越界/脏数据

**修复**
- 每次 `fread` 都检查返回元素数是否等于期望

**修复标准**
- export 后 import 能恢复完全一致的数据
- 文件截断/损坏时能报错退出，不会崩

> 小项目建议：
> 通讯录/待办/记账：先用 **CSV（fprintf）**，因为可读、好调试。
> 图片/音频/固件块：再用 **fread/fwrite**。

---

### 实践模板：parse.h / parse.c（CSV 解析 + 校验）

**位置**
- `src/parse.h`
- `src/parse.c`

**parse.h**

```c
#ifndef PB_PARSE_H
#define PB_PARSE_H

#include <stdbool.h>

/*
 * Parse a CSV line:  name,number\n
 * Output strings are heap-allocated and owned by caller.
 */
bool pb_parse_csv_line(const char *line, char **name_out, char **number_out);

#endif /* PB_PARSE_H */
```

**parse.c**

```c
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
```

---
