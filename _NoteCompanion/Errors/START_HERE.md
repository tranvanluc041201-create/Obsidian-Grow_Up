# CET-6 550 备考系统 · 每日入口

> 🎯 目标：CET-6 ≥ 550 | 模式：M（真题80%）+ L（听力优先）  
> 📅 模考日：每周六 | ⏰ 早读：07:30-08:10（40min）

---

## ⚙️ CONFIG（系统配置）

```yaml
# 基础配置
early_reading_start: 07:30
early_reading_minutes: 40
daily_extra_minutes: 60-75
mock_exam_day: Saturday
material_form: PDF+Audio
audio_storage: TabletNoteApp + WeChatTransfer
allow_headphones: YES
allow_speaking: NO
word_app: 不背单词（会员）
daily_start_date: TOMORROW

# 副轨配置（PATCH更新）
tech_audio_language: EN
tech_focus: PRODUCT_RELEASES
tech_company_priority: [DeepSeek, OpenAI, Google]
```

---

## 📍 每天必做（3个文件）

- [ ] **打开今日任务页**：`/10_English/11_CET6/01_Daily/YYYY-MM-DD.md`
- [ ] **打开不背单词**：只做「今日复习」8-12min（到点停）
- [ ] **打开音频材料**：平板笔记软件里今天的听力音频

---

## 🌅 早读40分钟 SOP（07:30开始）

### [听力16｜真题主轨]
- [ ] 打开材料：`{main_listening_material_id}`（音频+原文/解析）
- [ ] 盲听1遍：不暂停，只抓关键词
- [ ] 对照原文听1遍：标记3个"没听出来的点"
- [ ] 把3个错点写入 `listening_error_points`（每条含 time_or_keyword + 原文片段）
- [ ] 打字1句总结：`Today_Summary_1sent`

**✅ 完成标准**：`listening_error_points` 恰好3条

### [阅读16｜真题主轨]
- [ ] 打开材料：`{main_reading_material_id}`
- [ ] 计时做题（不查词）
- [ ] 每个错题写"依据句位置/关键定位词"（每题1行）
- [ ] 记录 `reading_errors_count` + `reading_error_tags`

**✅ 完成标准**：每个错题都有1行依据句记录

### [复习8｜不背单词]
- [ ] 打开不背单词 → 今日复习 → 计时 8-12min（到点停）
- [ ] 只做复习（不刷新词课表）
- [ ] 新增词规则：仅来自今天真题材料；新增上限 ≤12
- [ ] 记录：`word_review_done=true` + `new_words_added_count`

**✅ 完成标准**：`word_review_done=true`

---

## 🌙 晚上60-75分钟 SOP（听力优先）

### [主轨50-60｜真题听力]

**(1) 错点回放20**
- [ ] 对 `listening_error_points` 三条逐一执行：
  - 听3次（只盯那几个词/连读）
  - 看原文1次（把关键词抄/复制到页内）
  - 再听2次（遮住原文）
  - 记录该错点完成✅

**✅ 完成标准**：3条错点都完成✅

**(2) 精听静默跟读/打字复述20-25（不能开口版）**
- [ ] 播放句子→无声口型/脑内跟读（不出声）
- [ ] 每30-60秒暂停：打出1句复述（共2-3句）
- [ ] 保存复述：`Listening_Retell_2to3sent`

**✅ 完成标准**：至少2句复述

**(3) 真题式检验10-15**
- [ ] 遮住原文重听1遍
- [ ] 写：主旨1句 + 信息点≥2条（人/时间/因果/态度）
- [ ] 记录：`Listening_Check_pass=true/false`（≥2条则true）

**✅ 完成标准**：信息点≥2条

### [副轨10-15｜AI公司动态（严格泛听，不许升级）]

**🎯 今日候选**（按优先级自动生成）：
- **Company**: DeepSeek / OpenAI / Google（轮换优先）
- **Type**: Model / Product / API / Tooling
- **Difficulty**: S1（默认）/ S2（mood=ok且fatigue=no时允许）
- **Duration**: 10-15min

**执行清单**（必须勾选）：
- [ ] Open candidate (English audio)
- [ ] Timer 10-15min, **stop on time**
- [ ] No subtitles / No pause / No notes
- [ ] After finishing, record ONLY:
  - `tech_listen_topic`: _______（≤6词）
  - `tech_listen_minutes`: _______

**🔴 禁止项**：
- ❌ 禁止导字幕
- ❌ 禁止写长总结  
- ❌ 禁止加大量生词（最多0-3个通用高频术语，默认=0）
- ❌ 禁止超过15分钟

**降级规则**：若 `mood=annoyed` 或 `tired` 或 `fatigue=yes`：
- 强制 Difficulty=S1
- `tech_new_terms_added=0`（禁止新增术语）

---

## 😤 情绪预警按钮怎么用

当你把 `mood` 改成 `annoyed` 或 `tired` 时，系统会自动：

1. **明日晚间降级为"轻量版"**：
   - 错点回放20 + 检验10（共30min）
   - 其余可选，不强制

2. **启用"禁止扩张"**：
   - 当日 `new_words_added_count=0`（允许不新增）
   - 副轨强制 Difficulty=S1
   - `tech_new_terms_added=0`（禁止新增术语）

3. **副轨保持但锁死**：
   - 仍做技术泛听，但只选S1难度
   - 严格10-15min，到点停

**目的**：降级但不断更、不自责。

---

## 💥 MVP崩溃日（≤10min不断更）

当你真的没精力时，只做：

- [ ] **8min**：只做3条错点回放（听3→看→听2）
- [ ] **2min**：写1句英文总结保存
- [ ] 设置 `mood=annoyed` 或 `tired`；`mvp_done=true`

**✅ 完成标准**：不断更 + 最少字段填完

---

## 📚 真题推进策略

**核心原则**：同一套真题按顺序推进（避免每天换材料导致烦躁）

**推进顺序**：
1. 听力Section A → Section B → Section C
2. 阅读Passage 1 → Passage 2 → Passage 3
3. 完成整套后再开新套

**命名规则**：
```
CET6_YYYYMM_SetNN/
├── Listening.mp3
├── Transcript.md
├── Reading.pdf
├── Answer_Key.pdf
└── Writing_Translation.pdf
```

---

## 📂 资料整理

**存放路径**：`/10_English/11_CET6/_assets/CET6_YYYYMM_SetNN/`

**索引页**：`/10_English/11_CET6/_assets/index/CET6_INDEX.md`

| 套号ID | 日期 | 路径 | 状态 |
|--------|------|------|------|
| CET6_202312_Set01 | 2023年12月第1套 | `_assets/CET6_202312_Set01/` | 未做 |
| ... | ... | ... | ... |

---

## 📱 微信传输音频流程（电脑→平板）

**我手动点击路径**（≤6步）：

- [ ] **Step1**：在电脑找到本周音频包 `/10_English/11_CET6/_assets/_wechat_pack/`
- [ ] **Step2**：选中要传的 `.mp3` 文件 → 右键 → "发送到" → "微信文件传输助手"
- [ ] **Step3**：在平板上打开微信 → 文件传输助手
- [ ] **Step4**：点击音频文件 → "用其他应用打开" → 选择你的笔记软件
- [ ] **Step5**：在笔记软件里创建文件夹 `/CET6_听力/`
- [ ] **Step6**：保存音频，命名为 `CET6_SetNN_SectionX.mp3`

---

## 🤖 自动生成明日页（首选）

**自动方式**：每天完成今日页后，系统会自动生成明天的任务页 `/01_Daily/YYYY-MM-DD.md`

**包含内容**：
- 明日早读：默认推进"同一套真题的下一段/下一篇"
- 明日晚间：自动生成"错点回放清单"
- 复习提醒：不背单词只做今日复习；新增≤12
- 技术泛听候选：AI公司动态（不重复）

---

## 🔧 失败回退（如果无法自动生成）

**我手动操作**（≤5步）：

1. 复制今日页的 `listening_error_points` 三条
2. 粘贴到明日页 `listening_error_points`
3. 设置 `mood` / `fatigue` 字段
4. 在同页生成回放清单与副轨候选
5. 保存为明日日期文件名

---

## 📋 本周计划速查

| 日期 | 任务 |
|------|------|
| **周一** | 早读40 + 晚间60-75（听力优先） |
| **周二** | 早读40 + 晚间60-75（听力优先） |
| **周三** | 早读40 + 晚间60-75（听力优先） |
| **周四** | 早读40 + 晚间60-75（听力优先） |
| **周五** | 早读40 + 晚间60-75（听力优先） |
| **周六** | 🎯 **模考日**（130min严格计时） |
| **周日** | 📊 **周复盘**（10min） |

---

## 🚀 立刻开始

1. [ ] 检查 `/01_Daily/` 里是否有明天的任务页
2. [ ] 打开不背单词，完成今日复习
3. [ ] 打开音频材料，开始早读40min
4. [ ] 完成后在今日页勾选完成的任务

---

*最后更新：系统搭建完成 | 目标：CET-6 ≥ 550*
