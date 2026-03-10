---
title: "9）常见文件函数：怎么选、怎么用"
type: 编程学习笔记
language: C
module: 输入输出
created: 2026-03-07
review_after: 2026-03-08
tags:
  - 编程
  - C语言
  - CS50
  - 学习笔记
source: CS50 / 恢复整理
---

# 9）常见文件函数：怎么选、怎么用

## 🎯 一句话结论

> 先别背所有文件函数，只要先分清：按格式、按字符串、按数据块。

## 📌 这节课到底在解决什么

- 解决“看到题时，怎么立刻判断该叫哪一类文件函数”
- 核心是分家族，不是读项目模板

## 🤔 核心概念

### `fprintf / fscanf`

- 按格式写 / 读
- `fp` 在最前

```c
fprintf(fp, "%s,%s\n", name, number);
```

```c
char word[32];
if (fscanf(fp, "%31s", word) != 1) {
    return 1;
}
```

### `fgets / fputs`

- 按字符串读 / 写
- `fp` 在最后

```c
char line[256];
while (fgets(line, sizeof(line), fp) != NULL) {
    printf("%s", line);
}
```

```c
fputs(line, fp);
```

### `fread / fwrite`

- 按数据块读 / 写
- 固定顺序：`ptr, size, count, fp`

```c
fwrite(a, sizeof(int), 4, fp);
fread(b, sizeof(int), 2, fp);
```

## ✅ 正确做法

- 文本文件优先想：`fprintf / fgets`
- 需要按格式解析时再想：`fscanf`
- 二进制块搬运时想：`fread / fwrite`
- 需要跳位置时想：`fseek`

## ⚠️ 常见坑

- `fscanf / fprintf` 的 `fp` 在最前
- `fgets / fputs` 的 `fp` 在最后
- `fread / fwrite` 返回的是“块数”，不是字节数
- 新手阶段容易把 `fgetc` 和 `fgets` 混掉

## 🔍 高阶视角（视情况补充）

- 文本文件：好读、好调试
- 二进制文件：搬运快，但更不直观
- 项目实践清单和长模板代码已移到：[[10_编程/笔记/cs50-week4-memory-notes/11-file-io-practice-archive]]

## 🧠 我的卡点

- 我看到题时，能不能先分出它属于哪一家
- 我能不能不混 `fgetc / fgets`
- 我能不能记住 `fread / fwrite` 的参数顺序

## 🔁 24小时复习

- 我能否手写 1 个文本读写模板
- 我能否手写 1 个块读写模板
- 我能否说出三大家族的区别

## 🔗 关联

- [[10_编程/笔记/cs50-week4-memory-notes/08-file-io-fopen]]
- [[10_编程/笔记/cs50-week4-memory-notes/10-file-functions-code-bridge]]
- [[10_编程/笔记/cs50-week4-memory-notes/11-file-io-practice-archive]]
