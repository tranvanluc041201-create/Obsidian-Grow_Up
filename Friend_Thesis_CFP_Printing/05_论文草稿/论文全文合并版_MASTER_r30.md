# 学校信息与完成时间（MASTER_r30）

- 学校：广州科技职业技术大学
- 完成时间：2026年2月

---

# 本科毕业论文（合并版，MASTER_r30）

> 生成日期：2026-02-28
> 说明：本文件为便于粘贴到Word的合并稿；各章节独立文件仍为主线交付物。
> 结论边界：仅“碳足迹/气候变化维度（kgCO2e）”。

---

# 摘要与Abstract（MASTER_r30）

> 版本：MASTER_r30（基于：摘要与Abstract_MASTER_r11.md；同步第4章MASTER_r12结果与阈值分析；不改变口径）
> 生成日期：2026-02-28
> 结论边界：仅“碳足迹/气候变化维度（kgCO2e）”，不外推为“整体环境影响全面更优”。

## 摘要

在“双碳”与产品碳足迹管理需求提升的背景下，印刷行业亟需形成可复算、可追溯的生产阶段碳足迹对比方法。本文以“碳足迹/气候变化维度（kgCO2e）”为唯一评价维度，基于ISO 14040/14044生命周期评价框架与ISO 14067产品碳足迹要求，构建面向本科答辩的工程化核算模型，对数字印刷与传统平张胶印在生产阶段的碳足迹进行对比分析。研究以1000张A4双面四色宣传单（157g铜版纸，单页，成品质量一致）为功能单位，采用“混合边界”的V2模型：纸张采用cradle-to-gate排放因子，电力采用gate-to-gate电耗与中国官方电力碳足迹因子。由于难以获得企业实测电耗，本文采用公开文献的能耗强度区间折算为功能单位电耗，并在模型中保留“实测/手册优先”接口以便后续替换。

结果表明：在当前V2边界与主线纸张因子取值条件下，数字印刷的碳足迹低于胶印，分别为16.30与19.27 kgCO2e/1000张，胶印相对数字印刷高2.97 kgCO2e/1000张。贡献结构显示纸张项占比高（数字印刷约78%，胶印约71%），差异主要由电耗差异驱动。纸张因子敏感性分析（1.29/1.49/1.619 kgCO2e/kg）下结论方向保持一致，差值稳定在约3.0–3.2 kgCO2e/1000张。阈值分析进一步给出在V2边界下结论可能反转的条件：若胶印电耗低至约4.59 kWh/1000张（其余参数不变），两工艺总量可接近相等；因此电耗实测/手册值是后续最优先补齐的数据项。

本文的主要局限在于：当前模型仅纳入纸张与电力两项，未计入油墨/墨粉、版材、清洗剂/润版液、印前/印后及设备制造等；纸张因子主线与中国备选仍需进一步锁定到可追溯的本土EPD或数据库条目。上述缺口均已在证据矩阵与章节局限性中显式披露。研究为印刷工艺在生产阶段的碳足迹对比提供了一个透明、可复算且可持续迭代的工程化模板。

**关键词**：产品碳足迹；生命周期评价；数字印刷；胶印；电力因子；敏感性分析

## Abstract

With the growing demand for product carbon footprint management, the printing industry needs a transparent and reproducible approach to compare production-stage climate impacts. This thesis compares digital printing and conventional sheetfed offset printing under a single indicator—carbon footprint (kgCO2e)—following ISO 14040/14044 LCA framework and ISO 14067 CFP requirements. The functional unit is defined as 1,000 A4 double-sided full-color leaflets on 157 g coated paper, with consistent product quality. A “hybrid” V2 boundary is adopted for a defensible undergraduate model: paper is modeled with cradle-to-gate emission factors, and electricity is modeled with gate-to-gate consumption multiplied by China’s official 2024 grid carbon footprint factor. When facility-specific electricity data are unavailable, literature-based energy intensity ranges are converted to kWh per functional unit, while the Excel model keeps interfaces to replace placeholder values with measured/manual data.

Under the V2 boundary and the main paper-factor setting, the total carbon footprint is 16.30 kgCO2e/1,000 sheets for digital printing and 19.27 kgCO2e/1,000 sheets for offset printing, indicating a difference of 2.97 kgCO2e/1,000 sheets (offset higher). Paper dominates the footprint (≈70–80%), whereas the gap is largely driven by electricity consumption. Sensitivity analysis over paper factors (1.29/1.49/1.619 kgCO2e/kg) preserves the conclusion direction, with the gap remaining around 3.0–3.2 kgCO2e/1,000 sheets. A threshold analysis shows the reversal condition within the V2 boundary: offset printing would need to reduce electricity to about 4.59 kWh per 1,000 sheets (other parameters unchanged) to approach parity, highlighting electricity data as the top priority for future refinement.

Limitations include the exclusion of inks/toners, plates, cleaning chemicals, and equipment lifecycle, and the need to further verify localized paper emission factors. All gaps are explicitly marked and traceable through the evidence matrix and chapter limitations.

**Key words**: product carbon footprint; life cycle assessment; digital printing; offset printing; electricity factor; sensitivity analysis


---

# 第1章 绪论（MASTER_r30）

> 版本：MASTER_r30（基于：第1章_绪论_MASTER_r10.md；结构补强+与第4章结果闭环）
> 生成日期：2026-02-28
> 结论边界：仅“碳足迹/气候变化维度（kgCO2e）”。

## 1.1 研究背景

产品碳足迹（Carbon Footprint of Products, CFP）已成为制造业与消费品在绿色供应链、低碳设计与信息披露中的关键指标。印刷行业作为典型的“材料+能源”耦合过程，既包含纸张等上游材料生产排放，也包含印刷生产阶段的用电与工艺准备损耗。与此同时，数字印刷与传统胶印在“订单规模、准备工序、能耗与废品率”方面存在结构性差异，导致同一功能单位下的碳足迹可能出现显著差异甚至随批量变化发生反转[8][10]。

现有公开研究对数字印刷与胶印的环境表现给出了一致方向：在短版、小批量场景下数字印刷通常具备优势，而在大批量场景下胶印可能通过规模摊销降低单位负荷[8][9][10]。但在本科论文的真实约束下，企业实测数据往往难以获得，导致研究容易停留在概念讨论、缺乏可复算模型与可答辩的边界披露。本研究以工程化方法解决这一落地难点：在不编造数据的前提下，用“可追溯〔占位〕+〔待核验〕标记+〔可替换〕接口”推进到可答辩的正文与模型。

## 1.2 研究意义

（1）**方法学意义**：在ISO 14040/14044 LCA框架与ISO 14067 CFP要求下，给出适用于“生产阶段聚焦”的部分CFP对比路径，明确功能单位、系统边界、截断与数据策略[1][2][3]。  
（2）**工程实践意义**：以可复算Excel模型与证据矩阵绑定，实现“论点—数据—来源—章节”闭环，便于答辩解释与后续升级。  
（3）**决策参考意义**：在严格边界前提下，识别纸张与电力的贡献结构，并通过敏感性与阈值分析给出“结论稳健性与反转条件”，为工艺选择与减排路径提供方向性参考（不作行业泛化结论）。

## 1.3 研究目标与研究问题

### 1.3.1 研究目标

在统一功能单位与生产阶段边界下，对数字印刷与胶印的碳足迹（kgCO2e）进行量化对比，识别关键影响因素与不确定性来源，形成可持续迭代的低碳评估框架。

### 1.3.2 研究问题

RQ1：在“纸张+电力”的生产阶段V2边界下，两种工艺的碳足迹差异为多少？差异主要由哪些贡献项驱动？  
RQ2：纸张排放因子在合理范围变化时，结论方向是否稳健？  
RQ3：在何种电耗条件下结论可能反转（阈值分析）？哪些数据最应优先补齐以提升可答辩性？

## 1.4 研究内容与技术路线

### 1.4.1 研究内容

1) 建立功能单位与对比情景（S1小批量）并冻结口径；  
2) 构建生产阶段V2核算模型：纸张（cradle-to-gate）+电力（gate-to-gate）；  
3) 形成基线结果、敏感性分析（纸张因子）与阈值分析（反转条件）；  
4) 在章节中显式披露缺失项与边界，避免“以偏概全”的结论外推。

### 1.4.2 技术路线（工程化）

```
标准框架与边界锁定（ISO 14040/44/67 + GHG Product）
            │
            ▼
功能单位/情景定义（1000张A4双面四色，157g铜版纸，S1小批量）
            │
            ▼
V2模型：纸张（上游因子）+ 电力（电耗×电力因子）
            │
            ▼
结果输出：基线 → 纸张因子敏感性 → 阈值分析（反转条件）
            │
            ▼
证据闭环：证据矩阵（论点-证据-章节）+ 数据留痕（来源/口径/日期）
```

## 1.5 研究创新点与工程化贡献

1) **可追溯〔占位〕策略**：当缺少实测电耗时，采用公开研究的能耗强度区间折算为功能单位电耗，并保留“实测/手册优先”的替换接口[8]。  
2) **证据矩阵驱动写作**：将每个关键参数与结论绑定到证据条目与章节落点，减少“写作漂移”。  
3) **答辩友好的阈值分析**：在当前边界下给出反转条件，解释“结论为何成立、何时可能不成立”，提升结果解释质量。

## 1.6 论文结构安排

第1章介绍研究背景、意义与技术路线；第2章综述标准体系与工艺对比研究现状；第3章给出功能单位、系统边界、数据与计算方法；第4章呈现基线结果、敏感性与阈值分析并讨论局限；第5章给出结论、建议与后续研究展望。


---



# 任务书要求对齐说明（MASTER_r30）
> 来源：系统任务书页面截图（“基本目标/基本任务”），用于证明论文结构与任务要求一致；不引入新数据。

## A. 基本目标对齐
- 引入“碳足迹/生命周期评价（LCA）”理论，系统量化对比数字印刷与传统胶印在**生产阶段**的环境表现；
- 明确两者碳排放差异与关键影响因素；
- 构建适用于印刷工艺的低碳评估框架，为特定生产情境下的技术选择提供依据（仅限气候变化维度）。

## B. 基本任务对齐（逐条对应章节）
1) 理论基础与文献综述 → 第2章：方法体系、工艺差异机制、数据项与研究不足。
2) 构建分析框架与确定研究范围 → 第3章：功能单位、系统边界、清单与影响评价方法、截断与分配。
3) 数据收集与整理 → 第3章3.3 + 附录：活动数据与因子来源、〔占位〕〔可替换〕策略、〔待核验〕清单。
4) 碳足迹核算与对比分析 → 第4章：结果表格、敏感性与阈值（反转条件）讨论。
5) 结论与建议 → 第5章：边界内结论、局限与展望（不外推整体环境优越）。

# 第2章 文献综述（MASTER_r30）

> 版本：MASTER_r30（基于：第2章_文献综述_MASTER_r10.md；补强“生产阶段CFP对比”的数据项与结论边界）
> 生成日期：2026-02-28
> 结论边界：仅“碳足迹/气候变化维度（kgCO2e）”。

## 2.1 产品碳足迹与生命周期评价方法体系

生命周期评价（LCA）为产品环境影响量化提供通用框架，ISO 14040给出原则与总体框架，ISO 14044进一步规定实施要求（数据质量、分配、可比性、结果解释等）[1][2]。在气候变化单一影响类别聚焦场景下，ISO 14067提出产品碳足迹（CFP）的量化与报告要求，并允许在边界清晰披露的前提下开展“部分CFP”的量化[3]。此外，GHG Protocol Product Standard提供产品生命周期核算与报告补充框架，可用于说明产品层级核算的组织与信息披露逻辑[4]。

对比研究在方法学层面通常面临三类关键风险：  
（1）功能单位不一致（规格/单双面/色数/纸张类型不一致）；  
（2）系统边界与截断不一致（是否计入纸张上游、制版、清洗剂、印前/印后等）；  
（3）排放因子口径混用（CO2与CO2e、CFP口径与仅CO2口径混用）。因此，文献综述不仅要总结“谁更低碳”，更要总结“在什么条件与边界下得到该结论”。

## 2.2 数字印刷与胶印的工艺差异及其碳足迹影响机制

传统平张胶印一般包含制版/上版、调机与追色、正式印刷、洗车与维护等环节；数字印刷（如电摄影/喷墨）在短版作业中通常减少或免除实体制版与上版流程，但可能在设备预热/待机与耗材结构上呈现不同特征[8][9][10]。这导致两种工艺的“固定负荷—可变负荷”结构不同：胶印的固定准备负荷在小批量下难以摊薄，而在大批量下可显著下降；数字印刷在短版下更具灵活性，但单位能耗与耗材消耗对设备与工况敏感[8][10]。

文献普遍指出，结论对以下参数敏感：  
- **订单规模/印量**：可能出现工艺优劣反转的“交叉点”[8][9]；  
- **废品率与纸张利用率**：直接影响材料项；  
- **电耗与运行状态**：待机/预热/调机策略影响单位用电分摊；  
- **排放因子选择**：电力因子受区域与年份影响，纸张因子受纸种、系统边界与数据库版本影响[8][11][12]。

## 2.3 生产阶段数据项与常见数据来源

对“生产阶段CFP对比”而言，最小可答辩的数据项通常包括：纸张消耗、电耗与相应排放因子；可扩展数据项包括油墨/墨粉、版材、清洗剂/润版液及其处置等[8][10]。在数据来源方面：

- **电力因子（CFP口径）**：中国官方发布的全国电力碳足迹因子（kgCO2e/kWh）可直接用于产品碳足迹/LCA场景[5][15]。  
- **电力因子（CO2口径）**：官方发布的全国/区域/省级电力二氧化碳排放因子（kgCO2/kWh）可用于地区差异的敏感性对照，但不能与CO2e口径混用[6][16]。  
- **印刷电耗**：公开研究提供不同工艺的能耗强度区间（kWh/tonne printed products），可在缺少实测时折算为功能单位电耗并作为可追溯〔占位〕[8]。  
- **纸张因子**：行业报告与期刊研究给出不同纸种的cradle-to-gate量级，可用于候选值与敏感性边界；例如Two Sides报告给出“Coated Free”在cradle-to-gate下的行业平均全球变暖指标（可折算为kgCO2e/kg）[11]，BioResources研究给出跨纸种的加权平均与范围用于量级校验[12]。同时，历史研究提示中美供应链在特定口径下可能存在显著差异，但该类来源往往存在边界截断或仅CO2口径限制，不能直接替代CFP因子[13]。

## 2.4 现有研究不足与本文切入点

综合上述研究，可归纳如下不足：  
（1）对比边界与参数定义不透明，导致结论难以复现；  
（2）缺少“在数据缺口下仍可答辩”的工程化推进路径；  
（3）对不确定性披露不足，容易出现“以偏概全”的外推结论。

本文的切入点是：在本科论文周期内，以“可追溯〔占位〕+〔待核验〕标记+〔可替换〕接口”构建生产阶段V2对比模型，并通过敏感性与阈值分析给出结论稳健性与反转条件，从而在严格边界下形成可解释、可复算的对比结论。

## 2.5 本章小结

本章梳理了LCA/CFP标准体系与数字印刷/胶印对比研究的关键结论与敏感参数。文献表明结论高度依赖边界、印量与数据口径一致性。基于此，本文在后续章节将明确功能单位、系统边界与数据策略，采用纸张+电力的V2边界推进可答辩结果，并用敏感性与阈值分析管理不确定性。


---

# 第3章 研究方法（MASTER_r30）

> 版本：MASTER_r30（基于：第3章_研究方法_MASTER_r10.md；补强“部分CFP”披露、数据质量与阈值/敏感性设计）
> 生成日期：2026-02-28
> 结论边界：仅“碳足迹/气候变化维度（kgCO2e）”，不外推为“整体环境影响全面更优”。

## 3.1 方法学依据与总体框架

本文采用生命周期评价（LCA）框架开展产品碳足迹（CFP）核算与对比，方法学依据如下：  
- ISO 14040:2006：LCA原则与框架[1][17]  
- ISO 14044:2006：LCA实施要求与指南（数据质量、分配、解释与报告）[2][18]  
- ISO 14067:2018：产品碳足迹量化与报告要求，并允许在边界清晰披露的前提下开展部分CFP[3][19]；同时ISO官网显示该标准存在修订工作稿（WD）信息，本文将记录访问日期并在“版本状态”处留痕[20]  
- GHG Protocol Product Standard：产品层级核算与报告补充框架（不替代ISO主线）[4]

研究输出仅用于气候变化维度（kgCO2e）比较，其余环境影响类别不在本文结论范围内。

## 3.2 目标与范围界定（Goal & Scope）

### 3.2.1 研究目标

在统一功能单位与边界下，对数字印刷与胶印在生产阶段的碳足迹进行量化对比，识别贡献结构与不确定性来源，并形成可复算、可追溯、〔可替换〕的工程化模型。

### 3.2.2 功能单位（Functional Unit）

**1000张A4双面四色宣传单（157g铜版纸，单页，成品质量一致）**。  
结果表达为：kgCO2e/1000张，并可换算为gCO2e/张。

### 3.2.3 情景设定（Scenario）

S1：小批量对比情景  
- 数字印刷 vs 传统平张胶印  
- 产品规格、纸张类型与克重、色数、单双面一致  
- 对比目标：在一致功能单位下比较生产阶段碳足迹差异

### 3.2.4 系统边界（System Boundary）与“部分CFP”披露

为在本科论文周期内形成可答辩的最小可行模型（MVP→V2），本文当前采用“混合边界”的生产阶段核算（V2）：

- **纸张项（材料上游）**：以cradle-to-gate纸张排放因子计入（材料生产相关排放）  
- **电力项（生产用电）**：以gate-to-gate电耗×电力因子计入（印刷生产用电）  
- **未纳入项（当前阶段）**：油墨/墨粉、版材、清洗剂/润版液、印前/印后、设备制造与报废等——统一标注“〔待补〕/〔待核验〕”，并在第4章与第5章局限性中显式披露，不以猜测填数。

该处理符合ISO 14067对边界透明披露的要求：当开展部分CFP时，必须明确范围限制与缺失项，避免结果被误解为完整产品生命周期结论[3]。

### 3.2.5 截断规则与分配原则（Cut-off & Allocation）

- **截断规则**：V2边界仅纳入纸张与电力两项；未纳入项按0处理但必须披露缺口与潜在影响方向。  
- **分配原则**：若后续引入“车间总电表/多作业共用能源”等数据，优先采用可复算的物理基准分配（作业时间×功率、或按产量/纸张质量占比）；如需经济分配，应说明依据并进行敏感性讨论[2]。

### 3.2.6 系统边界图（V2）

```
上游材料（cradle-to-gate）                     生产阶段（gate-to-gate）
┌───────────────────┐                      ┌──────────────────────────┐
│ 157g铜版纸生产（CWF） │── m_paper×EF_paper ─▶│ 印刷生产用电 E_elec×EF_grid │
└───────────────────┘                      └──────────────────────────┘
                 ▲                                         ▲
                 └────────── 本研究V2纳入项：纸张 + 电力 ────────┘

未纳入项：油墨/墨粉、版材、清洗剂/润版液、印前/印后、设备制造与报废等（统一“〔待补〕/〔待核验〕”并在第4/5章披露）
```

## 3.3 清单分析（LCI）：活动数据与排放因子

### 3.3.1 活动数据（Activity Data）

V2模型活动数据项（绑定到Excel输入页“02_活动数据输入”）：
- 纸张消耗量（kg/1000张）：数字印刷、胶印分别取值  
- 电耗（kWh/1000张）：数字印刷、胶印分别取值（可被实测/手册替换）

### 3.3.2 电耗数据策略：可追溯〔占位〕 + 〔可替换〕接口

当无法获得企业实测/设备手册电耗值时，本文采用公开研究给出的能耗强度区间（kWh/tonne printed products）并折算到功能单位，作为“可追溯〔占位〕”；同时在Excel中保留“实测/手册优先”的输入位，后续仅需替换两项电耗即可升级模型[8]。该策略用于保证推进不被数据缺口阻塞，但在答辩中必须明确其代表性限制。

### 3.3.3 排放因子策略：主线与敏感性

- **电力因子（主线，CFP口径）**：采用官方发布的2024年全国电力平均碳足迹因子（kgCO2e/kWh）[5][15]。  
- **电力因子（对照，CO2口径）**：采用官方发布的2023年全国/区域/省级电力二氧化碳排放因子（kgCO2/kWh）用于地区差异敏感性对照，必须在正文注明“仅CO2，不等同CO2e/CFP口径”[6][16]。  
- **纸张因子（主线/备选/扩展）**：主线=1.29、中国备选=1.49（当前均为〔占位〕，标“〔待核验〕”）；扩展敏感性采用Two Sides对“Coated Free/CWF”给出的cradle-to-gate行业平均折算值1.619 kgCO2e/kg（可追溯）[11]，并用BioResources给出的跨纸种范围作量级校验[12]。

## 3.4 影响评价与计算方法（LCIA：气候变化维度）

本文在气候变化维度下采用“活动数据×排放因子”的核算方式：

- 纸张项：\(CF_{paper} = m_{paper} \times EF_{paper}\)  
- 电力项：\(CF_{elec} = E_{elec} \times EF_{grid}\)  
- 合计：\(CF_{total} = CF_{paper} + CF_{elec}\)

其中：  
- \(m_{paper}\)：纸张消耗（kg/1000张）  
- \(EF_{paper}\)：纸张排放因子（kgCO2e/kg）  
- \(E_{elec}\)：电耗（kWh/1000张）  
- \(EF_{grid}\)：电力因子（kgCO2e/kWh，主线）

## 3.5 不确定性、敏感性与阈值分析设计

### 3.5.1 数据质量与可追溯性要求

- **可追溯**：每个因子/数据项在Excel“06_数据来源留痕”记录来源、口径、获取日期与备注。  
- **可复算**：关键换算（短吨→kg、吨→功能单位电耗折算等）保留公式链路或附录。  
- **〔可替换〕**：对电耗保留实测/手册输入位，替换后可自动联动复算。

### 3.5.2 纸张因子敏感性

在保持活动数据不变时，切换三档纸张因子情景：  
- S_paper_1：1.29（主线，〔占位〕〔待核验〕）  
- S_paper_2：1.49（中国备选，〔占位〕〔待核验〕）  
- S_paper_3：1.619（Two Sides CWF，扩展敏感性，可追溯）[11]

### 3.5.3 阈值分析（反转条件）

在V2边界下，两工艺总碳足迹差异可写为：  
\(\Delta CF = (\Delta m \times EF_{paper}) + (\Delta kWh \times EF_{elec})\)

当\(\Delta CF=0\)时，胶印电耗阈值：  
\(kWh_{offset}^* = kWh_{digital} - (\Delta m \times EF_{paper})/EF_{elec}\)

阈值分析用于答辩解释“结论为何成立、何时可能不成立”，并指导后续最优先补齐的数据项（电耗实测/手册值）。

## 3.6 模型实现与版本管理（工程化约束）

核算模型使用Excel实现（目录：03_核算模型/），采用单主线MASTER链管理版本。写作与模型通过证据矩阵绑定（目录：04_证据矩阵/），确保“论点—证据—章节”可追溯与可审计。

## 3.7 本章小结

本章明确了功能单位、系统边界、截断与数据策略，并给出V2边界下的核算公式、敏感性与阈值分析设计。下一章将基于该方法输出基线结果并讨论不确定性与局限性。


---

# 第4章 核算结果与讨论（MASTER_r30）

> 版本：MASTER_r30（基于：第4章_核算结果_MASTER_r12.md；补强讨论结构与与Excel阈值区一致）
> 生成日期：2026-02-28
> 对比边界：仅“碳足迹/气候变化维度（kgCO2e）”。

## 4.1 关键参数与数据状态

本章结果对应的功能单位与边界见第3章。当前V2核算仅纳入纸张与电力两项，其他贡献项在本章末尾作为局限披露。

**表4-1 关键参数（S1小批量，V2边界）**

| 参数 | 数字印刷 | 胶印 | 说明/数据状态 |
|---|---:|---:|---|
| 纸张消耗 (kg/1000张) | 9.89 | 10.58 | 当前为模型输入/估算；可随废品率与工艺参数更新 |
| 电耗 (kWh/1000张) | 6.13 | 9.73 | 文献区间折算〔占位〕（〔可替换〕为实测/手册）[8] |
| 电力碳足迹因子 (kgCO2e/kWh) | 0.5777 | 0.5777 | 中国官方2024全国平均CFP因子[5][15] |
| 纸张因子（主线）(kgCO2e/kg) | 1.29 | 1.29 | 已冻结主线值，来源仍需补齐（〔待核验〕） |
| 纸张因子（中国备选）(kgCO2e/kg) | 1.49 | 1.49 | 仅用于敏感性（〔待核验〕） |
| 纸张因子（扩展敏感性）(kgCO2e/kg) | 1.619 | 1.619 | Two Sides “Coated Free/CWF”折算值[11] |

## 4.2 基线结果（主线纸张因子=1.29）

基线结果为“纸张+电力”两项之和，结果仅用于气候变化维度比较。

**表4-2 基线核算结果（纸张因子=1.29）**

| 工艺 | 纸张排放 (kgCO2e) | 电力排放 (kgCO2e) | 合计 (kgCO2e/1000张) |
|---|---:|---:|---:|
| 数字印刷 | 12.76 | 3.54 | **16.30** |
| 胶印 | 13.65 | 5.62 | **19.27** |
| 差值（胶印−数字） | 0.89 | 2.08 | **2.97** |

### 4.2.1 贡献结构与差异来源

- 纸张项占比：数字印刷约78%，胶印约71%。  
- 差异拆解：纸张消耗差异贡献约0.89 kgCO2e/1000张；电耗差异贡献约2.08 kgCO2e/1000张（约占总差值70%）。

该结果与印刷产品“材料项往往占主导、能源项决定差异方向”的经验认识一致[8][10]。因此，后续改进优先级应聚焦：**电耗真实水平**与**纸张消耗/废品率**。

## 4.3 纸张因子敏感性（1.29 vs 1.49 vs 1.619）

在保持活动数据（纸张消耗、电耗）不变时，仅切换纸张排放因子，得到如下结果。

**表4-3 纸张因子敏感性结果（合计=纸张+电力）**

| 纸张因子 (kgCO2e/kg) | 数字印刷合计 | 胶印合计 | 差值（胶印−数字） |
|---:|---:|---:|---:|
| 1.29（主线） | 16.30 | 19.27 | 2.97 |
| 1.49（中国备选） | 18.28 | 21.39 | 3.11 |
| 1.619（Two Sides CWF） | 19.55 | 22.75 | 3.20 |

可以看到：在纸张因子1.29–1.619范围内，结论方向保持一致，差值稳定在约3.0–3.2 kgCO2e/1000张，说明在本研究活动数据条件下结论对纸张因子不确定性具有一定稳健性。与此同时，纸张因子仍决定总量水平，且主线/中国备选当前为“〔待核验〕”，必须在论文中保持透明披露。

## 4.4 结论反转的条件（阈值分析，面向答辩）

在V2边界下（仅纸张+电力），两工艺总碳足迹差异可写为：

\(\Delta CF = (\Delta m \times EF_{paper}) + (\Delta kWh \times EF_{elec})\)

其中\(\Delta m\)为胶印与数字印刷的纸张消耗差异（kg/1000张），\(\Delta kWh\)为电耗差异（kWh/1000张）。
本研究主线采用\(EF_{paper}=1.29\)（〔待核验〕）与\(EF_{elec}=0.5777\)（2024全国电力平均碳足迹因子）[5][15]。

以本研究当前基线活动数据为例（数字：m=9.89、kWh=6.13；胶印：m=10.58、kWh=9.73）：
- \(\Delta m = 0.69\) kg/1000张 → 纸张项“劣势”=0.69×1.29=0.89 kgCO2e  
- 若要使两工艺总量相等（\(\Delta CF=0\)），胶印电耗需满足阈值：  
  \(kWh_{offset}^* = kWh_{digital} - (\Delta m\times EF_{paper})/EF_{elec}\)  
  代入可得：\(kWh_{offset}^* \approx\) **4.59 kWh/1000张**

解释（用于答辩）：
- 当前胶印电耗〔占位〕为9.73 kWh/1000张，显著高于4.59，因此在V2边界与当前参数下结论方向不易因“纸张差异”而反转。  
- 阈值推导表明差值高度依赖电耗真实水平；若取得设备手册或实测电表数据，应优先替换电耗并复算表4-2至表4-4。  

> 注意：阈值分析仅适用于“纸张+电力”两项，未纳入油墨/版材/清洗剂等潜在贡献项；仅用于解释V2模型下差值来源与不确定性。

## 4.5 电力因子不确定性（CFP主线 + CO2口径对照）

主线核算使用CFP口径（kgCO2e/kWh）[5][15]。为展示地区差异可能导致的结果变化范围，本文引用官方发布的CO2口径区域/省级电力因子（kgCO2/kWh）作为**对照敏感性**[6][16]，并在解释中明确该口径不等同于CO2e/CFP口径，不能与主线结果直接混用。该对照的目的仅在于提示：若研究对象电力结构显著不同，电力项可能发生系统性偏移，需在后续版本中进一步获取匹配的电力因子或开展本地化建模。

## 4.6 局限性与后续升级路径（必须披露）

1) 本研究当前仅纳入纸张与电力两项，油墨/墨粉、版材、清洗剂/润版液、印前/印后与设备制造等未纳入；结论只能解释本边界下的差异。  
2) 电耗为文献区间折算〔占位〕，代表性受设备型号、工况、订单组织与待机策略影响；若取得实测/手册数据，需用MASTER链替换并复算。  
3) 纸张因子主线/中国备选仍处于“〔待核验〕”状态；目前通过Two Sides等公开来源提供扩展敏感性边界，但不替代对本土情境EPD/数据库的进一步锁定。

## 4.7 本章小结

在“纸张+电力”的V2边界下，数字印刷的碳足迹低于胶印（差值约2.97 kgCO2e/1000张），且在纸张因子1.29–1.619范围内结论方向保持一致。对比差异主要由电耗差异驱动，因此电耗实测/手册值是后续最优先补齐的数据项；同时纸张因子需要进一步核验以提升总量的可信度与可解释性。


---

# 第5章 结论与展望（MASTER_r30）

> 版本：MASTER_r30（基于：第5章_结论与展望_MASTER_r12.md；与第4章MASTER_r30一致化并补强“边界—结论”表述）
> 生成日期：2026-02-28
> 结论边界：仅“碳足迹/气候变化维度（kgCO2e）”。

## 5.1 主要结论（严格边界下）

在统一功能单位（1000张A4双面四色宣传单，157g铜版纸）与V2边界（纸张cradle-to-gate + 电力gate-to-gate）下，本文得到以下结论：

1) **基线对比结论（主线纸张因子=1.29）**：数字印刷碳足迹为16.30 kgCO2e/1000张，胶印为19.27 kgCO2e/1000张，胶印−数字差值为2.97 kgCO2e/1000张（胶印更高）。该结论仅适用于本文边界与数据条件，不得外推为“整体环境影响全面更优”。

2) **贡献结构结论**：两工艺碳足迹均以纸张项为主（约70%–80%）；但在本研究当前数据条件下，“工艺差值”主要由电耗差异驱动（约占差值70%）。因此电耗数据的准确性是决定结论可信度的关键。

3) **稳健性结论（纸张因子敏感性）**：在纸张因子1.29/1.49/1.619范围内，对比结论方向保持一致（差值约3.0–3.2 kgCO2e/1000张），说明在当前活动数据条件下结论对纸张因子不确定性具有一定稳健性；但纸张因子仍需进一步核验以保证总量水平可信。

4) **反转条件结论（阈值分析）**：在V2边界下，若胶印电耗降低至约4.59 kWh/1000张（其余参数不变），两工艺总量可接近相等。该结论用于答辩解释“何时可能反转”，并指向后续最优先补齐的两项数据：数字印刷/胶印的实际电耗。

## 5.2 研究不足与局限（必须披露）

1) **边界局限**：油墨/墨粉、版材、清洗剂/润版液、印前/印后与设备制造等项未纳入，可能改变总量与贡献结构；因此本文结论仅解释V2边界内差异。  
2) **电耗数据局限**：电耗采用文献区间折算〔占位〕，代表性受设备型号、工况、订单组织与待机策略影响；必须在后续用实测/手册数据替换并复算。  
3) **纸张因子来源局限**：主线1.29与中国备选1.49仍为“〔待核验〕”；Two Sides折算值用于扩展敏感性边界，不等同于本土情境权威因子锁定。  
4) **情景局限**：本文目前聚焦S1小批量情景；文献表明印量/批量可能导致结论变化甚至反转，后续需扩展到多印量情景并引入固定负荷摊销机制[8][9]。

## 5.3 实践启示（在边界内的谨慎表述）

- 对短版/小批量作业而言，本研究结果提示：若电耗与废品率保持当前水平，数字印刷在生产阶段V2边界下具有较低碳足迹。  
- 对胶印而言，降低单位电耗与减少调机废张/废品率是缩小差距的关键路径；阈值分析提供了“电耗需要降低到什么量级”这一答辩友好的解释工具。  
- 对材料管理而言，纸张项贡献高，说明“纸张利用率与纸张因子来源”对总量水平影响显著，必须进行证据链锁定与敏感性披露。

> 上述启示均仅限“碳足迹/气候变化维度”与本文V2边界，不得推广为全面环境表现评价。

## 5.4 后续工作建议（按优先级、可落地）

1) **最优先：补齐两类电耗数据（2个数即可升级）**  
   - 数字印刷：kWh/1000张（设备手册或电表实测）  
   - 胶印：kWh/1000张（设备手册或电表实测）  
   替换后复算表4-2至表4-4与阈值分析。

2) **第二优先：锁定纸张因子到可追溯来源**  
   获取与“涂布印刷纸/铜版纸”匹配的公开EPD或数据库条目（A1-A3/cradle-to-gate），把主线/备选从“〔待核验〕”升级为“已核验”。

3) **第三优先：扩展贡献项（保持版本链）**  
   按顺序补齐：油墨/墨粉 → 版材 → 清洗剂/润版液 → 印前/印后 → 设备制造寿命分摊。每增加一项，都沿MASTER链升级，并在证据矩阵中补齐来源、口径与边界说明。

4) **第四优先：扩展多印量情景（S2/S3…）**  
   引入固定负荷摊销（制版/调机/待机）与印量变量，识别“交叉点”并与文献结论对照，以增强研究的普适解释力。

## 5.5 本章小结

本文以工程化可追溯方式完成了数字印刷与胶印在生产阶段的碳足迹对比，并通过敏感性与阈值分析明确了结论的关键驱动因素与最小数据补齐路径。后续应优先补齐电耗实测/手册值与纸张因子权威来源，以提升答辩可靠性与可解释性。


---

# 参考文献列表（GB/T 7714-2015，MASTER_r30）

[1] ISO. ISO 14040:2006. Environmental management — Life cycle assessment — Principles and framework[S]. Geneva: ISO, 2006.

[2] ISO. ISO 14044:2006. Environmental management — Life cycle assessment — Requirements and guidelines[S]. Geneva: ISO, 2006.

[3] ISO. ISO 14067:2018. Greenhouse gases — Carbon footprint of products — Requirements and guidelines for quantification[S]. Geneva: ISO, 2018.

[4] World Resources Institute; World Business Council for Sustainable Development. Product Life Cycle Accounting and Reporting Standard[EB/OL]. (2011)[2026-02-28]. https://ghgprotocol.org/sites/default/files/standards/Product-Life-Cycle-Accounting-Reporting-Standard_041613.pdf

[5] 生态环境部; 国家统计局; 国家能源局. 关于发布2024年电力碳足迹因子数据的公告[EB/OL]. (2025-10-23)[2026-02-28]. https://www.mee.gov.cn/xxgk2018/xxgk/xxgk01/202510/t20251024_1130734.html

[6] 生态环境部; 国家统计局. 关于发布2023年电力二氧化碳排放因子的公告[EB/OL]. (2025-12-31)[2026-02-28]. https://www.mee.gov.cn/xxgk2018/xxgk/xxgk01/202512/t20251231_1139517.html

[7] Viluksela P, Kariniemi M, Nors M. Environmental performance of digital printing: Literature study[R/OL]. Espoo: VTT Technical Research Centre of Finland, 2010 (VTT Research Notes 2538). [2026-02-28]. https://publications.vtt.fi/pdf/tiedotteet/2010/T2538.pdf

[8] Pihkola H, Nors M, Kujanpää M, Helin T, Kariniemi M, Pajula T, et al. Carbon footprint and environmental impacts of print products from cradle to grave: Results from the LEADER project (Part 1)[R/OL]. Espoo: VTT Technical Research Centre of Finland, 2010 (VTT Research Notes 2560). [2026-02-28]. https://publications.vtt.fi/pdf/tiedotteet/2010/T2560.pdf

[9] Strecker T, Lesage P. Environmental Life Cycle Assessment of Commercial Analog and Digital Printing[C/OL]//Proc. IS&T Int'l Conf. on Digital Printing Technologies and Digital Fabrication (NIP26). 2010:97-101. DOI:10.2352/ISSN.2169-4451.2010.26.1.art00026_1. [2026-02-28]. https://library.imaging.org/print4fab/articles/26/1/art00026_1

[10] Larsen H F, Hansen M S, Hauschild M Z. Life cycle assessment of offset printed matter with EDIP97: how important are emissions of chemicals?[J]. Journal of Cleaner Production, 2009, 17(2):115-128. DOI:10.1016/j.jclepro.2008.03.006.

[11] Two Sides North America. Printing & Writing Papers – Life-Cycle Assessment Summary Report[R/OL]. (2012-02-14)[2026-02-28]. https://twosidesna.org/wp-content/uploads/sites/16/2018/05/Printing_and_Writing_Papers_-_Life-Cycle_Assessment_Summary_Report.pdf

[12] Tomberlin K E, Venditti R, Yao Y. Life cycle carbon footprint analysis of pulp and paper grades in the United States using production-line-based data and integration[J/OL]. BioResources, 2020, 15(2):3899-3914. [2026-02-28]. https://bioresources.cnr.ncsu.edu/resources/life-cycle-carbon-footprint-analysis-of-pulp-and-paper-grades-in-the-united-states-using-production-line-based-data-and-integration/

[13] Vos R O, Newell J. A Comparative Analysis of Carbon Dioxide Emissions in Coated Paper Production: Key Differences between China and the U.S.[R/OL]. 2009. [2026-02-28]. https://urbansustainability.seas.umich.edu/wp-content/uploads/2014/08/2009_Vos-and-Newell_A-Comparative-Analysis-of-Carbon-Dioxide-Emissions-in-Coated-Paper-Production.pdf

[14] Kariniemi M, Nors M, Kujanpää M, Pajula T, Pihkola H. Evaluating Environmental Sustainability of Digital Printing[C/OL]//Proc. IS&T Int'l Conf. on Digital Printing Technologies and Digital Fabrication (NIP26). 2010:92-96. DOI:10.2352/ISSN.2169-4451.2010.26.1.art00025_1. [2026-02-28]. https://library.imaging.org/print4fab/articles/26/1/art00025_1

[15] 生态环境部; 国家统计局; 国家能源局. 2024年全国电力碳足迹因子（公告附件）[EB/OL]. (2025-10-23)[2026-02-28]. https://big5.mee.gov.cn/gate/big5/www.mee.gov.cn/xxgk2018/xxgk/xxgk01/202510/W020251024569470952545.pdf

[16] 生态环境部; 国家统计局. 2023年电力二氧化碳排放因子（公告附件）[EB/OL]. (2025-12-31)[2026-02-28]. https://www.mee.gov.cn/xxgk2018/xxgk/xxgk01/202512/W020251231726284332528.pdf

[17] ISO. ISO 14040:2006 - Environmental management — Life cycle assessment — Principles and framework[EB/OL]. (2006)[2026-02-28]. https://www.iso.org/standard/37456.html

[18] ISO. ISO 14044:2006 - Environmental management — Life cycle assessment — Requirements and guidelines[EB/OL]. (2006)[2026-02-28]. https://www.iso.org/standard/38498.html

[19] ISO. ISO 14067:2018 - Greenhouse gases — Carbon footprint of products — Requirements and guidelines for quantification[EB/OL]. (2018)[2026-02-28]. https://www.iso.org/standard/71206.html

[20] ISO. ISO/WD 14067 - Greenhouse gases — Carbon footprint of products — Requirements and guidelines for quantification[EB/OL]. (2026-02-28)[2026-02-28]. https://www.iso.org/standard/90578.html

# 附录A 关键参数与公式一览（MASTER_r30）

> 目的：将答辩最常被问到的“你到底算了什么/怎么算的/哪些是〔待补〕”的信息集中列出，便于核对。

## A.1 功能单位与情景
- 功能单位：1000张A4双面四色宣传单（157g铜版纸，单页，成品质量一致）
- 情景：S1 小批量（数字印刷 vs 平张胶印）
- 结论边界：仅“碳足迹/气候变化维度（kgCO2e）”

## A.2 V2 边界纳入项
- 纸张：cradle-to-gate（材料上游，采用纸张排放因子）
- 电力：gate-to-gate（生产用电，电耗×电力因子）
- 未纳入项：油墨/墨粉、版材、清洗剂/润版液、印前/印后、设备制造与报废等（统一“〔待补〕/〔待核验〕”）

## A.3 核算公式（V2）
- 纸张排放：CF_paper = m_paper × EF_paper
- 电力排放：CF_elec = E_elec × EF_grid
- 合计：CF_total = CF_paper + CF_elec

## A.4 阈值（反转条件）公式
在固定数字印刷参数不变、仅改变胶印电耗的情况下，令两工艺总量相等（CF_offset = CF_digital），胶印电耗阈值为：  
kWh*_offset = kWh_digital − ((m_offset − m_digital) × EF_paper) / EF_grid

---

# 附录B 〔待核验〕/〔待补〕清单（MASTER_r30）

1) 纸张因子主线 1.29（国际基准）：来源需补齐到可追溯数据库/EPD/论文（当前保持“〔待核验〕”）  
2) 纸张因子中国备选 1.49：来源需补齐（当前保持“〔待核验〕”）  
3) 电耗：当前为公开文献区间折算〔占位〕（〔可替换〕为设备手册/实测电表值）  
4) 若需“区域/省级 CFP 口径（kgCO2e/kWh）”电力因子：目前缺口，需权威发布或数据库支持（不能用CO2口径冒充CO2e）


# 附录A 关键参数与公式（便于答辩复核）
## A.1 功能单位与情景
- 功能单位：1000张A4双面四色宣传单（157g铜版纸，单页，成品质量一致）
- 情景：S1 小批量（数字印刷 vs 胶印）
- 结论边界：仅“碳足迹/气候变化维度（kgCO2e）”比较，不外推为“整体环境影响全面更优”。

## A.2 电耗〔占位〕与〔可替换〕规则（不阻塞写作）
- 当前电耗：采用公开文献区间折算得到的〔占位〕值（用于答辩解释“为何暂用〔占位〕”）
- 〔可替换〕：若后续获得设备手册/实测电表，仅需替换2个值（数字/胶印 kWh/1000张）即可更新整篇结果。

## A.3 纸张因子开关与敏感性
- 主线：1.29 kgCO2e/kg（〔待核验〕来源，保留为口径冻结值）
- 中国备选：1.49 kgCO2e/kg（〔待核验〕来源，作为敏感性）
- 扩展敏感性：1.619 kgCO2e/kg（行业报告Two Sides Coated Free换算值；用于检验结论稳健性）

# 附录B 〔待核验〕清单（提交前必须逐条确认）
> 说明：为避免“AI编造/来源不实”风险，本清单把所有高风险点显式列出，逐条打钩后再提交。
1) 纸张因子 1.29/1.49 的权威来源：需要补充可追溯出处（数据库/EPD/行业报告/论文）；未补齐前，正文与表格必须保留“〔待核验〕”标记。
2) 电耗〔占位〕的文献来源与换算：核对文献表述单位（kWh/tonne）与换算过程；确保正文写清“〔占位〕、〔可替换〕、局限”。
3) 电力碳足迹因子（kgCO2e/kWh）采用年份与来源：核对公告/附件PDF标题、年份、引用日期。
4) 所有参考文献条目：作者/年份/题名/载体/页码/DOI/URL 是否完整；不确定的全部标“〔待核验〕”，不可补写猜测信息。
5) 图表编号与引用一致性：表4-1/4-2/… 在全文是否唯一、正文是否引用到。
6) 论文结论措辞边界：不得出现“总体更环保/整体环境更优”等外推表述。

# 附录C 使用工具与贡献说明（可选，按学校要求取舍）
> 目的：降低学术诚信风险。若学校/导师要求披露AI辅助，可使用本段；若不允许AI，则删除并确保全文由作者独立完成。
- 本研究在资料检索与写作组织中使用了辅助工具（如检索/摘要/语言润色），但**所有结论、参数取值、计算过程与参考文献条目均由作者核对并对其真实性负责**。
- 对于无法核验的数据/文献，本论文明确标注“〔待核验〕/〔待补〕”，不以推测替代证据。


# 附录D 研究过程记录（基于本项目文档，可核验）
说明：本段不虚构“企业实测/实习经历”。仅把本项目已有文档与模型的事实流程写成可答辩叙述，便于解释数据来源与决策。

1. 目标与边界：按ISO 14040/14044的LCA框架，并在ISO 14067产品碳足迹口径下，限定比较维度为“气候变化/碳足迹（kgCO2e）”。
2. 功能单位：1000张A4双面四色宣传单（157g铜版纸），确保两工艺成品质量与规格一致。
3. 系统边界：生产阶段为主（材料端纸张cradle-to-gate + 印刷过程用电gate-to-gate），并在正文中对未纳入项（油墨/版材/清洗剂等）做局限披露。
4. 活动数据：纸张消耗量以成品规格推算并纳入废品率假设；电耗在无法获得实测时采用公开文献区间折算〔占位〕，并明确“〔可替换〕”。
5. 排放因子：电力主线采用官方发布的电力碳足迹因子（kgCO2e/kWh）；纸张因子设置主线/备选开关并做敏感性分析，所有来源不确定处标“〔待核验〕”。
6. 不确定性/敏感性：至少执行纸张因子（1.29 vs 1.49）与电力因子（全国/区域/省级对照）敏感性，报告对结论稳健性的影响。
7. 可追溯：用证据矩阵绑定“论点—证据—章节落点”，并在参考文献中保留‘〔待核验〕’条目，避免猜测补写。


# 附录E 答辩准备（MASTER_r30）
- 答辩讲稿提纲：见 DR18_答辩讲稿提纲_MASTER_r30.md
- 高频质询Q&A：见 DR19_高频质询Q&A_MASTER_r30.md
- 举证快照清单：见 DR16_参考文献举证快照清单_MASTER_r23.md


# 附录F 参考文献举证文件（MASTER_r30）
- 统一举证页：refs_evidence_sheets_MASTER_r30.pdf（放 99_留痕与截图/refs/）
- 原文PDF（若已下载）：见 DR24_举证包生成报告_MASTER_r30.md


# 附录G 终稿提交说明（MASTER_r30）
- 终稿提交文件以Word版为准：论文全文_学校规范排版稿_MASTER_r30.docx。
- 参考文献举证材料：refs_evidence_sheets_MASTER_r27.docx + ref*.png + refs_index_MASTER_r27.csv（存 99_留痕与截图/refs/）。


# 附录I 答辩速记卡（MASTER_r30）
1. 一句话：本研究在明确功能单位与系统边界下，对比数字印刷与胶印生产阶段碳足迹（kgCO2e），并用敏感性分析检验结论稳健性。
2. 边界：仅生产阶段（纸张cradle-to-gate + 用电gate-to-gate），仅气候变化维度，不外推整体环境优越。
3. 数据状态：电耗为公开文献折算〔占位〕且〔可替换〕；纸张因子部分〔待核验〕并已做敏感性。
4. 被问‘为什么不用实测’：拿不到权限/时间；但模型保留接口，未来可替换升级。
5. 被问‘结论能推广吗’：不能；仅对当前功能单位、边界、参数成立。

# 附录H/I 外置说明（MASTER_r30）
- 为保持终稿正文简洁，原“附录H终稿核对表”“附录I答辩速记卡”已外置为独立文件：
  - 终稿核对表_MASTER_r30.md
  - 答辩速记卡_MASTER_r30.md
- 放置位置见本次放置清单。
