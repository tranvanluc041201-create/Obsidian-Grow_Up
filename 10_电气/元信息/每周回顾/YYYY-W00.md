---
week: <% tp.date.now("YYYY-[W]WW") %>
---

# 第 <% tp.date.now("[W]WW") %> 周回顾｜电气

---

## 本周概览

- 项目推进：___
- 基础补充：___
- 新学到的错误类型：___

---

## 本周活动

### PSIM / 项目笔记
```dataview
table file.folder as 文件夹, created as 创建时间
from "10_电气/PSIM"
where created > date(today) - dur(7 days)
sort created desc
```

### 错误类型
```dataview
table error_type as 错误类型, source as 来源, created as 创建时间
from "10_电气/PSIM/错误类型"
where type = "mistake" and created > date(today) - dur(7 days)
sort created desc
```

---

## 本周复盘

### 这周有效的做法
-

### 这周效果不好的做法
-

### 新认识
-

---

## 下周重点

- [ ] 项目推进：___
- [ ] 基础补充：___
- [ ] 工具练习：___
