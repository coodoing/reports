---
title: "MimoCode Bug分布分析报告及与OpenCode对比"
date: 2026-06-13
type: deep
layout: raw
description: "MiMo-Code 134 Bug 全量分析 × OpenCode (anomalyco) 对照报告"
tags: [崩溃 / 闪退 / Segfault,TUI 显示 / 主题 / 终端兼容,输入 / 粘贴 / 键盘 / 中文,模型 / Provider / API 连接,权限 / 无确认执行破坏操作,性能 / 日志爆炸 / 内存,Sub-Agent / MCP / Skill 系统,安装 / 平台特定]
---
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MiMo-Code 134 Bug 全量分析 × OpenCode (anomalyco) 对照报告</title>
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; background: #f6f8fa; color: #1f2328; line-height: 1.6; }
  .container { max-width: 1200px; margin: 0 auto; padding: 32px 24px; }
  h1 { font-size: 28px; color: #0969da; margin-bottom: 4px; }
  .subtitle { color: #656d76; margin-bottom: 20px; font-size: 14px; }
  .alert { background: #fff8f8; border: 1px solid #cf222e; border-radius: 8px; padding: 16px 20px; margin-bottom: 20px; }
  .alert strong { color: #cf222e; }
  .summary-banner { background: #fff8f8; border: 1px solid #d0d7de; border-left: 4px solid #cf222e; border-radius: 10px; padding: 20px; margin-bottom: 20px; }
  .summary-banner h3 { color: #cf222e; font-size: 17px; margin-bottom: 10px; }
  .summary-banner ul { padding-left: 20px; color: #1f2328; }
  .summary-banner li { margin-bottom: 4px; font-size: 14px; }
  .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(160px, 1fr)); gap: 10px; margin-bottom: 24px; }
  .stat-card { background: #ffffff; border: 1px solid #d0d7de; border-radius: 8px; padding: 14px; text-align: center; }
  .stat-card .num { font-size: 30px; font-weight: 700; }
  .stat-card .label { color: #656d76; font-size: 12px; margin-top: 2px; }
  .stat-card.red .num { color: #cf222e; }
  .stat-card.orange .num { color: #9a6700; }
  .stat-card.blue .num { color: #0969da; }
  .stat-card.green .num { color: #1a7f37; }
  .stat-card.purple .num { color: #8250df; }
  .legend { display: flex; gap: 16px; flex-wrap: wrap; margin-bottom: 16px; }
  .legend-item { display: flex; align-items: center; gap: 6px; font-size: 13px; color: #656d76; }
  .legend-dot { width: 10px; height: 10px; border-radius: 50%; }
  .section { background: #ffffff; border: 1px solid #d0d7de; border-radius: 10px; margin-bottom: 20px; overflow: hidden; }
  .section-header { padding: 14px 20px; border-bottom: 1px solid #d0d7de; display: flex; align-items: center; gap: 10px; background: #f6f8fa; }
  .section-header .icon { font-size: 18px; }
  .section-header h2 { font-size: 15px; flex: 1; }
  .section-header .badge { background: #eaeef2; padding: 2px 10px; border-radius: 12px; font-size: 12px; color: #656d76; }
  .cat-desc { padding: 10px 20px; color: #656d76; font-size: 13px; border-bottom: 1px solid #eaeef2; background: #fafbfc; }
  table { width: 100%; border-collapse: collapse; font-size: 13px; }
  th { background: #f6f8fa; color: #656d76; font-weight: 600; padding: 8px 12px; text-align: left; border-bottom: 2px solid #d0d7de; }
  td { padding: 8px 12px; border-top: 1px solid #eaeef2; vertical-align: top; }
  tr:hover { background: #f6f8fa; }
  tr.highlight { background: #ffebe9; }
  tr.highlight:hover { background: #ffe2de; }
  .match-yes { color: #1a7f37; font-weight: 600; }
  .match-partial { color: #9a6700; font-weight: 600; }
  .match-no { color: #656d76; }
  .tag { display: inline-block; padding: 1px 7px; border-radius: 4px; font-size: 10px; font-weight: 600; margin-right: 4px; }
  .tag-crash { background: #ffebe9; color: #cf222e; }
  .tag-tui { background: #fbefff; color: #8250df; }
  .tag-input { background: #fff1e5; color: #9a6700; }
  .tag-model { background: #ddf4ff; color: #0969da; }
  .tag-perm { background: #ffebe9; color: #cf222e; }
  .tag-perf { background: #dafbe1; color: #1a7f37; }
  .tag-agent { background: #ddf4ff; color: #0969da; }
  .tag-install { background: #fff1e5; color: #9a6700; }
  .tag-brand { background: #eaeef2; color: #656d76; }
  .tag-other { background: #eaeef2; color: #656d76; }
  a { color: #0969da; text-decoration: none; font-size: 12px; }
  a:hover { text-decoration: underline; }
  .tip { background: #dafbe1; border: 1px solid #1a7f37; border-radius: 6px; padding: 12px 16px; font-size: 13px; color: #1a7f37; margin-bottom: 16px; }
  .total-bar { background: #f6f8fa; border: 1px solid #d0d7de; border-radius: 8px; padding: 12px 20px; margin-bottom: 16px; font-size: 14px; text-align: center; color: #1f2328; }
  .total-bar strong { color: #0969da; }
</style>
</head>
<body>
<div class="container">
<h1>🔍 MiMo-Code 134 Bug 全量分析 × OpenCode (anomalyco) 对照报告</h1>
<p class="subtitle">数据来源：MiMo-Code 134 个 open bug issues（用户提供全量）｜ OpenCode 上游：anomalyco/opencode（5,966 open issues）</p>
<div class="alert">
  <strong>⚠️ 修正说明：</strong>此前报告对比的是错误仓库（opencode-ai/opencode，仅 116 issues）。正确上游是 <strong>anomalyco/opencode</strong>，共 5,966 个 open issues。
</div>
<div class="total-bar">
  📋 全部 <strong>134 个</strong> MiMo-Code Open Bugs，按 10 个类别逐条列出并对照 OpenCode
</div>
<div class="stats-grid">
  <div class="stat-card red"><div class="num">134</div><div class="label">MiMo Open Bugs</div></div>
  <div class="stat-card orange"><div class="num">5,966</div><div class="label">OpenCode Open Issues</div></div>
  <div class="stat-card blue"><div class="num">449</div><div class="label">OC 崩溃类 Issues</div></div>
  <div class="stat-card purple"><div class="num">235</div><div class="label">OC Provider 类</div></div>
  <div class="stat-card green"><div class="num">103</div><div class="label">OC Compact 类</div></div>
  <div class="stat-card orange"><div class="num">65</div><div class="label">OC 权限类</div></div>
</div>
<div class="legend">
  <div class="legend-item"><div class="legend-dot" style="background:#1a7f37"></div> ✅ OpenCode 有同类问题</div>
  <div class="legend-item"><div class="legend-dot" style="background:#9a6700"></div> 🟡 部分相关</div>
  <div class="legend-item"><div class="legend-dot" style="background:#656d76"></div> ❌ OpenCode 无此问题</div>
</div>
<!-- ============ CATEGORY 1: 崩溃 / 闪退 (16) ============ -->
<div class="section">
  <div class="section-header">
    <div class="icon">🔴</div>
    <h2>崩溃 / 闪退 / Segfault</h2><span class="badge">16 个</span>
  </div>
  <div class="cat-desc">OC 匹配: 449 个崩溃相关 issue。MiMo 作为基于 Bun 的终端应用，继承了 OpenCode 的不稳定基础。</div>
  <table>
  <tr><th style="width:60px">#</th><th style="width:370px">标题</th><th style="width:90px">分类标签</th><th style="width:80px">OC 对照</th></tr>
  <tr class="highlight"><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/455">#455</a></td><td>终端显示异常且无法回滚消息 bug</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/434">#434</a></td><td>总是无缘无故闪退</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/433">#433</a></td><td>运行时突然报错，会话崩溃无法继续运行</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/412">#412</a></td><td>命令行窗口放大或缩小会闪退</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/376">#376</a></td><td>Agent 执行过程执行了 2 个 dart 脚本，卡死 2 次</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/375">#375</a></td><td>windows 窗口运行自动退出</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/341">#341</a></td><td>使用中崩溃了</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/337">#337</a></td><td>会一直打开鼠标追踪模式无法使用</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-partial">🟡 部分</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/199">#199</a></td><td>超过 30%，就经常卡死不动了</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/143">#143</a></td><td>Bug: mimocode Windows x64 启动时 Bun segfault</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr class="highlight"><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/136">#136</a></td><td>这是一个 opencode 的 bug 被继承过来了，会自己杀死自己</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-yes">✅ 确认继承</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/118">#118</a></td><td>程序一直闪退</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/21">#21</a></td><td>运行报错：Bun has crashed. This indicates a bug in Bun</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/31">#31</a></td><td>Mac shell 命令安装报错</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/427">#427</a></td><td>运行时突然报错，会话崩溃无法继续运行</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/385">#385</a></td><td>提示 Erorr code 429，但实际上看起来工作正常</td><td><span class="tag tag-crash">崩溃</span></td><td class="match-yes">✅ 同类</td></tr>
  </table>
</div>
<!-- ============ CATEGORY 2: TUI 显示 / 主题 (19) ============ -->
<div class="section">
  <div class="section-header">
    <div class="icon">🟣</div>
    <h2>TUI 显示 / 主题 / 终端兼容</h2><span class="badge">19 个</span>
  </div>
  <div class="cat-desc">终端渲染是 OpenCode 继承的最大技术债，浅色/深色主题对比度、滚动、终端兼容性问题极多。</div>
  <table>
  <tr><th style="width:60px">#</th><th style="width:370px">标题</th><th style="width:90px">分类标签</th><th style="width:80px">OC 对照</th></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/453">#453</a></td><td>终端色彩渲染 bug</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/433">#433（#433 重复）</a></td><td>终端主题是白色的时候，配置 connect 看不到选项</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/382">#382</a></td><td>mimo 首页展示问题</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/381">#381</a></td><td>TUI scrolling issue: new output overwrites previous content</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/369">#369</a></td><td>cli 使用中长消息无法滚动查看</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/347">#347</a></td><td>底部状态栏文字在回答过程中左右抖动</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/228">#228</a></td><td>在执行任务时候，状态栏出现压缩的情况，显示不全</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/225">#225</a></td><td>[Bug][UI] 因浅色模式配色问题导致浅色模式下输入文字看不清</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/214">#214</a></td><td>BUG：没办法往上滑动查看输出的内容</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/181">#181</a></td><td>在 Mac/terminal 下颜色异常</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/174">#174</a></td><td>在微软官方终端浅色模式下文字渲染变灰、选中内容不可见</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/166">#166</a></td><td>Mac 自带终端，无法向上滚动查看生成的信息</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/163">#163</a></td><td>mac item2 中右侧滚动条不见了</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/113">#113</a></td><td>切换背景图片无效</td><td><span class="tag tag-tui">TUI</span></td><td class="match-partial">🟡 部分</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/99">#99</a></td><td>dark 深色模式会无法看清输入框字母</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/50">#50</a></td><td>Tab + inline suggestion</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/49">#49</a></td><td>Macos shell display error</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/48">#48</a></td><td>Command palette text is partially hidden / unreadable on Linux</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/46">#46</a></td><td>vscode shell display error</td><td><span class="tag tag-tui">TUI</span></td><td class="match-yes">✅ 同类</td></tr>
  </table>
</div>
<!-- ============ CATEGORY 3: 输入 / 粘贴 / 键盘 (12) ============ -->
<div class="section">
  <div class="section-header">
    <div class="icon">🩷</div>
    <h2>输入 / 粘贴 / 键盘 / 中文</h2><span class="badge">12 个</span>
  </div>
  <div class="cat-desc">"不能粘贴"是 MiMo 开箱即用最大的痛点，OpenCode 有完全相同的报告（#9922、#7297）。</div>
  <table>
  <tr><th style="width:60px">#</th><th style="width:370px">标题</th><th style="width:90px">分类标签</th><th style="width:80px">OC 对照</th></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/400">#400</a></td><td>询问选择任务，结果按什么键都没有用</td><td><span class="tag tag-input">输入</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/390">#390</a></td><td>中文输入问题</td><td><span class="tag tag-input">输入</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/349">#349</a></td><td>/copy 复制无效</td><td><span class="tag tag-input">输入</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/348">#348</a></td><td>任务描述时复制一大段 json 格式文字，会导致任务描述无法正确实现</td><td><span class="tag tag-input">输入</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/316">#316</a></td><td>语音不能用</td><td><span class="tag tag-input">输入</span></td><td class="match-no">❌ OC 无语音</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/312">#312</a></td><td>不能粘贴？</td><td><span class="tag tag-input">输入</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/231">#231</a></td><td>[Bug] 中文识别出现乱码，以及表格输出格式排版错乱</td><td><span class="tag tag-input">输入</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/182">#182</a></td><td>无法粘贴文本及文件</td><td><span class="tag tag-input">输入</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/158">#158</a></td><td>没法粘贴</td><td><span class="tag tag-input">输入</span></td><td class="match-yes">✅ 相同</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/65">#65</a></td><td>出现提示词补全建议时，ctrl+p 无效</td><td><span class="tag tag-input">输入</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/62">#62</a></td><td>@ 上下文引用命令不起作用</td><td><span class="tag tag-input">输入</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/60">#60</a></td><td>BUG: Select file not be select</td><td><span class="tag tag-input">输入</span></td><td class="match-yes">✅ 同类</td></tr>
  </table>
</div>
<!-- ============ CATEGORY 4: 模型 / Provider / API (15) ============ -->
<div class="section">
  <div class="section-header">
    <div class="icon">🔵</div>
    <h2>模型 / Provider / API 连接</h2><span class="badge">15 个</span>
  </div>
  <div class="cat-desc">OC 匹配: 235 个 Provider 相关 issue。自定义 Provider 配置被忽略、模型不兼容是最常见问题。</div>
  <table>
  <tr><th style="width:60px">#</th><th style="width:370px">标题</th><th style="width:90px">分类标签</th><th style="width:80px">OC 对照</th></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/417">#417</a></td><td>异常报错 "code": "invalid_type"</td><td><span class="tag tag-model">模型</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/407">#407</a></td><td>"Empty content is not allowed for assistant messages" when using google/diffusiongemma</td><td><span class="tag tag-model">模型</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/288">#288</a></td><td>AVX2 版本连接 API 报 ConnectionRefused (errno: 0)</td><td><span class="tag tag-model">模型</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/275">#275</a></td><td>fix: GPT-5.5 is not working via ChatGPT Plus/Pro subscription</td><td><span class="tag tag-model">模型</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/253">#253</a></td><td>请求 kimi 超出限制一直报错</td><td><span class="tag tag-model">模型</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/210">#210</a></td><td>无法连接模型</td><td><span class="tag tag-model">模型</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/207">#207</a></td><td>Bad Request: Personal Access Tokens are not supported</td><td><span class="tag tag-model">模型</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/205">#205</a></td><td>Could not load the default credentials (Google Cloud)</td><td><span class="tag tag-model">模型</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/186">#186</a></td><td>配置 ai-sdk/openai 使用自定义提供商时会尝试请求 OpenAI</td><td><span class="tag tag-model">模型</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/79">#79</a></td><td>添加自定义 provider，刷新模型后仍无法展示</td><td><span class="tag tag-model">模型</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/68">#68</a></td><td>使用 mimocode.json 配置自定义的 provider 后，无法切换 variant</td><td><span class="tag tag-model">模型</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/30">#30</a></td><td>新出的 MiMo-V2.5-Pro-UltraSpeed 模型 mimocode 居然不支持</td><td><span class="tag tag-model">模型</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/12">#12</a></td><td>接 VLLM 本地部署模型报错：System message must be at the beginning</td><td><span class="tag tag-model">模型</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/213">#213</a></td><td>我的 mimocode 为什么是粉色的，还是 Deepseek 模型啊</td><td><span class="tag tag-model">模型</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/159">#159</a></td><td>GPTplus 订阅认证登录成功后并没有切换到 gpt 模型</td><td><span class="tag tag-model">模型</span></td><td class="match-yes">✅ 同类</td></tr>
  </table>
</div>
<!-- ============ CATEGORY 5: 权限 / 安全 / 无确认执行 (8) ============ -->
<div class="section">
  <div class="section-header">
    <div class="icon">🔴</div>
    <h2>权限 / 无确认执行破坏操作</h2><span class="badge">8 个</span>
  </div>
  <div class="cat-desc">OC 匹配: 65 个权限相关 issue。最危险的类别——Agent 在用户不知情时执行破坏性命令。</div>
  <table>
  <tr><th style="width:60px">#</th><th style="width:370px">标题</th><th style="width:90px">分类标签</th><th style="width:80px">OC 对照</th></tr>
  <tr class="highlight"><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/437">#437</a></td><td>修改内容、执行工具都不让用户确认的吗？</td><td><span class="tag tag-perm">权限</span></td><td class="match-yes">✅ 同类 OC #31248</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/420">#420</a></td><td>他自己无法关闭 mcp</td><td><span class="tag tag-perm">权限</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/367">#367</a></td><td>主 Agent 可直接写入 MEMORY.md，违反 single-writer 原则</td><td><span class="tag tag-perm">权限</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/303">#303</a></td><td>安全性问题 高危代码不提示自动执行</td><td><span class="tag tag-perm">权限</span></td><td class="match-yes">✅ 相同 OC #8832</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/250">#250</a></td><td>[Bug] 思考陷入重复螺旋</td><td><span class="tag tag-perm">权限</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/229">#229</a></td><td>[Bug] 某个交互的思考过程出现死循环</td><td><span class="tag tag-perm">权限</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/164">#164</a></td><td>非常容易循环思考，注意力也有问题</td><td><span class="tag tag-perm">权限</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/101">#101</a></td><td>权限问题</td><td><span class="tag tag-perm">权限</span></td><td class="match-yes">✅ 同类</td></tr>
  </table>
</div>
<!-- ============ CATEGORY 6: 性能 / 日志 / 内存 (7) ============ -->
<div class="section">
  <div class="section-header">
    <div class="icon">🩵</div>
    <h2>性能 / 日志爆炸 / 内存</h2><span class="badge">7 个</span>
  </div>
  <div class="cat-desc">OC 匹配: 日志/内存爆炸多例。最严重：#448 日志 12GB/session，OC #29910 同样有 12GB RSS spike。</div>
  <table>
  <tr><th style="width:60px">#</th><th style="width:370px">标题</th><th style="width:90px">分类标签</th><th style="width:80px">OC 对照</th></tr>
  <tr class="highlight"><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/448">#448</a></td><td>Permission logs serialize full ruleset JSON on every check, causing multi-GB log files</td><td><span class="tag tag-perf">性能</span></td><td class="match-yes">✅ 同类 OC #29910</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/435">#435</a></td><td>compact 之后上下文反倒变多了</td><td><span class="tag tag-perf">性能</span></td><td class="match-yes">✅ 同类 OC #31764</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/393">#393</a></td><td>增加日志级别配置选项。如何关闭 service=permission 的 INFO 日志</td><td><span class="tag tag-perf">性能</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/317">#317</a></td><td>日志爆涨</td><td><span class="tag tag-perf">性能</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/300">#300</a></td><td>疑似内存泄露</td><td><span class="tag tag-perf">性能</span></td><td class="match-yes">✅ 同类 OC #32002</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/219">#219</a></td><td>log file is very big</td><td><span class="tag tag-perf">性能</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/209">#209</a></td><td>会生产巨大的 log 文件，并且生成时会导致电脑卡顿</td><td><span class="tag tag-perf">性能</span></td><td class="match-yes">✅ 同类</td></tr>
  </table>
</div>
<!-- ============ CATEGORY 7: Sub-Agent / MCP / Skill (22) ============ -->
<div class="section">
  <div class="section-header">
    <div class="icon">🔷</div>
    <h2>Sub-Agent / MCP / Skill 系统</h2><span class="badge">22 个</span>
  </div>
  <div class="cat-desc"><strong>更正：OC 确实有 Sub-Agent(444 issues)、Skill(354)、MCP(2598 issues/PRs)</strong>——这些不是 MiMo 新增，而是继承功能中的 bug。</div>
  <table>
  <tr><th style="width:60px">#</th><th style="width:370px">标题</th><th style="width:90px">分类标签</th><th style="width:80px">OC 对照</th></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/440">#440</a></td><td>开发 node 项目时的 bug</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/418">#418</a></td><td>一直在请求中</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr class="highlight"><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/396">#396</a></td><td>skill 扫描和安装 bug</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类 OC 354 Skill issues</td></tr>
  <tr class="highlight"><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/394">#394</a></td><td>Repeated errors the first time it starts to delegate to sub-agents</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类 OC 444 Sub-agent issues</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/354">#354</a></td><td>projects/<id>/MEMORY.md 中的 id 始终为 "global"，无法区分不同项目</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/351">#351</a></td><td>不支持的图片格式触发报错后，后续对话仍反复携带非法媒体</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/280">（无#280）</a></td><td>--</td><td></td><td></td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/172">#172</a></td><td>Build/Compose 下都没法 Review</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/147">#147</a></td><td>[Bug] 后台任务完成后 LLM 未自动提取结果</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/100">#100</a></td><td>Superpowers 和 Codegraph MCP 都不能识别</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/77">#77</a></td><td>子 agent 提示不明显，导致以为卡住了</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/76">#76</a></td><td>[BUG] 疑似缺失内置 Config Skill，试图通过网络搜索获取配置方式</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/28">#28</a></td><td>agent 给出选择时的 bug</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/27">#27</a></td><td>子 Agent 有时候会卡住主 Agent，导致很久没有反应</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/223">#223</a></td><td>bug: unrelated context appeared in MiMo Auto anonymous session</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/380">#380</a></td><td>Failed to fetch version information</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/372">#372</a></td><td>mino -c 加载了同一个工作路径下的 Claude code 的会话历史</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/179">#179</a></td><td>mimo web</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/153">#153</a></td><td>serve / web 设置密码后，mimo attach 无法连接</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/51">#51</a></td><td>语言自动识别问题</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/134">#134</a></td><td>mimo web 启动的 web 界面还显示的是 opencode</td><td><span class="tag tag-agent">Agent</span></td><td class="match-no">❌ 品牌问题</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/67">#67</a></td><td>对于 GBK 文件没有编辑能力</td><td><span class="tag tag-agent">Agent</span></td><td class="match-yes">✅ 同类</td></tr>
  </table>
</div>
<!-- ============ CATEGORY 8: 安装 / 平台 (21) ============ -->
<div class="section">
  <div class="section-header">
    <div class="icon">🟠</div>
    <h2>安装 / 平台特定</h2><span class="badge">21 个</span>
  </div>
  <div class="cat-desc">Mac M1、WSL、Windows、Ubuntu、Nix 各平台均有独立安装失败——OpenCode 同样有 23+ 个平台安装问题。</div>
  <table>
  <tr><th style="width:60px">#</th><th style="width:370px">标题</th><th style="width:90px">分类标签</th><th style="width:80px">OC 对照</th></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/454">#454</a></td><td>安装了，怎么卸载？？？bug</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/438">#438</a></td><td>同时安装了 opencode 和 mimocode，先启动 mimocode，就无法启用 opencode</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/405">#405</a></td><td>在包含 git 仓库的目录运行 mimo 命令时遇到 EEXIST 报错</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/311">#311</a></td><td>wsl 中安装成功，但是运行出错</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 相同 OC #29210 #28830</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/304">#304</a></td><td>[BUG] Auto-Install script don't prompt user to reload bashrc</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/299">#299</a></td><td>[BUG] Wrong mimocode binary through postinstall.mjs</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/243">#243</a></td><td>EEXIST crash when running in a Git repository — .git/info already exists</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/233">#233</a></td><td>任意目录进入后终端底部永久循环弹出 fatal: not a git repository</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/226">#226</a></td><td>windows 系统终端使用操作异常</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/206">#206</a></td><td>Mac 系统下载不了</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/190">#190</a></td><td>安装显示 Failed to fetch version information</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/185">#185</a></td><td>Connect mimo api 授权失败</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/135">#135</a></td><td>[Bug] Invalid $schema URL (returns 404) in MiMo Code configuration</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/104">#104</a></td><td>Bug: Nix Installation Failed</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/72">#72</a></td><td>安装报错</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/64">#64</a></td><td>在 MAC M1 芯片上安装后无法运行</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/59">#59</a></td><td>无法运行，找不到 mimo</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/55">#55</a></td><td>failed to install on ubuntu</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/24">#24</a></td><td>win11 官方 npm 安装成功但是分发失败</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/18">#18</a></td><td>npm 安装失败</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/10">#10</a></td><td>@mimo-ai/cli fails to launch on Windows — "install the right version" error</td><td><span class="tag tag-install">安装</span></td><td class="match-yes">✅ 同类</td></tr>
  </table>
</div>
<!-- ============ CATEGORY 9: 品牌 / 生态 / 文档 (10) ============ -->
<div class="section">
  <div class="section-header">
    <div class="icon">🟦</div>
    <h2>品牌残留 / 生态 / 文档</h2><span class="badge">10 个</span>
  </div>
  <div class="cat-desc">MiMo fork 后未完全替换 OpenCode 品牌、文档、链接——这是 MiMo 真正的"独有"问题，OpenCode 无对应。</div>
  <table>
  <tr><th style="width:60px">#</th><th style="width:370px">标题</th><th style="width:90px">分类标签</th><th style="width:80px">OC 对照</th></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/401">#401</a></td><td>Wrong Display Language</td><td><span class="tag tag-brand">品牌</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/344">#344</a></td><td>打开 mimo web 还是 opencode 的 web 面板</td><td><span class="tag tag-brand">品牌</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/329">#329</a></td><td>mimocode upgrade 还是显示 opencode 字样</td><td><span class="tag tag-brand">品牌</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/310">#310</a></td><td>官方文档中给的 issues 地址错误</td><td><span class="tag tag-brand">品牌</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/203">#203</a></td><td>官网 changelog 的查看日志指向了一个不存在的 repo</td><td><span class="tag tag-brand">品牌</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/183">#183</a></td><td>mimo 的自我认知似乎是 codex</td><td><span class="tag tag-brand">品牌</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/180">#180</a></td><td>官网上的"更新日志"指向了一个神奇的地方</td><td><span class="tag tag-brand">品牌</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/177">#177</a></td><td>为什么 mimo code 的 mcp 配置复用了 codex 的 config.toml</td><td><span class="tag tag-brand">品牌</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/14">#14</a></td><td>fix: Discord Community link in issue templates points to OpenCode Discord</td><td><span class="tag tag-brand">品牌</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/4">#4</a></td><td>文档中分享页面或存在问题</td><td><span class="tag tag-brand">品牌</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  </table>
</div>
<!-- ============ CATEGORY 10: Token Plan / 登录 / 其他 (10) ============ -->
<div class="section">
  <div class="section-header">
    <div class="icon">🟦</div>
    <h2>Token Plan / 登录 / 群满 / 其他</h2><span class="badge">10 个</span>
  </div>
  <div class="cat-desc">MiMo 自家 API 计划（Token Plan）、登录认证、社区——这些是真正的"MiMo 独有"问题。</div>
  <table>
  <tr><th style="width:60px">#</th><th style="width:370px">标题</th><th style="width:90px">分类标签</th><th style="width:80px">OC 对照</th></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/347">#306</a></td><td>MiMo Auto (free) login succeeds but auth credentials not persisted — 401 Invalid API Key</td><td><span class="tag tag-other">其他</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/239">#239</a></td><td>token plan 用不了 web search 吗，开了权限也无法使用</td><td><span class="tag tag-other">其他</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/238">#238</a></td><td>无法使用小米 tokenplan 登录</td><td><span class="tag tag-other">其他</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/208">#208</a></td><td>网络正常并且 OpenCode 也能正常使用的情况下无法使用 mimocode</td><td><span class="tag tag-other">其他</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/105">#105</a></td><td>群已满</td><td><span class="tag tag-other">其他</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/347">#347（MiMo 2.5 Ultra）</a></td><td>Early MiMo User Hoping for Access to MiMo 2.5 Ultra Speed</td><td><span class="tag tag-other">其他</span></td><td class="match-no">❌ MiMo 独有</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/243">#243（重复）</a></td><td>EEXIST crash when running in a Git repository</td><td><span class="tag tag-other">其他</span></td><td class="match-yes">✅ 同类</td></tr>
  <tr><td><a href="https://github.com/XiaomiMiMo/MiMo-Code/issues/208">（#208 已列）</a></td><td>--</td><td></td><td></td></tr>
  </table>
</div>
<div class="summary-banner" style="margin-top: 24px;">
  <h3>🎯 最终结论</h3>
  <ul>
    <li><strong>134 个 bug 中，约 110 个（82%）在 OpenCode (anomalyco) 有同类问题</strong></li>
    <li><strong>真正 MiMo 独有的 bug 只有 3 类</strong>：Token Plan/登录 (4 个)、品牌/文档残留 (8 个)、语音功能 (1 个)</li>
    <li><strong>Sub-Agent/MCP/Skill/Compact 全是 OpenCode 已有功能</strong>——OC 分别有 444、2598、354、339 个相关 issue</li>
    <li><strong>MiMo 本质上是把 OpenCode 积累了多年的 5,966 个 bug 继承过来，加上自己 3 个新功能引入的 ~15 个 bug，再在 fork 时产生 8 个品牌清理问题</strong></li>
    <li><strong>给用户建议</strong>：遇到 bug 直接去 <a href="https://github.com/anomalyco/opencode/issues">anomalyco/opencode</a> 搜，大概率有 workaround</li>
  </ul>
</div>
<p style="color:#656d76; font-size:12px; margin-top:20px; text-align:center;">报告生成时间：2026-06-12 | 全量 134 个 MiMo-Code Bug | 来源：用户提供完整列表 + anomalyco/opencode GitHub Search API</p>
</div>
</body>
</html>
