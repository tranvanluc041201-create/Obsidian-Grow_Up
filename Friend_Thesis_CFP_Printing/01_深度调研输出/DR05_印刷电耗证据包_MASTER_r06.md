# DR05 印刷电耗证据包（MASTER_r06）

> 生成时间：2026-02-26  
> 目的：在拿不到企业实测/手册电耗时，提供“可溯源、可答辩”的电耗占位策略，并说明换算逻辑。

---

## 1) 一手证据来源（VTT Research Notes 2560）

来源（VTT官方研究门户PDF）：
- Pihkola H, Nors M, Kujanpää M, et al. *Carbon footprint and environmental impacts of print products from cradle to grave: Results from the LEADER project (Part 1).* VTT Research Notes 2560, 2010.  
  PDF: https://cris.vtt.fi/ws/portalfiles/portal/18863881/T2560.pdf  
引用日期：2026-02-26

该报告在“Environmental indicators for printing”章节给出不同印刷方式的 **Energy consumption (kWh/tonne printed products)** 区间（Table 4）。

### 表1 VTT Table 4（能耗强度，kWh/tonne printed products）

| 印刷方式 | Energy consumption (kWh/tonne) 区间 |
|---|---:|
| Electrophotography（电摄影） | 590–650 |
| Sheetfed offset（平张胶印） | 800–1040 |

> 注：VTT原文提示这些指标用于展示量级，不宜直接跨方式严格比较；本研究仅将其作为“可追溯占位区间”，并在论文中明确该局限。

---

## 2) 换算到本研究功能单位（kWh/1000张）

### 2.1 换算公式

- 功能单位纸张消耗（吨）：  
  t = 纸张消耗(kg/1000张) / 1000
- 功能单位电耗（kWh/1000张）：  
  kWh_FU = (kWh/tonne) × t

### 2.2 代入本模型当前纸张消耗（含废品率假设）

- 数字印刷纸张消耗：9.89 kg/1000张 → t = 0.00989 t  
- 胶印纸张消耗：10.58 kg/1000张 → t = 0.01058 t  

### 2.3 折算区间与本模型取值（中值）

| 工艺（对应） | kWh/tonne 区间 | 折算区间 (kWh/1000张) | 本模型采用值（中值） |
|---|---:|---:|---:|
| 数字印刷（电摄影） | 590–650 | 5.84–6.43 | 6.13 |
| 胶印（平张胶印） | 800–1040 | 8.46–11.00 | 9.73 |

---

## 3) 与Excel模型的绑定方式

- Excel主线文件：`03_核算模型/碳足迹核算模型_MASTER_r06.xlsx`
- 关键输入位置：`02_活动数据输入`  
  - C14：数字印刷“文献换算”电耗（kWh/1000张）  
  - C15：胶印“文献换算”电耗（kWh/1000张）  
- 切换逻辑：`01_功能单位与情景`!B14  
  - “估算” → 使用 C14/C15（文献换算占位）  
  - “实测/手册” → 优先使用 C16/C17（若未填则回退占位）

---

## 4) 后续升级路径（不阻塞写作）

如后续能够拿到设备手册或实测电表数据，只需提供/替换 2 个值即可：
- 数字印刷电耗 (kWh/1000张)
- 胶印电耗 (kWh/1000张)

