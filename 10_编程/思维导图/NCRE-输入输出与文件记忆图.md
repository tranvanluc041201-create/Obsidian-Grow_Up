---
title: NCRE-输入输出与文件记忆图
mindmap-plugin: basic
type: 编程学习笔记
language: C
exam: NCRE二级C
created: 2026-03-09
tags:
  - 编程
  - C语言
  - NCRE
  - 思维导图
  - Markmind
  - 输入输出
  - 格式串
  - 文件
---

# 输入输出 / 文件

## 先抓主干
- 看见 FILE *fp
    - 这是文件指针
    - 后面很多文件函数都要靠它
- 看见 fopen
    - 先看打开方式
    - 打不开就返回 NULL

## 格式串抓手
- 看见 %f
    - printf 里常拿来输出小数
    - scanf 读 float 才配它
- 看见 %lf
    - scanf 读 double 常用它

## 候选易混点
- scanf("%c", &ch)
    - 前面残留的空格/回车
    - 也可能被当成字符读走
- printf("%d", 3.14)
    - 格式符和类型不匹配
    - 输出结果别硬背，先判错

## 文件打开方式
- "r"
    - 只读
    - 文件必须先存在
    - 打不开就返回 NULL
- "w"
    - 只写
    - 文件不存在会新建
    - 已存在会清空原内容
    - 打不开也返回 NULL
- "a"
    - 追加写
    - 文件不存在会新建
    - 已存在就从末尾继续写
    - 打不开也返回 NULL

## 文件读写抓手
- fgetc / fputc
    - fgetc(fp)：从 fp 读一个字符
    - fputc(ch, fp)：把 ch 写到 fp
- fgets / fputs
    - fgets(s, n, fp)：从 fp 读字符串到 s
    - 最多读 n-1 个字符
    - fputs(s, fp)：把字符串 s 写到 fp
- fread / fwrite
    - fread(ptr, size, count, fp)：从 fp 读 count 个数据块到 ptr
    - fwrite(ptr, size, count, fp)：把 ptr 的 count 个数据块写到 fp
- fscanf / fprintf
    - fscanf(fp, "...", ...)：从 fp 按格式读
    - 读到变量 / 数组里
    - fprintf(fp, "...", ...)：按格式写到 fp
- rewind / fseek / ftell
    - rewind(fp)：回到文件开头
    - fseek(fp, 偏移量, 位置)：移动文件位置
    - ftell(fp)：看当前读写到哪
- fclose
    - fclose(fp)：用完关闭文件

## 记忆抓手
- s
    - string
    - 对应 fgets / fputs
- read / write
    - 数据块
    - 所以要写 size 和 count
- 读取类:fget(s/c),fscanf和fread都是从文件读取
- 输出类:fput(s/c),fprintf和fwrite都是写进文件
- 除了fscanf和fprintf都把fp放后面

## 做题抓手
- 先判是“读”还是“写”
- 再判是“从键盘/文件读”还是“往屏幕/文件写”
- 再看格式符对不对
- 再看 scanf / fscanf 要不要加 &
- 最后看打开方式
    - 要求文件先存在
    - 会不会清空
    - 会不会从末尾追加
    - 文件指针是不是 NULL