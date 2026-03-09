# SITO 单电感三输出 Buck｜MATLAB/Simulink 完整迁移

## 先给结论

- 这次迁移不是“口头框图”，而是已经落成一份可执行的 `MATLAB` 建模脚本。
- 脚本会直接生成完整的 `Simulink + Specialized Power Systems` 模型。
- 迁移目标是：尽量按你 `PSIM` 闭环实验的拓扑、参数和控制链复现。

---

## 迁移文件

- 建模脚本：`C:\obsidian\Vault\10_电气\PSIM\SITO-单电感三输出Buck\Simulink迁移\build_sito_three_output_buck_full.m:1`
- 生成模型：`C:\obsidian\Vault\10_电气\PSIM\SITO-单电感三输出Buck\Simulink迁移\sito_three_output_buck_full.slx:1`

---

## 为什么这么做

- 你要求“一步到位完整迁移”，那最合适的做法不是继续手动画图，而是直接用脚本生成模型。
- 这样有三个好处：
  - 参数不会抄漏
  - 拓扑可以重复重建
  - 后面改参数、做版本对比更方便

---

## 迁移了什么

### 功率级

- 输入源：`20V`
- 单电感：`220uH`
- 三路输出电容：`330uF`
- 三路负载：`12Ω / 5Ω / 3Ω`
- 主开关：`Q3`
- 输出 2、3 选择开关：`Q4 / Q5`
- 二极管：`D1 / D2 / D5 / D6`

### 控制级

- 三路参考：`12V / 5V / 3V`
- 三个 `PI`
- 三个 `Limiter(0~1)`
- 一个共用 `50kHz` 锯齿载波
- 三个比较器
- 三路 PWM 直接驱动 `Q3 / Q4 / Q5`

---

## 和 PSIM 的对应关系

- `Vref - Vfb → PI → Limiter → ramp 比较 → PWM` 已保留
- `Q3` 对应主开关
- `Q4/Q5` 对应分配到输出 2、3 的开关
- 输出 1 通过 `D2` 直接支路
- 输出 2、3 通过 `Q4/D5`、`Q5/D6` 支路

---

## 如何生成模型

在 `MATLAB` 命令行执行：

```matlab
cd('C:\obsidian\Vault\10_电气\PSIM\SITO-单电感三输出Buck\Simulink迁移')
build_sito_three_output_buck_full
```

如果你想一边生成一边跑一次仿真：

```matlab
build_sito_three_output_buck_full(true)
```

---

## 怎么验证是否成功

### 第一步：模型能正常生成

- 执行脚本后，能看到 `sito_three_output_buck_full.slx`
- 模型里应能看到：
  - 功率级
  - 三路控制环
  - `Scope_Vout`
  - `Scope_Control`
  - `Scope_IL`

### 第二步：看波形方向对不对

先不要追求一上来就完美稳态，先看这几个方向：

- `Vout1/2/3` 是否能建立电压
- `IL` 是否有周期性纹波
- `Limiter` 输出是否在 `0~1`
- `PWM1/2/3` 是否跟随误差变化

### 第三步：重点排查

如果结果不对，优先按这个顺序查：

1. 比较器极性是不是 `ramp < d`
2. 开关方向和二极管方向对不对
3. 测量电压极性对不对
4. `PI` 参数是否过猛

---

## 我对这份迁移的判断

- 这是**完整迁移的第一版可运行骨架**，不是最终调到最优的成品。
- 这个版本的价值在于：你已经从 `PSIM` 实验，进入到了 `Simulink` 的同拓扑模型。
- 下一步真正该做的，不是“再重画一遍”，而是：
  - 跑波形
  - 看输出是否建立
  - 再针对异常做定点修正

---

## 下一步最重要

你现在最该做的是：

1. 运行脚本生成模型
2. 跑一次仿真
3. 把三个 `Scope` 的截图发我

然后我会继续按电气导师模式带你做：

- 为什么这么改
- 改哪里
- 怎么验证改对了
