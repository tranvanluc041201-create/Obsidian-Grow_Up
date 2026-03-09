---
title: NCRE-程序结构与流程控制记忆图
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
  - 程序结构
  - 流程控制
---

# 程序结构 / 流程控制

## 先抓主干
- 看见 #include
    - 先想头文件(.h)
    - 库函数声明常在这里
- 看见 main
    - 程序入口
- 看见 ;
    - 一条语句结束

## 选择结构
- if...else
    - 二选一
    - 是一个完整的语句
- switch
    - 按值分支
    - case 后跟常量
        - 不能有变量(及其表达式
    - default(类似else)
        - 前面都不匹配才走

## 循环结构
- for
    - 次数明确常用它
- while
    - 先判断再执行
- do...while
    - 先执行一次(至少做一次时用)
    - 再判断
- break
    - 跳出当前层循环或 switch
- continue
    - 跳过本轮
    - 直接进下一轮

## 候选易混点
- if 后多一个 ;
    - 条件成立也可能什么都不做
- switch 少 break
    - 会继续往下掉
- do...while 后
    - 末尾那个 ; 不能少
- continue 在 for
    - 先执行第三表达式
    - 再回条件判断
- continue 在 while
    - 直接回条件判断

## 做题抓手
- 先看条件真假
- 再看有没有多余 ;
- 再看 break / continue 影响哪一层
- 最后数循环到底执行几次
