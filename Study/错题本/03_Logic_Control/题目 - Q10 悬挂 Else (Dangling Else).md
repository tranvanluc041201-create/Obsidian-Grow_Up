### 【题目】Q10 悬挂 Else (Dangling Else)


代码片段：

int x=2, y=-1, z=2;
if(x < y)
    if(y < 0) z=0;
    else z+=1;
printf("%d", z);


问题：输出结果是？
A. 0
B. 2
C. 3
D. 1

【你的作答区】

你的选项：[   ]

你的预判：

<details>
<summary><strong>▶ 点击查看【反方辩手】犀利解析</strong></summary>

正确答案：B (2)

☠️ 你的思维误区：
被代码缩进骗了，以为 else 是属于外层 if 的？或者以为内层 if 会执行？

🧠 逻辑修正：
C 编译器不看缩进。else 总是匹配最近的那个 if。
代码结构其实是：

if (x < y) {         // 2 < -1 是 False
    if (y < 0) z=0;  // 这整个代码块
    else z+=1;       // 全都被跳过了！
}


z 根本没被动过，还是 2。

</details>

