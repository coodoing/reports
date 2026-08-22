---
title: "2026q2-Public-Investment-Fund"
date: 2026-08-21
layout: raw
description: "PUBLIC INVESTMENT FUND 持仓变动"
tags: [变动解读]
---
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PUBLIC INVESTMENT FUND 持仓变动</title>
<style>
:root{
  --bg:#f4f6f9;--card:#fff;--ink:#0f172a;--sub:#475569;--line:#e2e8f0;
  --navy:#0b1a3a;--navy-light:#1e3a6f;--green:#16a34a;--green-bg:#dcfce7;
  --red:#dc2626;--red-bg:#fee2e2;--blue:#2563eb;--blue-bg:#dbeafe;--gold:#b45309;--gold-bg:#fef3c7;
  --shadow:0 8px 24px rgba(15,23,42,.08);
}
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"PingFang SC","Microsoft YaHei",sans-serif;background:var(--bg);color:var(--ink);padding:20px}
header{background:linear-gradient(135deg,var(--navy),var(--navy-light));border-radius:16px;padding:26px 32px;color:#fff;margin-bottom:18px;display:flex;justify-content:space-between;align-items:center;box-shadow:var(--shadow)}
header h1{font-size:26px;font-weight:800}
header .sub{font-size:13px;opacity:.85;margin-top:6px}
header .date{font-size:12px;opacity:.7;margin-top:4px}
header .quote{font-size:12px;opacity:.8;max-width:320px;text-align:right;line-height:1.6}
.stats-bar{display:flex;gap:12px;flex-wrap:wrap;margin-bottom:16px}
.scope-note{display:flex;align-items:center;gap:8px;background:#fff7ed;border:1px solid #fed7aa;border-left:4px solid var(--gold);color:var(--gold);font-size:12px;border-radius:10px;padding:9px 14px;margin-bottom:16px;line-height:1.5}
.stat{flex:1;min-width:120px;background:var(--card);border-radius:12px;padding:14px 16px;border:1px solid var(--line);box-shadow:var(--shadow);text-align:center}
.stat-num{font-size:30px;font-weight:800;color:var(--navy);line-height:1}
.stat-label{font-size:12px;color:var(--sub);margin-top:6px}
.wrap{display:grid;grid-template-columns:1.35fr 1fr;gap:16px}
.col{display:flex;flex-direction:column;gap:16px}
.card{background:var(--card);border-radius:14px;padding:18px;box-shadow:var(--shadow);border:1px solid var(--line)}
h2{font-size:15px;font-weight:700;margin-bottom:14px;display:flex;align-items:center;gap:8px}
h2 .tag{font-size:11px;font-weight:500;color:var(--sub);background:#f1f5f9;padding:3px 9px;border-radius:20px}
.tier-label{font-size:13px;font-weight:700;color:var(--navy);margin:14px 0 10px;padding-bottom:6px;border-bottom:1px dashed var(--line)}
.tier-label span{font-weight:500;color:var(--sub);font-size:11px;margin-left:6px}
.grid-4{display:grid;grid-template-columns:repeat(4,1fr);gap:10px}
.grid-5{display:grid;grid-template-columns:repeat(5,1fr);gap:10px}
.stock{border:1px solid var(--line);border-radius:12px;padding:12px 8px;text-align:center;display:flex;flex-direction:column;align-items:center;gap:7px;transition:transform .1s}
.stock:hover{transform:translateY(-2px);box-shadow:0 6px 16px rgba(15,23,42,.08)}
.logo{width:42px;height:42px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:15px;font-weight:800;color:#fff;text-shadow:0 1px 2px rgba(0,0,0,.2)}
.name{font-size:13px;font-weight:700;line-height:1.2}
.ticker{font-size:11px;color:var(--sub)}
.badge{font-size:11px;font-weight:700;padding:4px 10px;border-radius:20px;margin-top:2px}
.badge.green{background:var(--green-bg);color:var(--green)}
.badge.red{background:var(--red-bg);color:var(--red)}
.badge.blue{background:var(--blue-bg);color:var(--blue)}
.note{font-size:11px;color:var(--sub);margin-top:8px;line-height:1.5}
.short-list{display:flex;flex-direction:column;gap:9px}
.short-item{display:flex;align-items:center;gap:10px;padding:9px 11px;border:1px solid var(--line);border-radius:10px}
.short-meta{flex:1}
.short-name{font-size:13px;font-weight:700}
.short-ticker{font-size:10px;color:var(--sub)}
.bars{display:flex;gap:3px}
.bar{width:7px;height:14px;border-radius:2px;background:#e2e8f0}
.bar.on{background:var(--red)}
.bottom-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:14px;margin-top:16px}
.change-card{background:#fff;border-radius:12px;padding:14px;border:1px solid var(--line);box-shadow:var(--shadow)}
.change-title{font-size:12px;font-weight:700;color:var(--sub);display:flex;align-items:center;gap:6px;margin-bottom:8px}
.change-main{font-size:14px;font-weight:700;line-height:1.45}
.change-sub{font-size:11px;color:var(--sub);margin-top:5px}
.icon{width:22px;height:22px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:12px}
.icon.up{background:var(--green-bg);color:var(--green)}
.icon.down{background:var(--red-bg);color:var(--red)}
.icon.swap{background:var(--blue-bg);color:var(--blue)}
.icon.cash{background:var(--gold-bg);color:var(--gold)}
.summary-grid{display:grid;grid-template-columns:2fr 1fr;gap:14px;margin-top:16px}
.summary{background:var(--card);border-radius:12px;padding:16px;border:1px solid var(--line);box-shadow:var(--shadow)}
.summary h3{font-size:13px;font-weight:700;margin-bottom:8px}
.summary p{font-size:12px;color:var(--sub);line-height:1.7}
footer{text-align:center;font-size:11px;color:#94a3b8;margin-top:18px}
</style>
</head>
<body>
<header>
  <div>
    <h1>PUBLIC INVESTMENT FUND 持仓变动</h1>
    <div class="sub">2026 Q2 · 大师持仓 + 变动分析</div>
    <div class="date">更新日期：2026-08-21</div>
  </div>
  <div class="quote">数据只反映季度末快照，非实时仓位。<br>投资有风险，持仓变动不代表投资建议。</div>
</header>
<div class="scope-note">📌 统计范围：本报告统计来源为 COM / ETF / CALL / PUT 四类；BOND、PREFERRED、WARRANT 等类型暂未纳入统计。</div>
<div class="stats-bar"><div class="stat"><div class="stat-num">5</div><div class="stat-label">多头持仓</div></div><div class="stat"><div class="stat-num">1</div><div class="stat-label">本季建仓</div></div></div>
<div class="wrap"><div class="col"><div class="card"><h2>📊 多头持仓（重点）<span class="tag">3 梯队 · 每档 Top 5</span></h2><div class="tier-label">第一梯队<span>权重 ≥ 7% · Top 3</span></div><div class="grid-5"><div class="stock"><div class="logo" style="background:#0891b2;">SPC</div><div class="name">SPCX</div><div class="ticker">$SPCX · 工业</div><div class="badge green">69.48%</div><div class="note">154,146,835 股</div></div><div class="stock"><div class="logo" style="background:#2563eb;">UBE</div><div class="name">UBER</div><div class="ticker">$UBER · 科技</div><div class="badge green">13.87%</div><div class="note">72,840,541 股</div></div><div class="stock"><div class="logo" style="background:#ca8a04;">EA</div><div class="name">EA</div><div class="ticker">$EA · 科技</div><div class="badge green">13.42%</div><div class="note">24,807,932 股</div></div></div><div class="tier-label">第三梯队<span>权重 < 5% · Top 2</span></div><div class="grid-5"><div class="stock"><div class="logo" style="background:#2563eb;">LCI</div><div class="name">LCID</div><div class="ticker">$LCID · </div><div class="badge green">3.13%</div><div class="note">177,088,867 股</div></div><div class="stock"><div class="logo" style="background:#0891b2;">CTE</div><div class="name">CTEV</div><div class="ticker">$CTEV · 医疗保健</div><div class="badge green">0.12%</div><div class="note">1,281,250 股</div></div></div></div></div><div class="col"><div class="card"><h2>🆕 建仓 <span class="tag">Top 1</span></h2><div class="short-list"><div class="short-item"><div class="logo" style="background:#0891b2;">SPC</div><div class="short-meta"><div class="short-name">SPCX</div><div class="short-ticker">$SPCX · 工业 · 新建</div></div><div class="badge green">COM/ETF</div></div></div></div></div></div>
<div class="summary-grid"><div class="summary"><h3>🎯 变动解读</h3><p>本季持仓变动不大。</p></div></div>
<footer>由 holdings-dashboard 工具生成 · 数据源由用户提供</footer>
</body>
</html>
