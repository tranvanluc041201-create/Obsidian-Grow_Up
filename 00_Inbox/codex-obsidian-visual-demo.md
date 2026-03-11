---
title: Codex 与 Obsidian 交互演示
tags:
  - codex-demo
  - visual-learning
status: demo
---

# Codex 与 Obsidian 交互演示

> [!note]
> 这份演示只验证一件事：`Codex` 生成交互 HTML，然后由 `Obsidian` 作为入口和承载层来展示。

## 直接演示区

如果你当前开着本地服务，这里应该能直接看到交互件：

<iframe
  src="http://127.0.0.1:8765/00_Inbox/codex-function-demo.html"
  width="100%"
  height="860"
  style="border: 1px solid rgba(15, 76, 129, 0.18); border-radius: 16px; background: #ffffff;">
</iframe>

## 怎么判断这条链可不可用

- 你能在 Obsidian 里直接拖参数，看图像和提示一起变化。
- 这说明 `Codex -> 生成代码 -> 本地运行 -> Obsidian 展示` 这条链是通的。
- 真正长期保留的内容，应该沉淀成稳定 demo；临时理解用的内容，做成一次性 demo 就够了。

## 备用打开方式

- [浏览器打开交互 demo](http://127.0.0.1:8765/00_Inbox/codex-function-demo.html)
- [[codex-function-demo.html|同目录查看源文件]]
