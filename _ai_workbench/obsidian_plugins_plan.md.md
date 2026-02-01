## 📋 需要你手动操作的部分（含详细步骤）

### 任务 1️⃣：初始化 Git 仓库（约 5 分钟）

**为什么要做：** Git 是你的"撤销按钮"，配置前必须建立回滚点

**操作步骤：**

1. **打开终端/命令行**
    
    - Windows：按 `Win + R`，输入 `cmd` 或 `powershell`
    - Mac：按 `Cmd + Space`，输入 `Terminal`
2. **进入你的 Obsidian Vault 根目录**
    
    ```bash
    cd /path/to/your/vault
    # 例如：cd ~/Documents/MyObsidianVault
    ```
    
3. **初始化 Git 仓库**
    
    ```bash
    git init
    ```
    
    看到 "Initialized empty Git repository" 即成功
    
4. **创建 `.gitignore` 文件**（防止索引污染）
    
    ```bash
    # Windows (PowerShell)
    New-Item .gitignore -ItemType File
    
    # Mac/Linux
    touch .gitignore
    ```
    
5. **编辑 `.gitignore` 文件**  
    在任意文本编辑器中打开 `.gitignore`，复制以下内容：
    
    ```
    # Obsidian 工作区和缓存
    .obsidian/workspace.json
    .obsidian/workspace-mobile.json
    .obsidian/cache/
    
    # 系统文件
    .DS_Store
    .Trash-*/
    Thumbs.db
    
    # 日志文件
    *.log
    
    # Smart Connections 索引（防止大文件污染仓库）
    .smart-connections/
    smart-connections/
    embeddings/
    vector-db/
    index/
    
    # 其他 AI 插件缓存
    copilot-index/
    ai-cache/
    ```
    
6. **创建首次提交（回滚点）**
    
    ```bash
    git add .
    git commit -m "chore: initial vault snapshot before plugin config"
    ```
    
    看到 "X files changed" 即成功
    

**验证：** 在终端输入 `git status`，应显示 "nothing to commit, working tree clean"

---

### 任务 2️⃣：配置 Obsidian Git 自动提交（30 分钟间隔）

**为什么要做：** 实现你要求的"每 30 分钟自动 Git 提交"

**操作步骤：**

1. **打开 Obsidian 设置**
    
    - 点击左下角齿轮图标 ⚙️
    - 或按快捷键 `Ctrl/Cmd + ,`
2. **找到 Obsidian Git 插件**
    
    - 左侧菜单滚动到 "Community plugins" 区域
    - 点击 **Obsidian Git**
3. **配置自动备份**  
    定位到 **"Backup"** 部分，设置：
    
    |设置项|推荐值|说明|
    |---|---|---|
    |**Vault backup interval**|`30`|每 30 分钟自动提交|
    |**Auto pull interval**|`0`（关闭）|如果你不用多设备同步，关闭自动拉取|
    |**Commit message**|`vault backup: {{date}}`|自动生成提交消息|
    |**Auto backup after file change**|❌ 关闭|防止每次保存都提交（太频繁）|
    
4. **配置推送策略（可选）**  
    如果你未来想同步到 GitHub/GitLab，现在可以跳过，留空即可
    
5. **点击 "Save" 或直接关闭设置**  
    Obsidian Git 会自动应用配置
    

**验证：** 等待 30 分钟后，在终端运行 `git log`，应看到类似 "vault backup: 2026-02-01" 的自动提交记录

---

### 任务 3️⃣：配置 Smart Connections 索引范围

**为什么要做：** 避免 AI 从 `_ai_workbench/`、附件等无关目录抓取信息，减少噪声

**操作步骤：**

1. **打开 Obsidian 设置** → 找到 **Smart Connections** 插件
    
2. **定位到 "Folders" 或 "Exclusions" 设置**
    
    - 不同版本界面可能不同，找到包含 "folder"、"path"、"exclude" 关键词的选项
3. **设置纳入索引的目录**  
    在 **"Include folders"** 或 **"Source folders"** 中添加：
    
    - `项目笔记/`
    - `学习笔记/`
    - `工作日志/`
    
    **注意：** 如果插件默认索引全部目录，则跳到下一步"排除目录"
    
4. **设置排除目录**  
    在 **"Exclude folders"** 或 **"Excluded paths"** 中添加：
    
    - `_ai_workbench/`
    - `.obsidian/`
    - `attachments/`（或你的附件目录名）
    - `templates/`
    - `archive/`
5. **调整结果设置**
    
    |设置项|推荐值|理由|
    |---|---|---|
    |**Connections results type**|**Sources**|显示整个笔记，避免碎片化|
    |**Lookup results type**|**Blocks**|查找时定位到具体段落|
    |**Results limit**|**20**|平衡结果数量和质量|
    
6. **重建索引**
    
    - 找到 **"Rebuild Index"** 或 **"Reindex"** 按钮（通常在设置页底部）
    - 点击后等待 3-10 分钟（取决于笔记数量）
    - **重要：** 索引过程中可能会卡顿，建议在不工作时执行

**验证：** 打开一篇核心笔记，点击右侧 Smart Connections 面板，检查推荐笔记是否来自你允许的三个目录

---

### 任务 4️⃣：创建配置文档（约 3 分钟）

**为什么要做：** 未来重装/迁移 Obsidian 时，直接参考这份文档快速复现配置

**操作步骤：**

1. **在 Obsidian 中创建新笔记**
    
    - 进入 `_ai_workbench/` 文件夹
    - 按 `Ctrl/Cmd + N` 创建笔记
    - 命名为 `obsidian_plugins_plan.md`
2. **复制下方完整文档内容**（见下一节）
    
3. **粘贴并保存**
    

---

## 📄 `obsidian_plugins_plan.md` 完整内容（复制此内容）

```markdown
# Obsidian 插件配置计划书

生成时间：2026-02-01  
状态：待执行 → 执行中

---

## 1️⃣ Vault 目录结构检测

### 当前顶层目录
**请在首次使用时补充完整：**

- [x] _ai_workbench/（AI 工作区）
- [x] 项目笔记/
- [x] 学习笔记/
- [x] 工作日志/
- [ ] .obsidian/（Obsidian 配置）
- [ ] attachments/（附件目录，**请确认实际名称**）
- [ ] templates/（模板目录）
- [ ] archive/（归档目录）
- [ ] 其他目录：___________

---

## 2️⃣ Smart Connections 索引策略

### ✅ 纳入索引（核心知识区）
- **项目笔记/**
- **学习笔记/**
- **工作日志/**

### ❌ 排除索引（降噪 + 性能优化）
- **_ai_workbench/**（AI 元数据）
- **.obsidian/**（配置缓存）
- **attachments/**（或你的附件目录）
- **templates/**（模板）
- **archive/**（归档）

---

## 3️⃣ Smart Connections 推荐设置

| 设置项 | 推荐值 | 理由 |
|--------|--------|------|
| Connections results type | **Sources** | 显示整个笔记源，避免碎片化 |
| Lookup results type | **Blocks** | 精确定位段落 |
| Results limit | **20** | 平衡结果数量和噪声 |

---

## 4️⃣ Obsidian Git 策略

### 自动提交设置（已配置）
- **频率：** 30 分钟
- **提交消息：** `vault backup: {{date}}`
- **自动推送：** 关闭（如需远程同步，手动配置 GitHub）

### 手动提交建议
- **大改动前：** `git commit -m "feat: xxx"`
- **每日结束：** `git commit -m "chore: daily sync YYYY-MM-DD"`

---

## 5️⃣ Git 忽略规则（`.gitignore`）

已添加以下规则（防止索引污染仓库）：

```

.obsidian/workspace.json  
.obsidian/cache/  
.DS_Store  
*.log  
.smart-connections/  
embeddings/  
vector-db/

````

---

## 6️⃣ 执行检查清单

- [x] Git 仓库已初始化
- [x] `.gitignore` 已配置
- [x] 首次提交已创建（回滚点）
- [ ] Smart Connections 排除目录已设置
- [ ] Smart Connections 索引已重建
- [ ] Obsidian Git 自动提交已启用（30 分钟）
- [ ] 验证测试已完成

---

## 7️⃣ 回滚方式

如果配置出现问题，执行以下命令恢复：

```bash
git log  # 查看提交历史
git reset --hard <commit-id>  # 恢复到某个提交点
````

**重要：** 回滚前确保当前工作已保存！

---

## ✅ 下一步行动

1. ✅ 初始化 Git 仓库（你已完成）
2. ✅ 配置 Obsidian Git 自动提交
3. ⏳ 配置 Smart Connections 索引范围
4. ⏳ 验证效果（见下方验证清单）

---

## 🧪 验证清单（配置完成后执行）

### 验证 1：Git 自动提交

**步骤：**

1. 等待 30 分钟
2. 在终端运行 `git log`
3. 应看到 "vault backup: 2026-02-01" 类似提交

### 验证 2：Smart Connections 索引范围

**步骤：**

1. 打开一篇"项目笔记"或"学习笔记"
2. 查看右侧 Smart Connections 推荐
3. 确认推荐结果**不包含** `_ai_workbench/` 中的笔记

### 验证 3：Git 仓库干净度

**步骤：**

1. 在终端运行 `git status`
2. 确认**没有**大量 `.json`、`.db` 等索引文件出现在未跟踪列表

---

_本文档由 Obsidian Copilot 生成_

````

---

## 🎓 值得你学习的操作（进阶技能）

### 1. Git 基础命令（5 分钟掌握核心）

**最常用的 5 个命令：**

```bash
# 查看当前状态（哪些文件被修改）
git status

# 查看提交历史（查看回滚点）
git log --oneline

# 撤销最近一次提交（保留文件修改）
git reset --soft HEAD~1

# 强制回滚到某个提交点（危险！会丢失修改）
git reset --hard <commit-id>

# 查看某个文件的修改历史
git log -p 文件名
````

**学习资源：**

- 交互式教程：[https://learngitbranching.js.org/?locale=zh_CN](https://learngitbranching.js.org/?locale=zh_CN)
- 速查表：[https://training.github.com/downloads/zh_CN/github-git-cheat-sheet/](https://training.github.com/downloads/zh_CN/github-git-cheat-sheet/)

---

### 2. Smart Connections 调优技巧

**如果遇到以下问题：**

|问题|解决方案|
|---|---|
|**结果太多噪声**|降低 Results limit 到 10；增加排除目录|
|**找不到相关笔记**|检查是否误排除了核心目录；重建索引|
|**Obsidian 卡顿**|暂时禁用 Smart Connections；分批索引|
|**索引文件巨大**|清理 `.smart-connections/` 目录；重建索引|

---

### 3. Obsidian Git 进阶：远程同步到 GitHub

**如果你未来想多设备同步，执行以下步骤：**

1. 在 GitHub 创建私有仓库
2. 在终端添加远程地址：
    
    ```bash
    git remote add origin https://github.com/你的用户名/vault-name.git
    git push -u origin main
    ```
    
3. 在 Obsidian Git 设置中启用 "Auto push"

**注意：** 私密笔记务必使用私有仓库！

---

## ⚠️ 常见问题处理

### Q1：Git 提交后发现配置错误，如何撤销？

**A：** 使用 `git reset` 回滚

```bash
git log --oneline  # 找到上一个正确的提交 ID
git reset --hard abc1234  # 替换为实际 ID
```

### Q2：Smart Connections 重建索引卡住了

**A：**

1. 关闭 Obsidian
2. 删除 `.obsidian/plugins/smart-connections/` 下的 `data.json`
3. 重新打开 Obsidian，重建索引

### Q3：Obsidian Git 显示"无法提交"

**A：** 检查是否有文件冲突

```bash
git status  # 查看问题文件
git add .   # 暂存所有更改
git commit -m "fix: resolve conflicts"
```