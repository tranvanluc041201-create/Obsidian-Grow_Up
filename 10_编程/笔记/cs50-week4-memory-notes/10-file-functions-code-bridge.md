---
title: "10）文件函数代码桥卡"
type: 编程学习笔记
language: C
module: 输入输出
created: 2026-03-10
tags:
  - 编程
  - C语言
  - CS50
  - 代码桥
---

# 10）文件函数代码桥卡

## 🎯 一句话结论

> 文件函数先不要背大段说明，只要先能空手写出 3 个最小模板。

## ✅ 共同骨架

```c
FILE *fp = fopen("data.txt", "r");
if (fp == NULL) return 1;

/* 读或写 */

fclose(fp);
```

## ✅ 家族对照

- `fprintf / fscanf`
  - 按格式写 / 读
  - `fp` 在最前
- `fgets / fputs`
  - 按字符串读 / 写
  - `fp` 在最后
- `fread / fwrite`
  - 按数据块读 / 写
  - 固定顺序：`ptr, size, count, fp`

## ✅ 最小模板 1：追加写文本

```c
FILE *fp = fopen("data.csv", "a");
if (fp == NULL) return 1;

fprintf(fp, "%s,%s\n", name, number);

fclose(fp);
```

## ✅ 最小模板 2：逐行读文本

```c
FILE *fp = fopen("data.csv", "r");
if (fp == NULL) return 1;

char line[256];
while (fgets(line, sizeof(line), fp) != NULL) {
    printf("%s", line);
}

fclose(fp);
```

## ✅ 最小模板 3：块读写 + 定位

```c
int a[4] = {1, 2, 3, 4};
int b[2];

FILE *fp = fopen("d.dat", "wb+");
if (fp == NULL) return 1;

fwrite(a, sizeof(int), 4, fp);
fseek(fp, sizeof(int) * 2, SEEK_SET);
fread(b, sizeof(int), 2, fp);

fclose(fp);
```

## ⚠️ 高频坑

- `fopen` 失败先看 `NULL`
- `fscanf / fprintf` 的 `fp` 在最前
- `fgets / fputs` 的 `fp` 在最后
- `fread / fwrite` 不按字节数，按“块数”返回
- `w` 会清空，`a` 会追加，`r` 要求文件先存在

## 🔁 默写顺序

1. 先写共同骨架
2. 再写函数名和参数顺序
3. 最后再补循环或 `fseek`

## 🔗 关联

- [[10_编程/笔记/cs50-week4-memory-notes/08-file-io-fopen]]
- [[10_编程/笔记/cs50-week4-memory-notes/09-file-functions]]
- [[10_编程/思维导图/NCRE-输入输出与文件记忆图]]
