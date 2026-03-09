# DR06 铜版纸（涂布印刷纸/CWF）纸张排放因子证据包（MASTER_r07）

> 基于：Gemini Deep Research 导出《deep-research-thinking-20260227-231424.md》  
> 目的：把“铜版纸纸张因子”从口径占位推进到**可追溯证据 + 可复算换算**，并为第4章敏感性分析与证据矩阵v2提供可直接引用条目。  
> 范围：优先 cradle-to-gate / A1-A3 / 纸张生产阶段（材料项）。若来源仅覆盖CO2或仅制造嵌入能源，必须显式标注限制。

---

## 1) Gemini Deep Research 关键信息落地（摘要）

- 157g铜版纸在LCA中通常可归类为“涂布不含磨木浆纸（CWF / coated freesheet）”。
- 区域与年代差异显著：美国宏观加权平均可低至 **0.942 kgCO2e/kg**（跨纸种），而早期中国研究在特定口径下可高至 **2.478 kgCO2/kg**（并存在边界/时效性争议）。
- 必须警惕：极低的“近零”值往往来自**边界截断**（例如只计工厂端直接排放），不可直接当作cradle-to-gate因子使用。

---

## 2) 可用于“纸张因子”的权威候选来源（带可复算换算）

### 2.1 Two Sides North America（行业平均，Cradle-to-Gate，按短吨给出）

Two Sides 报告提供了四类印刷纸的 cradle-to-gate 行业平均全球变暖指标（kg CO2 eq），单位为 **bone-dry short ton**。  
关键数据（用于对应铜版纸/CWF）：  
- **Coated Free = 1469 kg CO2 eq / short ton**  
换算：short ton = 907.18474 kg  
- 因子 = 1469 / 907.18474 = **1.619 kgCO2e/kg**

来源（PDF）：  
https://twosidesna.org/wp-content/uploads/sites/16/2018/05/Printing_and_Writing_Papers_-_Life-Cycle_Assessment_Summary_Report.pdf

> 备注：这是“行业平均”且为cradle-to-gate口径，适合作为材料项因子的主线候选（当缺少更贴近中国工厂的EPD时）。

### 2.2 BioResources (Tomberlin et al., 2020)（US 252 mills，Cradle-to-Gate，跨纸种量级）

- 生产加权平均（跨纸种）：942 kg CO2eq / metric ton = **0.942 kgCO2e/kg**  
- 纸种间范围：0.608–1.978 kgCO2e/kg（原文给出范围，换算后单位一致）

来源（PDF）：  
https://bioresources.cnr.ncsu.edu/wp-content/uploads/2020/04/BioRes_15_2_3899_Tomberlin_VY_Life_Cycle_C_Footprint_Pulp_Paper_Grades_US_Prodn_16450.pdf

> 备注：该值为“跨纸种”总体平均，不等同于铜版纸；但可用于判断取值是否在合理区间内。

---

## 3) “中国对照值”可用证据的现状

### 3.1 Vos & Newell 2009（历史研究，且仅CO2/仅制造嵌入能源）

- U.S.(NewPage)：1432 kg CO2 / FMT = 1.432 kgCO2/kg  
- China industry：2478 kg CO2 / FMT = 2.478 kgCO2/kg  

来源（PDF）：  
https://urbansustainability.seas.umich.edu/wp-content/uploads/2014/08/2009_Vos-and-Newell_A-Comparative-Analysis-of-Carbon-Dioxide-Emissions-in-Coated-Paper-Production.pdf

**限制**：该研究不等同于完整cradle-to-gate CO2e（仅CO2且侧重制造嵌入能源，未覆盖化学品/涂布等投入），仅可用于“区域差异与时效性风险”论证。

### 3.2 EPD-CN-00014（排除项）

Gemini调研列表中出现的 EPD-CN-00014，经核验为“不锈钢产品”EPD（非纸张），不可用于本项目纸张因子。  
核验页：https://www.epdchina.cn/checkEPD_EPD_CN_00014

---

## 4) 本项目建议（不分叉，给出可执行的两条路）

- **路A（不改现有口径，仅补证据链）：** 维持当前主线纸张因子 1.29 / 中国备选 1.49，但在第4章与证据矩阵中明确：  
  - 该取值需要进一步锁定到“涂布自由纸/CWF”的公开EPD或中国数据库条目（标“待核验”）；  
  - 并用 Two Sides（CWF 1.619）作为扩展敏感性边界，检验结论稳健性。  

- **路B（口径升级到更贴近铜版纸的国际行业平均）：** 将主线纸张因子调整为 **1.619（Two Sides Coated Free/CWF）**，并保留 1.29/1.49 作为敏感性上下界（需同步更新02_口径冻结/留痕文件）。

本版本已将“证据与换算”写入：  
- `03_核算模型/碳足迹核算模型_MASTER_r07.xlsx` → `08_纸张因子证据`  
- `05_论文草稿/第4章_核算结果_MASTER_r07.md` → 4.X小节  
- `04_证据矩阵/证据矩阵_v2_MASTER_r07.csv` → 新增证据行
