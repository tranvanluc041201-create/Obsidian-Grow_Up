---
title: NCRE-跨图串联记忆图
mindmap-plugin: basic
type: 编程学习笔记
language: C
exam: NCRE二级C
created: 2026-03-10
tags:
  - 编程
  - C语言
  - NCRE
  - 思维导图
  - Markmind
  - 串联
---

# 跨图串联

## 地址 / 指针 / 退化
- 数组名 a
    - 多数表达式里会看成首元素地址
- scanf("%s", s)
    - s 是字符数组名
    - 本身就像地址
- struct Node *next
    - next 里存的是下一个结点地址
- 二级指针
    - 存的是“指针变量的地址”
- 函数指针
    - 存的是函数入口地址

## 输入输出家族
- scanf / printf
    - 键盘读 / 屏幕写
- fscanf / fprintf
    - 文件里按格式读 / 写
- fgets / fputs
    - 文件里按字符串读 / 写
- fread / fwrite
    - 文件里按数据块读 / 写

## 长度 / 大小 / 计数
- sizeof
    - 看字节数
- strlen
    - 看字符数
    - 不算 \0
- fread / fwrite
    - size 是每块多大
    - count 是几块

## 短路 / 防御式写法
- p && *p
    - 先判地址，再取值
- fp != NULL
    - 先判文件开没开成功
    - 再去读写
- while(p)
    - 链表遍历常先判指针

## 写法陷阱
- int (*fp)(int,int)
    - 函数指针
- int *fp(int,int)
    - 返回 int* 的函数
- (*p).n
    - 先取结构体
    - 再取成员
- p->n
    - 是 (*p).n 的简写

## 流程控制迁移
- continue 在 for
    - 先执行第三表达式
    - 再回条件判断
- continue 在 while
    - 直接回条件判断
- switch 少 break
    - 会继续往下掉
