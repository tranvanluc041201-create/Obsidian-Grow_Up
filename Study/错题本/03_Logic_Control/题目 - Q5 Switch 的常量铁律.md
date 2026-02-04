### 【题目】Q5 Switch 的常量铁律


代码片段：

int x = 5;
switch(x) {
    case x > 2: printf("Big"); break;
    case x < 2: printf("Small"); break;
}


问题：这段代码的情况是？
A. 输出 Big
B. 输出 Small
C. 编译报错 (Syntax Error)
D. 运行时崩溃

【你的作答区】

你的选项：[   ]

你的预判：

<details>
<summary><strong>? 点击查看【反方辩手】犀利解析</strong></summary>

正确答案：C (编译报错)

?? 你的思维误区：
以为 switch 像 if-else 一样智能？

?? 逻辑修正：
case 后面必须跟整型常量表达式 (Integer Constant Expression)。
x > 2 包含变量 x，它的值只有在运行的时候才知道。编译器在编译阶段无法生成跳转表 (Jump Table)。
必须记住：case 后面只能跟 1, 'A', 1+2 这种定死的东西。

</details>
