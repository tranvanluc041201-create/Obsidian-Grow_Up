---
title: "10）文件函数代码桥：最小模板与参数顺序"
type: 编程学习笔记
language: C
module: 输入输出
created: 2026-03-10
review_after: 2026-03-11
tags:
  - 编程
  - C语言
  - 文件函数
  - 代码桥
source: AI 陪学整理
---

# 10）文件函数代码桥：最小模板与参数顺序

## 🎯 一句话结论

> 文件函数先不要背大段解释，先把共同骨架和三个最小模板写顺。

## 📌 这节只解决什么

- 共同骨架怎么默写
- 三大家族的参数顺序怎么记
- `fseek` 到底在做什么

## ✅ 共同骨架

```c
FILE *fp = fopen("data.txt", "r");
if (fp == NULL) return 1;

/* 读或写 */

fclose(fp);
```

## 🔁 代码桥

### 先写共同骨架

- `fopen`
- 判 `NULL`
- 读或写
- `fclose`

### 再补函数家族

- `fprintf / fscanf`
  - `fp` 在最前
- `fgets / fputs`
  - `fp` 在最后
- `fread / fwrite`
  - `ptr, size, count, fp`

### 最后看定位

- `fseek(fp, offset, SEEK_SET)`
- 作用：移动文件光标

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

## ⚠️ 易混点

### `fseek(fp, sizeof(int) * 2, SEEK_SET)`

- `SEEK_SET` = 从文件开头开始数
- `sizeof(int) * 2` = 跳过两个 `int`
- 一句话区分：这句的动作是“把光标移到第 3 个 `int` 前面”

### `rb` vs `wb+`

- `rb` 读已有文件，不清空
- `wb+` 会清空再读写
- 一句话区分：只读旧文件时，优先想 `rb`

## 💥 高频坑

- `w` 会清空文件，却忘了这一点
- `fread / fwrite` 返回值按字节数理解
- `fgets` 成功时返回 `line`，失败或 EOF 才返回 `NULL`

## 🧪 自测

- [ ] 我能空手写出共同骨架
- [ ] 我能写出 `fread / fwrite` 的参数顺序
- [ ] 我能把 `fseek` 那句翻译成“光标移动动作”

## 🔗 关联

- [[10_编程/笔记/cs50-week4-memory-notes/08-file-io-fopen]]
- [[10_编程/笔记/cs50-week4-memory-notes/09-file-functions]]
- [[10_编程/思维导图/NCRE-输入输出与文件记忆图]]
