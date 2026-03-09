# TECH_FEED_SOURCES · AI公司动态来源库（PATCH更新版）

> 📻 副轨泛听专用 | 每天10-15min | 禁止升级  
> 🎯 语言：English audio first | 主题：Product/Model/API Releases | 优先级：DeepSeek > OpenAI > Google

---

## 🎯 候选生成规则（每日自动应用）

### 优先级规则（必须遵守）
1. **第一优先**：DeepSeek 当天/近48h 的模型/产品/API 更新
2. **第二优先**：OpenAI 当天/近48h 的模型/产品/API 更新  
3. **第三优先**：Google（Gemini/Vertex/DeepMind）模型/产品/API 更新
4. **fallback**：最近7天内影响最大的发布（按公司优先级轮换）

### 去重与轮换
- **默认**：7天内同公司不连续两天（避免审美疲劳）
- **例外**：DeepSeek/OpenAI 有重大发布（major release）允许连续两天，但副轨时长仍锁死10-15min

### 候选格式（一致）
```
- Company: DeepSeek/OpenAI/Google
- Title: 一句话新闻标题
- Keywords: 3-5个关键词
- Type: Model/Product/API/Tooling
- Difficulty: S1（默认）/ S2（mood=ok且fatigue=no）
- Duration: 10-15min
```

---

## 🎧 A) Daily/Short (10-15min friendly)

| 来源 | 类型 | 搜索关键词 | 为什么适合 |
|------|------|-----------|-----------|
| **AI News Daily Podcast** | 播客 | "AI news daily podcast" | 每日5-10min，聚焦产品发布，语速适中 |
| **The Vergecast (clip)** | 播客片段 | "The Vergecast AI clip" | 科技新闻播客，可选片段，产品更新及时 |
| **CNBC TechCheck** | 视频/播客 | "CNBC TechCheck AI" | 商业视角产品发布，英语清晰，10min左右 |
| **MIT Technology Review** | 播客 | "MIT Tech Review AI podcast" | 权威技术解读，模型发布分析专业 |

---

## 🎧 B) Weekly/High-signal (用于周末补充)

| 来源 | 类型 | 搜索关键词 | 为什么适合 |
|------|------|-----------|-----------|
| **Lex Fridman Podcast (AI片段)** | 访谈 | "Lex Fridman OpenAI/Google/DeepSeek" | AI大佬深度访谈，可选30min片段 |
| **TWIML AI Podcast** | 播客 | "TWIML new model release" | 技术向，产品发布解读专业 |
| **Eye on AI** | 播客 | "Eye on AI podcast" | 专注AI行业动态，模型发布追踪及时 |
| **Latent Space** | 播客 | "Latent Space podcast" | 开发者视角，API/工具更新详解 |

---

## 🎧 C) Company-first (官方渠道 - 优先检查)

### DeepSeek (优先级 #1)
| 来源 | 类型 | 搜索关键词 | 为什么适合 |
|------|------|-----------|-----------|
| **DeepSeek Official Blog** | 文字/可转音频 | "deepseek.ai blog" | 官方发布，V3/R1模型更新第一时间 |
| **DeepSeek Twitter/X** | 文字/视频 | "@deepseek_ai" | 快速产品更新，API变动公告 |
| **DeepSeek Research** | 技术报告 | "DeepSeek research arxiv" | 模型架构更新，适合S2深度听 |

### OpenAI (优先级 #2)
| 来源 | 类型 | 搜索关键词 | 为什么适合 |
|------|------|-----------|-----------|
| **OpenAI Blog** | 文字/可转音频 | "openai.com/blog" | GPT/模型发布官方源 |
| **OpenAI Developer YouTube** | 视频 | "OpenAI Developer YouTube" | API更新、开发者大会 |
| **Sam Altman Twitter/X** | 文字/视频 | "@sama" | 产品发布预告，重大更新预告 |

### Google (优先级 #3)
| 来源 | 类型 | 搜索关键词 | 为什么适合 |
|------|------|-----------|-----------|
| **Google AI Blog** | 文字/可转音频 | "ai.googleblog.com" | Gemini/Vertex更新官方源 |
| **Google DeepMind Blog** | 文字 | "deepmind.google blog" | 研究模型发布，前沿动态 |
| **Made by Google** | 视频 | "Made by Google YouTube" | 产品发布会，Pixel/AI功能更新 |

---

## 📱 推荐获取工具

| 工具 | 用途 | 操作 |
|------|------|------|
| **YouTube** | 科技公司发布会、产品demo | 搜索 "DeepSeek V3 release" / "OpenAI GPT-4.5" |
| **Spotify** | 播客聚合 | 订阅 "AI News Daily" / "Eye on AI" |
| **ElevenLabs Reader** | 文字转音频 | 复制博客文章URL，AI朗读 |
| **Pocket Casts** | 播客管理 | 变速播放，标记片段 |

---

## 🔍 每日检查清单（生成候选前）

- [ ] 检查 DeepSeek 官方（blog/twitter）近48h更新
- [ ] 检查 OpenAI 官方（blog/twitter）近48h更新
- [ ] 检查 Google AI/DeepMind 官方近48h更新
- [ ] 若无更新，查最近7天内最大发布
- [ ] 确认7天内未重复同公司（重大发布除外）
- [ ] 应用难度规则：默认S1，mood=ok+fatigue=no才允许S2

---

## 🚫 严格泛听规则（必须遵守）

- ❌ **No subtitles** - 不看字幕
- ❌ **No pausing** - 不暂停
- ❌ **No notes during listening** - 听时不做笔记
- ❌ **No long summary** - 不写长总结
- ❌ **Max 0-3 terms** - 最多0-3个通用高频术语（默认=0）
- ❌ **No export transcript** - 不导出字幕
- ❌ **No over 15min** - 不超过15分钟

**只记录2字段**：
- `tech_listen_topic`: ≤6词
- `tech_listen_minutes`: 10-15

---

*TECH_FEED_SOURCES | PATCH更新：English Audio + Product Focus + Priority Rank*
