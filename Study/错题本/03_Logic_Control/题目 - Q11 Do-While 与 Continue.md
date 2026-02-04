### 【题目】Q11 Do-While 与 Continue


代码片段：

int i, n=0;
for(i=2; i<5; i++) {
    do {
        if (i%3) continue;
        n++;
    } while(!i);
    n++;
}
printf("n=%d", n);


问题：输出结果是？
A. 3
B. 4
C. 2
D. 5

【你的作答区】

你的选项：[   ]

你的预判：

<details>
<summary><strong>▶ 点击查看【反方辩手】犀利解析</strong></summary>

正确答案：B (4)

🧠 逻辑修正：

i=2: 2%3为真 -> continue。跳过内层 n++。检查 !i (即 !2 为假)。内层循环结束。外层 n++ (n=1)。

i=3: 3%3为假。执行内层 n++ (n=2)。检查 !3 为假。内层循环结束。外层 n++ (n=3)。

i=4: 4%3为真 -> continue。跳过内层 n++。检查 !4 为假。内层循环结束。外层 n++ (n=4)。

结果 n=4。

</details>

