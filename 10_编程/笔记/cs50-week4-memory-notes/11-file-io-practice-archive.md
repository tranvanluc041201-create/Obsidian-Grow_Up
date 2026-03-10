---
title: "11）文件 I/O 实践与模板归档"
type: 编程学习笔记
language: C
module: 输入输出
created: 2026-03-10
review_after: 2026-03-11
tags:
  - 编程
  - C语言
  - 文件
  - 归档
  - 项目实践
source: AI 陪学整理
---

# 11）文件 I/O 实践与模板归档

> [!note]
> 这页只放两类内容：项目实践清单、较长模板代码。  
> 不承担“首次学习”功能。首次学习先看：[[10_编程/笔记/cs50-week4-memory-notes/08-file-io-fopen]]、[[10_编程/笔记/cs50-week4-memory-notes/09-file-functions]]、[[10_编程/笔记/cs50-week4-memory-notes/10-file-functions-code-bridge]]

## 实践清单

### 阶段 A：追加写入

- 目标：把一条记录追加到 `data/phonebook.csv`
- 重点：区分 `"a"` 和 `"w"`
- 修复标准：连续执行两次后，两条记录都还在

### 阶段 B：读取与展示

- 目标：逐行读取并打印
- 重点：`"r"` + 判 `NULL` + 检查循环返回值
- 修复标准：文件不存在时不崩，文件存在时能完整读取

### 阶段 C：解析与校验

- 目标：解析 `name,number`
- 重点：空字段、超长、脏数据
- 修复标准：坏行不会把程序带崩

### 阶段 F：全量保存

- 目标：修改内存数据后，用 `"w"` 重建文件
- 重点：先写临时文件，再替换原文件
- 修复标准：失败时不把旧文件清坏

### 阶段 G：二进制导入导出

- 目标：用 `fread / fwrite` 做二进制保存和恢复
- 重点：检查返回块数
- 修复标准：读回的数据能和写入前一致

## 长模板代码

### I/O 层模板

```c
FILE *fp = fopen(path, mode);
if (fp == NULL) {
    return false;
}

if (fprintf(fp, "%s,%s\n", name, number) < 0) {
    fclose(fp);
    return false;
}

if (fclose(fp) != 0) {
    return false;
}
```

### 逐行读取模板

```c
char line[512];
while (fgets(line, sizeof(line), fp) != NULL) {
    /* parse line */
}
```

### 安全重建模板

```c
FILE *fp = fopen(tmp_path, "w");
if (fp == NULL) return false;

/* write all */

fclose(fp);
rename(tmp_path, path);
```

## 🔗 关联

- [[10_编程/笔记/cs50-week4-memory-notes/08-file-io-fopen]]
- [[10_编程/笔记/cs50-week4-memory-notes/09-file-functions]]
- [[10_编程/笔记/cs50-week4-memory-notes/10-file-functions-code-bridge]]
