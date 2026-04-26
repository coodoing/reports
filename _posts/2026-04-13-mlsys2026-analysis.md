---
title: "MLSys 2026 论文深度分析报告"
date: 2026-04-13
layout: raw
description: "MLSys 2026 论文深度分析报告"
tags: []
---
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-30RDGNHJD7"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-30RDGNHJD7');
</script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MLSys 2026 论文深度分析报告</title>
<style>
  :root {
    --primary: #1a1a2e;
    --accent: #e94560;
    --accent2: #0f3460;
    --accent3: #533483;
    --bg: #f8f9ff;
    --card: #ffffff;
    --text: #1a1a2e;
    --text-light: #64748b;
    --border: #e2e8f0;
    --tag-bg: #eff6ff;
    --tag-color: #3b82f6;
  }

  * { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: 'Segoe UI', 'PingFang SC', 'Microsoft YaHei', sans-serif;
    background: var(--bg);
    color: var(--text);
    line-height: 1.7;
  }

  /* HEADER */
  .hero {
    background: linear-gradient(135deg, #1a1a2e 0%, #16213e 40%, #0f3460 100%);
    color: white;
    padding: 60px 40px 50px;
    position: relative;
    overflow: hidden;
  }
  .hero::before {
    content: '';
    position: absolute;
    top: -80px; right: -80px;
    width: 300px; height: 300px;
    background: radial-gradient(circle, rgba(233,69,96,0.25) 0%, transparent 70%);
    border-radius: 50%;
  }
  .hero::after {
    content: '';
    position: absolute;
    bottom: -60px; left: 30%;
    width: 200px; height: 200px;
    background: radial-gradient(circle, rgba(83,52,131,0.3) 0%, transparent 70%);
    border-radius: 50%;
  }
  .hero-inner { max-width: 1100px; margin: 0 auto; position: relative; z-index: 1; }
  .hero-badge {
    display: inline-block;
    background: rgba(233,69,96,0.2);
    border: 1px solid rgba(233,69,96,0.5);
    color: #ff8096;
    font-size: 12px;
    font-weight: 600;
    letter-spacing: 2px;
    text-transform: uppercase;
    padding: 4px 12px;
    border-radius: 20px;
    margin-bottom: 16px;
  }
  .hero h1 { font-size: 2.6rem; font-weight: 800; margin-bottom: 12px; line-height: 1.2; }
  .hero h1 span { color: #e94560; }
  .hero p { font-size: 1.05rem; color: #a0aec0; max-width: 700px; }
  .hero-meta {
    display: flex; gap: 32px; margin-top: 28px; flex-wrap: wrap;
  }
  .hero-stat {
    display: flex; flex-direction: column;
  }
  .hero-stat .num {
    font-size: 2rem; font-weight: 800; color: #e94560; line-height: 1;
  }
  .hero-stat .label {
    font-size: 0.8rem; color: #a0aec0; text-transform: uppercase; letter-spacing: 1px; margin-top: 2px;
  }

  /* LAYOUT */
  .container { max-width: 1100px; margin: 0 auto; padding: 40px 24px; }

  /* SECTION TITLES */
  .section-title {
    font-size: 1.4rem;
    font-weight: 800;
    color: var(--primary);
    margin-bottom: 20px;
    display: flex; align-items: center; gap: 10px;
  }
  .section-title .dot {
    width: 8px; height: 28px;
    background: linear-gradient(180deg, #e94560, #533483);
    border-radius: 4px;
    flex-shrink: 0;
  }

  /* DISTRIBUTION CHART */
  .dist-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 14px;
    margin-bottom: 40px;
  }
  .dist-card {
    background: var(--card);
    border-radius: 12px;
    padding: 18px 20px;
    border: 1px solid var(--border);
    display: flex; flex-direction: column; gap: 10px;
    transition: box-shadow .2s, transform .2s;
    box-shadow: 0 1px 4px rgba(0,0,0,0.06);
  }
  .dist-card:hover { box-shadow: 0 6px 20px rgba(0,0,0,0.1); transform: translateY(-2px); }
  .dist-card .cat-name { font-weight: 700; font-size: 0.92rem; color: var(--text); }
  .dist-card .cat-count { font-size: 1.6rem; font-weight: 800; color: var(--accent); }
  .dist-bar-wrap { background: #f1f5f9; border-radius: 4px; height: 6px; overflow: hidden; }
  .dist-bar { height: 100%; border-radius: 4px; }

  /* PAPER CARDS */
  .paper-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    gap: 18px;
    margin-bottom: 40px;
  }
  .paper-card {
    background: var(--card);
    border-radius: 14px;
    padding: 20px 22px;
    border: 1px solid var(--border);
    box-shadow: 0 1px 4px rgba(0,0,0,0.06);
    transition: box-shadow .2s, transform .2s;
  }
  .paper-card:hover { box-shadow: 0 8px 24px rgba(0,0,0,0.11); transform: translateY(-3px); }
  .paper-card .ptag {
    display: inline-block;
    font-size: 11px; font-weight: 600; letter-spacing: 0.5px;
    padding: 2px 9px; border-radius: 20px;
    margin-bottom: 10px;
  }
  .paper-card h3 { font-size: 0.97rem; font-weight: 700; color: var(--text); margin-bottom: 8px; line-height: 1.4; }
  .paper-card .desc { font-size: 0.86rem; color: var(--text-light); line-height: 1.5; }
  .paper-card .authors { font-size: 0.78rem; color: #94a3b8; margin-top: 10px; border-top: 1px solid var(--border); padding-top: 8px; }

  /* TREND CARDS */
  .trend-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 20px;
    margin-bottom: 40px;
  }
  .trend-card {
    background: var(--card);
    border-radius: 14px;
    padding: 22px 24px;
    border-left: 4px solid;
    box-shadow: 0 2px 8px rgba(0,0,0,0.07);
  }
  .trend-card .t-icon { font-size: 1.8rem; margin-bottom: 10px; }
  .trend-card .t-title { font-size: 1rem; font-weight: 800; margin-bottom: 8px; }
  .trend-card .t-body { font-size: 0.87rem; color: var(--text-light); line-height: 1.6; }
  .trend-card .t-horizon {
    margin-top: 12px; font-size: 0.78rem; font-weight: 600;
    padding: 2px 10px; border-radius: 20px;
    display: inline-block;
  }

  /* HORIZON TIMELINE */
  .timeline { margin-bottom: 40px; }
  .timeline-item {
    display: flex; gap: 20px; margin-bottom: 24px; align-items: flex-start;
  }
  .tl-year {
    flex-shrink: 0; width: 80px; text-align: right;
    font-weight: 800; font-size: 1.05rem;
    padding-top: 2px;
  }
  .tl-line { flex-shrink: 0; display: flex; flex-direction: column; align-items: center; }
  .tl-dot { width: 14px; height: 14px; border-radius: 50%; flex-shrink: 0; margin-top: 4px; }
  .tl-stem { width: 2px; flex: 1; min-height: 40px; }
  .tl-content { flex: 1; }
  .tl-content h4 { font-weight: 700; font-size: 1rem; margin-bottom: 4px; }
  .tl-content p { font-size: 0.87rem; color: var(--text-light); }

  /* KEY INSIGHTS */
  .insight-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 16px;
    margin-bottom: 40px;
  }
  .insight-card {
    background: var(--card);
    border-radius: 12px;
    padding: 20px 22px;
    border: 1px solid var(--border);
    display: flex; gap: 16px;
  }
  .insight-icon { font-size: 1.6rem; flex-shrink: 0; }
  .insight-text h4 { font-weight: 700; font-size: 0.95rem; margin-bottom: 5px; }
  .insight-text p { font-size: 0.86rem; color: var(--text-light); }

  /* TABLE */
  .table-wrap { background: var(--card); border-radius: 14px; border: 1px solid var(--border); overflow: hidden; margin-bottom: 40px; box-shadow: 0 1px 4px rgba(0,0,0,0.06); }
  table { width: 100%; border-collapse: collapse; }
  th { background: var(--primary); color: white; font-size: 0.84rem; font-weight: 600; padding: 12px 16px; text-align: left; }
  td { font-size: 0.86rem; padding: 11px 16px; border-bottom: 1px solid var(--border); vertical-align: top; }
  tr:last-child td { border-bottom: none; }
  tr:nth-child(even) td { background: #fafbff; }
  td .ptag { display: inline-block; font-size: 11px; font-weight: 600; padding: 2px 8px; border-radius: 20px; }

  /* HEATMAP */
  .heatmap { display: flex; gap: 8px; flex-wrap: wrap; margin-bottom: 40px; }
  .hm-cell {
    border-radius: 8px; padding: 10px 14px;
    font-size: 0.82rem; font-weight: 600; color: white;
    cursor: default;
  }

  /* FOOTER */
  .footer {
    background: var(--primary);
    color: #a0aec0;
    text-align: center;
    padding: 30px 20px;
    font-size: 0.85rem;
  }
  .footer strong { color: white; }

  /* TAG COLORS */
  .tag-serving { background: #fef3c7; color: #92400e; }
  .tag-training { background: #d1fae5; color: #065f46; }
  .tag-infra { background: #dbeafe; color: #1e40af; }
  .tag-quantize { background: #ede9fe; color: #5b21b6; }
  .tag-agent { background: #fce7f3; color: #9d174d; }
  .tag-compiler { background: #e0f2fe; color: #0369a1; }
  .tag-federated { background: #f0fdf4; color: #166534; }
  .tag-hardware { background: #fff7ed; color: #9a3412; }
  .tag-security { background: #fef2f2; color: #991b1b; }
  .tag-misc { background: #f1f5f9; color: #475569; }

  /* BORDER COLORS FOR TREND CARDS */
  .bc1 { border-color: #e94560; }
  .bc2 { border-color: #0f3460; }
  .bc3 { border-color: #533483; }
  .bc4 { border-color: #f59e0b; }
  .bc5 { border-color: #10b981; }
  .bc6 { border-color: #06b6d4; }
  .bc7 { border-color: #6366f1; }
  .bc8 { border-color: #ec4899; }

  .horizon-near { background: #d1fae5; color: #065f46; }
  .horizon-mid { background: #fef3c7; color: #92400e; }
  .horizon-far { background: #ede9fe; color: #5b21b6; }

  @media (max-width: 700px) {
    .hero h1 { font-size: 1.7rem; }
    .paper-grid, .trend-grid, .insight-grid { grid-template-columns: 1fr; }
  }
</style>
</head>
<body>

<!-- HERO -->
<div class="hero">
  <div class="hero-inner">
    <div class="hero-badge">研究报告</div>
    <h1>MLSys 2026 <span>论文深度分析</span></h1>
    <p>对会议全部 135 篇录用论文进行系统分类、核心贡献提炼与未来技术趋势预测，覆盖 LLM 推理服务、训练系统、AI Agent、量化压缩、编译器等核心赛道。</p>
    <div class="hero-meta">
      <div class="hero-stat"><span class="num">135</span><span class="label">录用论文</span></div>
      <div class="hero-stat"><span class="num">10</span><span class="label">研究方向</span></div>
      <div class="hero-stat"><span class="num">48%</span><span class="label">推理/服务相关</span></div>
      <div class="hero-stat"><span class="num">8</span><span class="label">核心趋势预测</span></div>
    </div>
  </div>
</div>

<div class="container">

  <!-- ==================== 1. OVERVIEW ==================== -->
  <div class="section-title"><div class="dot"></div>论文分布全景</div>

  <div class="dist-grid">
    <div class="dist-card">
      <div class="cat-name">🚀 LLM 推理 & 服务</div>
      <div class="cat-count">~65</div>
      <div class="dist-bar-wrap"><div class="dist-bar" style="width:48%;background:linear-gradient(90deg,#e94560,#f97316)"></div></div>
      <div style="font-size:0.8rem;color:#64748b;">占比 ~48%，绝对主导地位</div>
    </div>
    <div class="dist-card">
      <div class="cat-name">⚡ 模型训练系统</div>
      <div class="cat-count">~25</div>
      <div class="dist-bar-wrap"><div class="dist-bar" style="width:19%;background:linear-gradient(90deg,#0f3460,#3b82f6)"></div></div>
      <div style="font-size:0.8rem;color:#64748b;">分布式训练、通信优化</div>
    </div>
    <div class="dist-card">
      <div class="cat-name">🤖 AI Agent 系统</div>
      <div class="cat-count">~14</div>
      <div class="dist-bar-wrap"><div class="dist-bar" style="width:10%;background:linear-gradient(90deg,#ec4899,#f43f5e)"></div></div>
      <div style="font-size:0.8rem;color:#64748b;">Agentic AI 新兴赛道</div>
    </div>
    <div class="dist-card">
      <div class="cat-name">🔧 量化 & 压缩</div>
      <div class="cat-count">~12</div>
      <div class="dist-bar-wrap"><div class="dist-bar" style="width:9%;background:linear-gradient(90deg,#533483,#8b5cf6)"></div></div>
      <div style="font-size:0.8rem;color:#64748b;">KV Cache、权重量化</div>
    </div>
    <div class="dist-card">
      <div class="cat-name">🛠 编译器 & 调度</div>
      <div class="cat-count">~9</div>
      <div class="dist-bar-wrap"><div class="dist-bar" style="width:7%;background:linear-gradient(90deg,#06b6d4,#0891b2)"></div></div>
      <div style="font-size:0.8rem;color:#64748b;">自动调优、IR编译</div>
    </div>
    <div class="dist-card">
      <div class="cat-name">🔒 联邦学习 & 隐私</div>
      <div class="cat-count">~5</div>
      <div class="dist-bar-wrap"><div class="dist-bar" style="width:4%;background:linear-gradient(90deg,#10b981,#059669)"></div></div>
      <div style="font-size:0.8rem;color:#64748b;">隐私计算、联邦微调</div>
    </div>
    <div class="dist-card">
      <div class="cat-name">💻 硬件 & 芯片协同</div>
      <div class="cat-count">~5</div>
      <div class="dist-bar-wrap"><div class="dist-bar" style="width:4%;background:linear-gradient(90deg,#f59e0b,#d97706)"></div></div>
      <div style="font-size:0.8rem;color:#64748b;">ASIC、NoC 设计</div>
    </div>
  </div>

  <!-- ==================== 2. SPOTLIGHT PAPERS ==================== -->
  <div class="section-title"><div class="dot"></div>重点论文解析（精选 30 篇）</div>

  <!-- 2.1 LLM Inference & Serving -->
  <h3 style="font-size:1.05rem;font-weight:700;color:#1a1a2e;margin-bottom:16px;padding-left:14px;border-left:3px solid #e94560;">
    🚀 LLM 推理 &amp; 服务
  </h3>
  <div class="paper-grid">

    <div class="paper-card">
      <span class="ptag tag-serving">推理服务</span>
      <h3>FlashAttention-4: Algorithm and Kernel Pipelining Co-Design for Asymmetric Hardware Scaling</h3>
      <div class="desc">FA 系列第四代，针对最新 GPU 异构计算单元（TMA/WGMMA/Tensor Core 不对称性）进行算法级与 Kernel 级流水线协同设计，推动 Attention 效率进一步突破。</div>
      <div class="authors">Ted Zadouri, Markus Hoehnerbach, Jay Shah et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-serving">推理服务</span>
      <h3>MorphServe: Efficient and Workload-Aware LLM Serving via Runtime Quantized Layer Swapping and KV Cache Resizing</h3>
      <div class="desc">运行时动态调整量化层精度与 KV Cache 大小，在负载感知的基础上实现延迟与吞吐量的联合优化，开创"弹性精度服务"新范式。</div>
      <div class="authors">Zhaoyuan Su, Zeyu Zhang, Tingfeng Lan et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-serving">推理服务</span>
      <h3>Speculative Decoding: Performance or Illusion?</h3>
      <div class="desc">对投机解码的实际收益进行系统性评估，区分真实加速与虚假增益，指出在 RL 训练场景中推测解码可能带来负效益，引发方法论反思。</div>
      <div class="authors">Lily Liu, Jiaxiang Yu, Jongseok Park, Ion Stoica et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-serving">推理服务</span>
      <h3>HELIOS: Adaptive Model And Early-Exit Selection for Efficient LLM Inference</h3>
      <div class="desc">结合模型选择与早退机制，自适应地为不同请求分配不同深度的计算路径，在 SLO 约束下最大化推理效率。</div>
      <div class="authors">Avinash Kumar, Shashank Nag, Jason Clemons et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-serving">推理服务</span>
      <h3>BatchLLM: Optimizing Large Batched LLM Inference with Global Prefix Sharing and Throughput-oriented Token Batching</h3>
      <div class="desc">针对大批量推理场景的全局 Prefix 共享策略，与面向吞吐的 Token 批调度算法，显著降低大规模 Batch 场景的显存占用与延迟。</div>
      <div class="authors">Zhen Zheng, Xin Ji, Taosong Fang et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-serving">推理服务</span>
      <h3>Breaking the Ice: Analyzing Cold Start Latency in vLLM</h3>
      <div class="desc">首次系统分析 vLLM 冷启动延迟成因，涵盖模型加载、CUDA 上下文初始化、KV Cache 预分配等各阶段，并提出针对性优化策略。</div>
      <div class="authors">Huzaifa Shaaban Kabakibo, Animesh Trivedi, Lin Wang</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-serving">推理服务</span>
      <h3>Beyond the Buzz: A Pragmatic Take on Inference Disaggregation</h3>
      <div class="desc">理性评估 Prefill/Decode 分离部署的真实收益与代价，结合工程实践给出选择分离架构的量化决策框架，避免盲目跟风。</div>
      <div class="authors">Tiyasa Mitra, Ritika Borkar, Nidhi Bhatia et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-serving">推理服务</span>
      <h3>SuperInfer: SLO-Aware Rotary Scheduling and Memory Management for LLM Inference on Superchips</h3>
      <div class="desc">针对超级芯片（如 Grace Hopper）的 LLM 推理调度优化，利用旋转调度算法与精细化内存管理满足严格 SLO 约束。</div>
      <div class="authors">Jiahuan Yu, Mingtao Hu, Minjia Zhang et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-serving">推理服务</span>
      <h3>SHIP: SRAM-Based Huge Inference Pipelines for Fast LLM Serving</h3>
      <div class="desc">充分利用片上 SRAM 构建多级流水线推理架构，在延迟敏感场景下突破 HBM 带宽瓶颈。</div>
      <div class="authors">（多位作者）</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-serving">推理服务</span>
      <h3>Demystifying the Mixture of Experts Serving Tax</h3>
      <div class="desc">量化 MoE 推理相比 Dense 模型的额外开销来源（路由、通信、负载均衡），为 MoE 服务系统设计提供指导。</div>
      <div class="authors">Pratyush Patel, Arvind Krishnamurthy</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-serving">推理服务</span>
      <h3>TriInfer: Hybrid EPD Disaggregation for Efficient Multimodal Large Language Model Inference</h3>
      <div class="desc">为多模态 LLM 设计三阶段（Encode-Prefill-Decode）混合分离架构，实现视觉编码与语言推理的解耦调度。</div>
      <div class="authors">Xianzhe Dong, Tongxuan Liu et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-serving">投机解码</span>
      <h3>SpecDiff-2: Scaling Diffusion Drafter Alignment for Faster Speculative Decoding</h3>
      <div class="desc">将扩散模型作为投机解码的 Draft 模型，并通过对齐训练提升接受率，为超长序列生成提供新路径。</div>
      <div class="authors">Wenhao Zheng, Zhengzhong Liu et al.</div>
    </div>

  </div>

  <!-- 2.2 Training Systems -->
  <h3 style="font-size:1.05rem;font-weight:700;color:#1a1a2e;margin:24px 0 16px;padding-left:14px;border-left:3px solid #3b82f6;">
    ⚡ 模型训练系统
  </h3>
  <div class="paper-grid">

    <div class="paper-card">
      <span class="ptag tag-training">训练系统</span>
      <h3>MoEBlaze: Breaking the Memory Wall for Efficient MoE Training on Modern GPUs</h3>
      <div class="desc">针对 MoE 训练的显存墙问题，设计内存感知的专家分片与激活重计算策略，支持在单节点 GPU 集群上训练千亿级 MoE 模型。</div>
      <div class="authors">Jiyuan Zhang, Yining Liu, Siqi Yan et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-training">训练系统</span>
      <h3>AXLearn: Modular, Hardware-Agnostic Large Model Training</h3>
      <div class="desc">苹果开源的大模型训练框架，强调硬件无关性与模块化设计，支持 TPU/GPU 统一训练接口，已在生产环境验证。</div>
      <div class="authors">Mark Lee, Tom Gunter, Chang Lan et al. (Apple)</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-training">训练系统</span>
      <h3>DreamDDP: Accelerating Low-Bandwidth Geo-Distributed LLM Training with Layer-wise Partial Synchronization</h3>
      <div class="desc">为跨地域分布式训练设计逐层部分同步策略，大幅降低跨 WAN 通信量，实现弱网环境下的高效 LLM 训练。</div>
      <div class="authors">Zhenheng Tang, Zichen Tang et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-training">训练系统</span>
      <h3>MTraining: Distributed Dynamic Sparse Attention for Efficient Ultra-Long Context Training</h3>
      <div class="desc">通过动态稀疏注意力机制支持超长上下文（百万级 Token）的分布式训练，突破标准全注意力的内存与计算瓶颈。</div>
      <div class="authors">Wenxuan Li, Chengruidong Zhang, Huiqiang Jiang et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-training">训练系统</span>
      <h3>HetRL: Efficient Reinforcement Learning for LLMs in Heterogeneous Environments</h3>
      <div class="desc">面向 RLHF/RLVR 场景的异构 RL 训练系统，支持在不同规格 GPU 混合集群上高效运行 Actor/Critic，降低强化学习阶段的资源成本。</div>
      <div class="authors">Yongjun He et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-training">训练系统</span>
      <h3>FlexTrain: Scalable Hybrid-Parallel LLM Training with Elastic Resource Utilization and Consistent Accuracy</h3>
      <div class="desc">弹性混合并行训练框架，支持动态调整数据/张量/流水线并行度，在资源波动场景下保持训练精度稳定。</div>
      <div class="authors">Weilin Cai, Diandian Gu et al.</div>
    </div>

  </div>

  <!-- 2.3 AI Agent Systems -->
  <h3 style="font-size:1.05rem;font-weight:700;color:#1a1a2e;margin:24px 0 16px;padding-left:14px;border-left:3px solid #ec4899;">
    🤖 AI Agent 系统
  </h3>
  <div class="paper-grid">

    <div class="paper-card">
      <span class="ptag tag-agent">Agent 系统</span>
      <h3>The OpenHands Software Agent SDK: A Composable and Extensible Foundation for Production Agents</h3>
      <div class="desc">开源软件 Agent SDK，提供可组合、可扩展的生产级 Agent 基础设施，支持工具调用、沙箱执行、状态持久化等核心能力。</div>
      <div class="authors">Xingyao Wang et al. (OpenHands Team)</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-agent">Agent 系统</span>
      <h3>Hippocampus: An Efficient and Scalable Memory Module for Agentic AI</h3>
      <div class="desc">受海马体启发的 Agent 记忆模块，支持层次化长短期记忆管理，在多轮对话与长任务中显著提升 Agent 的上下文利用效率。</div>
      <div class="authors">Yi Li, Lianjie Cao, Faraz Ahmed et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-agent">Agent 系统</span>
      <h3>ADS: An Agentic Detection System for Enterprise Agentic AI Security</h3>
      <div class="desc">企业级 Agentic AI 安全检测系统，识别 Prompt 注入、工具滥用、数据泄露等威胁，为 Agent 部署提供安全护栏。</div>
      <div class="authors">Chenning Li, Pan Hu, Justin Xu et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-agent">Agent 系统</span>
      <h3>FlashAgents: Accelerating Multi-Agent LLM Systems via Streaming Prefill Overlap</h3>
      <div class="desc">通过流式 Prefill 重叠机制加速多 Agent 协作场景的 LLM 推理，减少 Agent 间通信等待，提升端到端响应速度。</div>
      <div class="authors">Taosong Fang, Zhen Zheng et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-agent">Agent 系统</span>
      <h3>AgenticCache: Cache-Driven Asynchronous Planning for Embodied AI Agents</h3>
      <div class="desc">为具身 Agent 设计缓存驱动的异步规划框架，利用感知缓存避免重复推理，大幅提升机器人决策的实时性。</div>
      <div class="authors">Hojoon Kim, Yuheng Wu, Thierry Tambe</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-agent">Agent 系统</span>
      <h3>OSWorld-Human: Benchmarking the Efficiency of Computer-Use Agents</h3>
      <div class="desc">计算机操作 Agent 的效率评测基准，引入人类操作对照数据，从任务完成率、步骤效率、错误恢复等多维度量化 Agent 性能。</div>
      <div class="authors">（多位作者）</div>
    </div>

  </div>

  <!-- 2.4 Quantization & Compression -->
  <h3 style="font-size:1.05rem;font-weight:700;color:#1a1a2e;margin:24px 0 16px;padding-left:14px;border-left:3px solid #8b5cf6;">
    🔧 量化 &amp; 压缩
  </h3>
  <div class="paper-grid">

    <div class="paper-card">
      <span class="ptag tag-quantize">量化压缩</span>
      <h3>NVFP4 Search Your Scales!</h3>
      <div class="desc">NVIDIA FP4 格式下的量化缩放因子搜索算法，解决超低精度量化的精度保持难题，为下一代 GPU（Blackwell）的 FP4 推理铺路。</div>
      <div class="authors">Tanmaey Gupta, Hayden Prairie, Xiaoxia Wu et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-quantize">量化压缩</span>
      <h3>Kitty: Accurate and Efficient 2-bit KV Cache Quantization with Dynamic Channel-wise Precision Boost</h3>
      <div class="desc">KV Cache 极致压缩至 2-bit，引入动态通道精度提升机制保护重要通道，在极低 bit-width 下维持推理质量。</div>
      <div class="authors">Haojun Xia, Xiaoxia Wu et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-quantize">量化压缩</span>
      <h3>FP8-Flow-MoE: A Casting-Free FP8 Recipe without Double Quantization Error</h3>
      <div class="desc">专为 MoE 模型设计的无投射 FP8 量化方案，消除二次量化误差，在 FP8 训练与推理的精度-效率 trade-off 上取得新突破。</div>
      <div class="authors">Fengjuan Wang, Zhiyi Su et al.</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-quantize">量化压缩</span>
      <h3>SkipKV: Selective Skipping of KV Generation and Storage for Efficient Inference with Large Reasoning Models</h3>
      <div class="desc">针对长链推理（Chain-of-Thought）模型，选择性跳过中间推理步骤的 KV 缓存生成，显著降低 KV Cache 内存占用。</div>
      <div class="authors">Jiayi Tian, Seyedarmin Azizi et al.</div>
    </div>

  </div>

  <!-- 2.5 Compiler & Scheduling -->
  <h3 style="font-size:1.05rem;font-weight:700;color:#1a1a2e;margin:24px 0 16px;padding-left:14px;border-left:3px solid #06b6d4;">
    🛠 编译器 &amp; 调度优化
  </h3>
  <div class="paper-grid">

    <div class="paper-card">
      <span class="ptag tag-compiler">编译器</span>
      <h3>CATWILD: Compiler Autotuning for TPU Workloads in the Wild</h3>
      <div class="desc">谷歌针对 TPU 生产负载的编译器自动调优系统，利用 ML 反馈驱动调优，覆盖"野外"真实工作负载的多样性与复杂性。</div>
      <div class="authors">Ignacio Cano, Yu Wang, Phitchaya Phothilimthana et al. (Google)</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-compiler">编译器</span>
      <h3>WAVE: A Symbolic Python DSL and Compiler for High Performance Machine Learning</h3>
      <div class="desc">符号化 Python DSL 及其配套编译器，支持将高层 ML 计算描述直接编译到高性能核函数，降低 Kernel 工程门槛。</div>
      <div class="authors">Harsh Menon et al. (AMD)</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-compiler">编译器</span>
      <h3>Agentic Operator Generation for ML ASICs</h3>
      <div class="desc">利用 LLM Agent 自动生成 ML 专用 ASIC 的算子代码，打通从算法规格到硬件实现的自动化链路，加速 AI 芯片研发。</div>
      <div class="authors">Aram Markosyan, Aman Dontula et al. (Meta)</div>
    </div>

    <div class="paper-card">
      <span class="ptag tag-compiler">编译器</span>
      <h3>SchedFlow: Unified Transparent and Flexible Intra-Device Parallelism via Programmable Operator Scheduling</h3>
      <div class="desc">可编程算子调度框架，统一设备内并行策略，支持在不修改算子代码的情况下灵活切换调度策略。</div>
      <div class="authors">Yi Pan, Yile Gu et al.</div>
    </div>

  </div>

  <!-- ==================== 3. FULL PAPER LIST TABLE ==================== -->
  <div class="section-title"><div class="dot"></div>全部论文分类总览</div>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>#</th>
          <th>论文名称</th>
          <th>方向</th>
          <th>核心贡献摘要</th>
        </tr>
      </thead>
      <tbody>
        <tr><td>1</td><td>FlashAttention-4</td><td><span class="ptag tag-serving">推理服务</span></td><td>FA4 算法与 Kernel 流水线协同设计，针对不对称硬件缩放</td></tr>
        <tr><td>2</td><td>MorphServe</td><td><span class="ptag tag-serving">推理服务</span></td><td>运行时量化层切换 + KV Cache 动态调整，负载感知服务</td></tr>
        <tr><td>3</td><td>PLA-Serve</td><td><span class="ptag tag-serving">推理服务</span></td><td>Prefill 长度感知的 LLM 服务系统，优化首 Token 延迟</td></tr>
        <tr><td>4</td><td>SpecDiff-2</td><td><span class="ptag tag-serving">投机解码</span></td><td>Diffusion 模型作为 Draft，扩展投机解码到扩散范式</td></tr>
        <tr><td>5</td><td>LLMInfer-Bench</td><td><span class="ptag tag-serving">基准测试</span></td><td>LLM 推理系统综合基准，多维度性能对比</td></tr>
        <tr><td>6</td><td>Meeting SLOs, Slashing Hours</td><td><span class="ptag tag-serving">推理服务</span></td><td>企业级 LLM 优化，SLO 达标的同时大幅降低推理成本</td></tr>
        <tr><td>7</td><td>OptiKIT</td><td><span class="ptag tag-serving">推理服务</span></td><td>AI 驱动企业 LLM 推理优化工具包</td></tr>
        <tr><td>8</td><td>Hippocampus</td><td><span class="ptag tag-agent">Agent</span></td><td>高效可扩展的 Agentic AI 记忆模块</td></tr>
        <tr><td>9</td><td>IntAttention</td><td><span class="ptag tag-quantize">量化</span></td><td>全整数注意力流水线，面向边缘推理</td></tr>
        <tr><td>10</td><td>Using Span Queries</td><td><span class="ptag tag-infra">基础设施</span></td><td>Span 查询优化 Cache 与 Attention 局部性</td></tr>
        <tr><td>11</td><td>NEST: Network/Memory-Aware Device Placement</td><td><span class="ptag tag-training">训练系统</span></td><td>分布式深度学习的网络感知设备放置</td></tr>
        <tr><td>12</td><td>FP8-Flow-MoE</td><td><span class="ptag tag-quantize">量化</span></td><td>MoE 无投射 FP8 方案</td></tr>
        <tr><td>13</td><td>FlexiCache</td><td><span class="ptag tag-serving">KV Cache</span></td><td>利用注意力头时序稳定性的 KV Cache 管理</td></tr>
        <tr><td>14</td><td>Efficient Long-Context LM Training</td><td><span class="ptag tag-training">训练系统</span></td><td>核心注意力分离架构支持超长上下文训练</td></tr>
        <tr><td>15</td><td>Agentic Operator Generation for ML ASICs</td><td><span class="ptag tag-compiler">编译器</span></td><td>Agent 自动生成 ASIC 算子</td></tr>
        <tr><td>16</td><td>ADS: Agentic Detection System</td><td><span class="ptag tag-security">安全</span></td><td>企业级 Agentic AI 安全检测系统</td></tr>
        <tr><td>17</td><td>Accelerating Large-Scale Reasoning with Sparse Self-Speculative Decoding</td><td><span class="ptag tag-serving">投机解码</span></td><td>稀疏自投机解码加速大规模推理模型</td></tr>
        <tr><td>18</td><td>ProToken</td><td><span class="ptag tag-federated">联邦学习</span></td><td>联邦大模型 Token 级归因</td></tr>
        <tr><td>19</td><td>Beyond the Buzz: Inference Disaggregation</td><td><span class="ptag tag-serving">推理服务</span></td><td>推理分离的务实评估框架</td></tr>
        <tr><td>20</td><td>Blueprint/Bootstrap/Bridge: NVIDIA GPU Confidential Computing</td><td><span class="ptag tag-security">安全</span></td><td>NVIDIA GPU 机密计算安全综述</td></tr>
        <tr><td>21</td><td>BEAM: Joint Resource-Power Optimization</td><td><span class="ptag tag-serving">推理服务</span></td><td>SLO 约束下的能效联合优化</td></tr>
        <tr><td>22</td><td>Learning from Less (RLVR)</td><td><span class="ptag tag-training">训练系统</span></td><td>低数据量 RLVR 有效性评估</td></tr>
        <tr><td>23</td><td>SkipKV</td><td><span class="ptag tag-quantize">量化</span></td><td>大推理模型的 KV 生成与存储选择性跳过</td></tr>
        <tr><td>24</td><td>SchedFlow</td><td><span class="ptag tag-compiler">编译器</span></td><td>可编程算子调度支持灵活设备内并行</td></tr>
        <tr><td>25</td><td>LLM Model for Power/Performance/Area Prediction</td><td><span class="ptag tag-hardware">硬件</span></td><td>从硬件代码预测 PPA 指标</td></tr>
        <tr><td>26</td><td>BLASST: Dynamic Attention Sparsity via Softmax Thresholding</td><td><span class="ptag tag-serving">推理服务</span></td><td>动态块稀疏注意力，Softmax 阈值化实现</td></tr>
        <tr><td>27</td><td>Spira: Voxel Sparse Convolution</td><td><span class="ptag tag-infra">特定场景</span></td><td>点云网络高效稀疏卷积</td></tr>
        <tr><td>28</td><td>CAGE: Curvature-Aware Quantization-Aware Training</td><td><span class="ptag tag-quantize">量化</span></td><td>曲率感知梯度估计提升 QAT 精度</td></tr>
        <tr><td>29</td><td>ApproxMLIR: Accuracy-Aware Compiler</td><td><span class="ptag tag-compiler">编译器</span></td><td>精度感知 ML 系统编译器</td></tr>
        <tr><td>30</td><td>Privatar: Privacy-preserving Multi-user VR</td><td><span class="ptag tag-security">安全/隐私</span></td><td>安全卸载的可扩展多用户 VR</td></tr>
        <tr><td>31</td><td>Scaling Up LLM Serving for Semantic Job Search</td><td><span class="ptag tag-serving">推理服务</span></td><td>语义职位搜索的 LLM 服务系统扩展</td></tr>
        <tr><td>32</td><td>NVFP4 Search Your Scales</td><td><span class="ptag tag-quantize">量化</span></td><td>FP4 量化缩放因子搜索</td></tr>
        <tr><td>33</td><td>Zero Redundancy Distributed Learning with Differential Privacy</td><td><span class="ptag tag-federated">隐私</span></td><td>零冗余差分隐私分布式训练</td></tr>
        <tr><td>34</td><td>PRISM: Parametrically Restructured Inference for Speculative Sampling</td><td><span class="ptag tag-serving">投机解码</span></td><td>参数化重组推理加速投机采样</td></tr>
        <tr><td>35</td><td>WAVE: Symbolic Python DSL and Compiler</td><td><span class="ptag tag-compiler">编译器</span></td><td>AMD 高性能 ML 符号编译器</td></tr>
        <tr><td>36</td><td>MoEBlaze</td><td><span class="ptag tag-training">训练系统</span></td><td>打破 MoE 训练显存墙</td></tr>
        <tr><td>37</td><td>FreeScale</td><td><span class="ptag tag-training">训练系统</span></td><td>推荐模型序列低代价分布式训练</td></tr>
        <tr><td>38</td><td>When Enough is Enough: Rank-Aware Early Termination for Vector Search</td><td><span class="ptag tag-infra">基础设施</span></td><td>向量搜索排名感知早退机制</td></tr>
        <tr><td>39</td><td>Once-for-All Channel Mixers (HyperTinyPW)</td><td><span class="ptag tag-quantize">压缩</span></td><td>TinyML 生成式压缩</td></tr>
        <tr><td>40</td><td>FlashAttention-4</td><td><span class="ptag tag-serving">推理服务</span></td><td>（同上）</td></tr>
        <tr><td>41</td><td>AIRS: Scaling Live Inference in Resource-Constrained Environments</td><td><span class="ptag tag-infra">基础设施</span></td><td>资源约束环境的实时推理扩展</td></tr>
        <tr><td>42</td><td>CATWILD</td><td><span class="ptag tag-compiler">编译器</span></td><td>谷歌 TPU 生产编译器自动调优</td></tr>
        <tr><td>43</td><td>PROMPTS: Multi-Agent Planning for LLM Training and Serving</td><td><span class="ptag tag-agent">Agent</span></td><td>多 Agent 协同规划优化 LLM 训练与服务性能</td></tr>
        <tr><td>44</td><td>ML Fleet Efficiency: Improving TPU Systems at Scale</td><td><span class="ptag tag-infra">基础设施</span></td><td>Google TPU 机群效率与 ML 生产力度量</td></tr>
        <tr><td>45</td><td>XProf: Open, Scalable ML Profiling System</td><td><span class="ptag tag-infra">基础设施</span></td><td>现代 ML 栈的开源可扩展剖析系统</td></tr>
        <tr><td>46</td><td>MTraining: Ultra-Long Context Training</td><td><span class="ptag tag-training">训练系统</span></td><td>分布式动态稀疏注意力超长上下文训练</td></tr>
        <tr><td>47</td><td>Stream2LLM: Streaming Context Prefill</td><td><span class="ptag tag-serving">推理服务</span></td><td>流式上下文传输与 Prefill 重叠减少 TTFT</td></tr>
        <tr><td>48</td><td>REPARO: Loss-Resilient Generative Video Codec</td><td><span class="ptag tag-infra">视频</span></td><td>生成式视频会议编解码器</td></tr>
        <tr><td>49</td><td>ZK-APEX: Zero-Knowledge Approximate Personalized Unlearning</td><td><span class="ptag tag-security">安全/隐私</span></td><td>零知识证明的近似个性化遗忘</td></tr>
        <tr><td>50</td><td>Automated Algorithm Design for Auto-Tuning Optimizers</td><td><span class="ptag tag-compiler">编译器</span></td><td>自动调优优化器的算法自动设计</td></tr>
        <tr><td>51</td><td>Ontology-Guided Long-Term Memory for RAG</td><td><span class="ptag tag-agent">Agent</span></td><td>本体引导的 RAG 对话长期记忆</td></tr>
        <tr><td>52</td><td>From Tokens to Layers: Stall-Free Scheduling with Layered Prefill</td><td><span class="ptag tag-serving">推理服务</span></td><td>分层 Prefill 无停顿 LLM 服务调度</td></tr>
        <tr><td>53</td><td>AXLearn</td><td><span class="ptag tag-training">训练系统</span></td><td>苹果模块化硬件无关大模型训练框架</td></tr>
        <tr><td>54</td><td>ProfInfer: eBPF-based LLM Inference Profiler</td><td><span class="ptag tag-infra">基础设施</span></td><td>基于 eBPF 的细粒度 LLM 推理分析器</td></tr>
        <tr><td>55</td><td>Event Tensor: Unified Abstraction for Dynamic Megakernel Compilation</td><td><span class="ptag tag-compiler">编译器</span></td><td>动态大 Kernel 编译的统一事件张量抽象</td></tr>
        <tr><td>56</td><td>HELIOS: Adaptive Early-Exit for LLM Inference</td><td><span class="ptag tag-serving">推理服务</span></td><td>自适应模型与早退联合选择</td></tr>
        <tr><td>57</td><td>NodeSweep: Straggler Detection for Foundation Model Training</td><td><span class="ptag tag-infra">基础设施</span></td><td>大规模基础模型训练的慢节点检测与健康监控</td></tr>
        <tr><td>58</td><td>AgenticCache</td><td><span class="ptag tag-agent">Agent</span></td><td>具身 Agent 缓存驱动异步规划</td></tr>
        <tr><td>59</td><td>ProTrain: LLM Training via Automatic Memory Management</td><td><span class="ptag tag-training">训练系统</span></td><td>自动内存管理的高效 LLM 训练</td></tr>
        <tr><td>60</td><td>CDLM: Consistency Diffusion Language Models</td><td><span class="ptag tag-serving">推理</span></td><td>一致性扩散语言模型加速采样</td></tr>
        <tr><td>61</td><td>Pylo: Learned Optimizers in PyTorch</td><td><span class="ptag tag-training">训练系统</span></td><td>PyTorch 中可访问的学习式优化器</td></tr>
        <tr><td>62</td><td>RDMA Point-to-Point Communication for LLM Systems</td><td><span class="ptag tag-infra">基础设施</span></td><td>LLM 系统 RDMA 点对点通信</td></tr>
        <tr><td>63</td><td>TiDAR: Think in Diffusion, Talk in Autoregression</td><td><span class="ptag tag-serving">生成</span></td><td>扩散思考 + 自回归输出的混合生成范式</td></tr>
        <tr><td>64</td><td>ParallelKittens: Simplification of Multi-GPU AI Kernels</td><td><span class="ptag tag-compiler">编译器</span></td><td>多 GPU AI Kernel 系统化简化框架</td></tr>
        <tr><td>65</td><td>PLayer-FL: Personalized Layer-wise Cross-Silo Federated Learning</td><td><span class="ptag tag-federated">联邦学习</span></td><td>原则化逐层个性化跨孤岛联邦学习</td></tr>
        <tr><td>66</td><td>AccelOpt: Self-Improving LLM Agentic System for AI Accelerator Kernel Optimization</td><td><span class="ptag tag-agent">Agent</span></td><td>LLM Agent 自改进加速器 Kernel 优化</td></tr>
        <tr><td>67</td><td>DisAgg: Distributed Aggregators for Secure Aggregation</td><td><span class="ptag tag-federated">联邦学习</span></td><td>高效安全聚合的分布式聚合器</td></tr>
        <tr><td>68</td><td>RagInfer: Efficient RAG Inference with Lookahead Retrieval</td><td><span class="ptag tag-serving">RAG</span></td><td>超前检索的高效 RAG 推理</td></tr>
        <tr><td>69</td><td>VeriMoA: Mixture-of-Agents for Spec-to-HDL Generation</td><td><span class="ptag tag-agent">Agent</span></td><td>多 Agent 框架辅助 HDL 硬件代码生成</td></tr>
        <tr><td>70</td><td>BOOST: Bottleneck-Optimized Scalable Training for LoRA LLMs</td><td><span class="ptag tag-training">训练系统</span></td><td>低秩大模型的瓶颈优化可扩展训练</td></tr>
        <tr><td>71</td><td>SONAR: Benchmarking Topology in Decentralized Learning</td><td><span class="ptag tag-training">训练系统</span></td><td>去中心化学习的拓扑与协作基准</td></tr>
        <tr><td>72</td><td>VM NUMA Placement at Scale</td><td><span class="ptag tag-infra">基础设施</span></td><td>大规模 NUMA 感知虚拟机放置学习</td></tr>
        <tr><td>73</td><td>SHIP: SRAM-Based Inference Pipelines</td><td><span class="ptag tag-serving">推理服务</span></td><td>SRAM 流水线快速 LLM 服务</td></tr>
        <tr><td>74</td><td>HipKittens: Fast AMD Kernels</td><td><span class="ptag tag-compiler">编译器</span></td><td>AMD GPU 高性能 Kernel 框架</td></tr>
        <tr><td>75</td><td>RaidServe: High-performance Resilient Serving</td><td><span class="ptag tag-serving">推理服务</span></td><td>高性能容灾 LLM 服务系统</td></tr>
        <tr><td>76</td><td>Beat the Long Tail: Distribution-Aware Speculative Decoding for RL Training</td><td><span class="ptag tag-serving">投机解码</span></td><td>面向 RL 训练的分布感知投机解码</td></tr>
        <tr><td>77</td><td>db-SP: Dual-Balanced Sequence Parallelism for Visual Generative Models</td><td><span class="ptag tag-training">训练系统</span></td><td>视觉生成模型稀疏注意力加速</td></tr>
        <tr><td>78</td><td>When ML Isn't Sure: Resilient ML-Based Computer Systems</td><td><span class="ptag tag-infra">基础设施</span></td><td>拥抱不确定性构建弹性 ML 计算机系统</td></tr>
        <tr><td>79</td><td>Cost-aware Duration Prediction for Software Upgrades</td><td><span class="ptag tag-infra">基础设施</span></td><td>数据中心软件升级时长的代价感知预测</td></tr>
        <tr><td>80</td><td>Shannonic: Efficient Entropy-Optimal Compression</td><td><span class="ptag tag-infra">压缩</span></td><td>ML 负载的熵最优高效压缩</td></tr>
        <tr><td>81</td><td>FlexTrain</td><td><span class="ptag tag-training">训练系统</span></td><td>弹性资源混合并行 LLM 训练</td></tr>
        <tr><td>82</td><td>Toward Principled Safety Testing: Solving the Jailbreak Oracle Problem</td><td><span class="ptag tag-security">安全</span></td><td>越狱攻击的 Oracle 问题原则化安全测试</td></tr>
        <tr><td>83</td><td>Unleashing Scalable Context Parallelism (FCP)</td><td><span class="ptag tag-training">训练系统</span></td><td>FCP 解锁基础模型预训练的上下文并行</td></tr>
        <tr><td>84</td><td>CRAFT: Cost-aware Expert Replica Allocation</td><td><span class="ptag tag-serving">MoE</span></td><td>细粒度逐层 MoE 专家副本代价感知分配</td></tr>
        <tr><td>85</td><td>G-HEMP: Fast Multi-GPU Private Inference for GCNs with HE</td><td><span class="ptag tag-security">安全/隐私</span></td><td>同态加密下大规模 GCN 多 GPU 隐私推理</td></tr>
        <tr><td>86</td><td>RAGBoost: Efficient RAG with Accuracy-Preserving Context Reuse</td><td><span class="ptag tag-serving">RAG</span></td><td>精度保持的 RAG 上下文复用加速</td></tr>
        <tr><td>87</td><td>StreamDiffusionV2</td><td><span class="ptag tag-serving">生成</span></td><td>动态交互视频生成的流式系统</td></tr>
        <tr><td>88</td><td>EarthSight: Distributed Low-Latency Satellite Intelligence</td><td><span class="ptag tag-infra">边缘</span></td><td>低延迟卫星边缘 AI 分布式框架</td></tr>
        <tr><td>89</td><td>GhostServe: Lightweight Checkpointing for Fault-Tolerant LLM Serving</td><td><span class="ptag tag-serving">推理服务</span></td><td>影子检查点轻量级容错 LLM 服务</td></tr>
        <tr><td>90</td><td>MixLLM: Mixed-precision LLM Quantization</td><td><span class="ptag tag-quantize">量化</span></td><td>输出特征级全局混合精度量化</td></tr>
        <tr><td>91</td><td>FLoRIST: SVD Thresholding for Federated Fine-Tuning</td><td><span class="ptag tag-federated">联邦学习</span></td><td>奇异值阈值化的高效准确联邦微调</td></tr>
        <tr><td>92</td><td>DriftBench: Measuring and Predicting Infrastructure Drift</td><td><span class="ptag tag-infra">基础设施</span></td><td>LLM 服务系统基础设施漂移测量与预测</td></tr>
        <tr><td>93</td><td>Grolar: Efficient LLM Training on Heterogeneous Clusters</td><td><span class="ptag tag-training">训练系统</span></td><td>异构集群高效 LLM 训练</td></tr>
        <tr><td>94</td><td>Flashlight: PyTorch Compiler Extensions for Attention Variants</td><td><span class="ptag tag-compiler">编译器</span></td><td>PyTorch 编译器扩展加速注意力变体</td></tr>
        <tr><td>95</td><td>DreamDDP</td><td><span class="ptag tag-training">训练系统</span></td><td>低带宽跨地域 LLM 训练逐层部分同步</td></tr>
        <tr><td>96</td><td>Locality-Aware Beam Scheduling for Test-Time Compute</td><td><span class="ptag tag-serving">推理服务</span></td><td>消费级 GPU 的局部感知 Beam 调度测试时计算</td></tr>
        <tr><td>97</td><td>OPKV: High-Throughput Plugin-Driven Recallable Sparsity in Paged KV Cache</td><td><span class="ptag tag-serving">KV Cache</span></td><td>分页 KV Cache 可召回稀疏插件框架</td></tr>
        <tr><td>98</td><td>SuperInfer</td><td><span class="ptag tag-serving">推理服务</span></td><td>超级芯片上的 SLO 感知轮转调度</td></tr>
        <tr><td>99</td><td>Breaking the Ice: Cold Start in vLLM</td><td><span class="ptag tag-serving">推理服务</span></td><td>vLLM 冷启动延迟分析</td></tr>
        <tr><td>100</td><td>BatchLLM</td><td><span class="ptag tag-serving">推理服务</span></td><td>全局 Prefix 共享 + 吞吐导向批处理</td></tr>
        <tr><td>101</td><td>ExecuTorch: Unified PyTorch Mobile/On-Device ML</td><td><span class="ptag tag-infra">端侧</span></td><td>Meta 统一端侧 PyTorch ML 解决方案</td></tr>
        <tr><td>102</td><td>Rethinking DVFS for Mobile LLMs</td><td><span class="ptag tag-infra">端侧</span></td><td>移动端 LLM 统一能效感知 DVFS 调度</td></tr>
        <tr><td>103</td><td>TokenBlend: Accelerating TP LLM Inference via Compute-Communication Overlap</td><td><span class="ptag tag-serving">推理服务</span></td><td>张量并行 LLM 推理计算通信重叠</td></tr>
        <tr><td>104</td><td>Matrix: Peer-to-Peer Multi-Agent Synthetic Data Generation</td><td><span class="ptag tag-agent">Agent</span></td><td>多 Agent 点对点合成数据生成框架</td></tr>
        <tr><td>105</td><td>Parrot: Persuasion and Agreement Robustness Rating</td><td><span class="ptag tag-security">安全</span></td><td>LLM 输出真实性的说服与一致性鲁棒性评级</td></tr>
        <tr><td>106</td><td>Kitty: 2-bit KV Cache Quantization</td><td><span class="ptag tag-quantize">量化</span></td><td>动态通道精度提升的 2-bit KV Cache</td></tr>
        <tr><td>107</td><td>FlexScale: High-Performance FSDP at Scale</td><td><span class="ptag tag-training">训练系统</span></td><td>灵活高性能大规模 FSDP</td></tr>
        <tr><td>108</td><td>HetRL</td><td><span class="ptag tag-training">训练系统</span></td><td>异构环境 LLM 强化学习</td></tr>
        <tr><td>109</td><td>Massive-Scale Out-Of-Core UMAP on GPU</td><td><span class="ptag tag-infra">数据处理</span></td><td>超大规模 GPU 外存 UMAP 降维</td></tr>
        <tr><td>110</td><td>HexiScale: LLM Training over Heterogeneous Hardware</td><td><span class="ptag tag-training">训练系统</span></td><td>异构硬件大模型训练</td></tr>
        <tr><td>111</td><td>BOute: Cost-Efficient LLM Serving with Heterogeneous LLMs/GPUs</td><td><span class="ptag tag-serving">推理服务</span></td><td>多目标贝叶斯优化异构 LLM/GPU 服务</td></tr>
        <tr><td>112</td><td>MAC-Attention: Match-Amend-Complete Attention</td><td><span class="ptag tag-serving">推理服务</span></td><td>快速精准注意力的匹配-修正-补全机制</td></tr>
        <tr><td>113</td><td>Sparing Strategies for Large Training Jobs</td><td><span class="ptag tag-infra">基础设施</span></td><td>最小化大训练任务可靠性影响的冗余策略</td></tr>
        <tr><td>114</td><td>Speculative Decoding: Performance or Illusion?</td><td><span class="ptag tag-serving">投机解码</span></td><td>投机解码真实收益的系统评估</td></tr>
        <tr><td>115</td><td>NexSpec: Speculative Decoding in RL Systems</td><td><span class="ptag tag-serving">投机解码</span></td><td>强化学习系统中的投机解码优化</td></tr>
        <tr><td>116</td><td>Optimizing Deployment Configurations for LLM Inference</td><td><span class="ptag tag-serving">推理服务</span></td><td>Meta 大规模 LLM 推理部署配置优化</td></tr>
        <tr><td>117</td><td>Demystifying MoE Serving Tax</td><td><span class="ptag tag-serving">MoE</span></td><td>MoE 服务额外开销量化分析</td></tr>
        <tr><td>118</td><td>Flash3DGS: Algorithm and System Co-Optimization for 3DGS on GPUs</td><td><span class="ptag tag-infra">特定场景</span></td><td>GPU 3D 高斯泼溅算法系统协同优化</td></tr>
        <tr><td>119</td><td>SAKURAONE: Open Ethernet-Based AI HPC System</td><td><span class="ptag tag-hardware">硬件</span></td><td>以太网 AI HPC 系统及其负载动态分析</td></tr>
        <tr><td>120</td><td>CSLE: RL Platform for Autonomous Security Management</td><td><span class="ptag tag-security">安全</span></td><td>自主安全管理的强化学习平台</td></tr>
        <tr><td>121</td><td>Dataflow Is All You Need</td><td><span class="ptag tag-compiler">编译器</span></td><td>数据流为核心的 ML 系统编译框架</td></tr>
        <tr><td>122</td><td>OSWorld-Human</td><td><span class="ptag tag-agent">Agent</span></td><td>计算机使用 Agent 效率基准</td></tr>
        <tr><td>123</td><td>LEANN: Low-Storage Overhead Vector Index</td><td><span class="ptag tag-infra">存储</span></td><td>低存储开销向量索引</td></tr>
        <tr><td>124</td><td>The OpenHands Software Agent SDK</td><td><span class="ptag tag-agent">Agent</span></td><td>生产级 Agent 可组合可扩展基础</td></tr>
        <tr><td>125</td><td>FlashAgents</td><td><span class="ptag tag-agent">Agent</span></td><td>流式 Prefill 重叠加速多 Agent 系统</td></tr>
        <tr><td>126</td><td>FaaScale: Fast LLM Scaling for Serverless Inference</td><td><span class="ptag tag-serving">推理服务</span></td><td>Serverless 推理的快速 LLM 扩展</td></tr>
        <tr><td>127</td><td>Charon: Unified Simulator for Large-Scale LLM Training and Inference</td><td><span class="ptag tag-infra">基础设施</span></td><td>大规模 LLM 训推统一细粒度模拟器</td></tr>
        <tr><td>128</td><td>Hawkeye: Reproducing GPU-Level Non-Determinism</td><td><span class="ptag tag-infra">基础设施</span></td><td>GPU 级不确定性复现与调试工具</td></tr>
        <tr><td>129</td><td>FarSkip-Collectives: Unhobbling Blocking Communication in MoE</td><td><span class="ptag tag-training">训练系统</span></td><td>解除 MoE 阻塞集合通信限制</td></tr>
        <tr><td>130</td><td>MLCommons Chakra: Performance Benchmarking with Execution Traces</td><td><span class="ptag tag-infra">基准测试</span></td><td>基于标准执行 Trace 的 ML 性能基准与协同设计</td></tr>
        <tr><td>131</td><td>TriInfer: Hybrid EPD Disaggregation for Multimodal LLMs</td><td><span class="ptag tag-serving">推理服务</span></td><td>多模态 LLM 三阶段混合分离推理</td></tr>
        <tr><td>132</td><td>A Lightweight High-Throughput Collective-Capable NoC for Large-Scale ML Accelerators</td><td><span class="ptag tag-hardware">硬件</span></td><td>大规模 ML 加速器高吞吐片上网络</td></tr>
        <tr><td>133</td><td>GriNNder: Breaking Memory Capacity Wall in GNN Training with Storage Offloading</td><td><span class="ptag tag-training">训练系统</span></td><td>存储卸载突破全图 GNN 训练显存墙</td></tr>
        <tr><td>134</td><td>Efficient VRAM-Constrained xLM Inference on Clients</td><td><span class="ptag tag-infra">端侧</span></td><td>客户端 VRAM 约束下的跨语言模型推理</td></tr>
        <tr><td>135</td><td>Attribution-based Sparse Activation in LLMs</td><td><span class="ptag tag-serving">推理服务</span></td><td>基于归因的 LLM 稀疏激活</td></tr>
      </tbody>
    </table>
  </div>

  <!-- ==================== 4. KEY TECH TRENDS ==================== -->
  <div class="section-title"><div class="dot"></div>八大核心技术趋势</div>
  <div class="trend-grid">

    <div class="trend-card bc1">
      <div class="t-icon">⚡</div>
      <div class="t-title">趋势一：推理系统成为 MLSys 绝对核心</div>
      <div class="t-body">
        约 48% 的论文聚焦 LLM 推理与服务系统，覆盖 KV Cache 管理（FlexiCache、SkipKV、Kitty）、投机解码（SpecDiff-2、NexSpec、BLASST）、Prefill/Decode 分离（TriInfer、PLA-Serve）、调度优化（SuperInfer、SchedFlow）等多个子赛道。传统 CV/NLP 系统研究几乎消失，LLM 推理成为新时代的 OS 内核级挑战。
      </div>
      <span class="t-horizon horizon-near">已成主流</span>
    </div>

    <div class="trend-card bc2">
      <div class="t-icon">🧩</div>
      <div class="t-title">趋势二：MoE 模型系统支持全面深化</div>
      <div class="t-body">
        MoE 专项论文高达 8+ 篇：MoEBlaze（训练显存墙）、FP8-Flow-MoE（量化）、CRAFT（专家副本分配）、Demystifying MoE Serving Tax（服务开销分析）、FarSkip-Collectives（通信优化）。MoE 已从研究对象演变为生产必选架构，系统支持刻不容缓。
      </div>
      <span class="t-horizon horizon-near">已成主流</span>
    </div>

    <div class="trend-card bc3">
      <div class="t-icon">🤖</div>
      <div class="t-title">趋势三：Agentic AI 系统崛起为独立赛道</div>
      <div class="t-body">
        Agent 系统论文数量与内容多样性均首次达到会议独立赛道规模：记忆管理（Hippocampus）、安全（ADS）、具身智能（AgenticCache）、SDK（OpenHands）、多 Agent 推理加速（FlashAgents）、Kernel 优化（AccelOpt）、HDL 生成（VeriMoA）。Agent OS 研究方向正在形成。
      </div>
      <span class="t-horizon horizon-mid">快速成长</span>
    </div>

    <div class="trend-card bc4">
      <div class="t-icon">🔢</div>
      <div class="t-title">趋势四：量化精度向 4-bit 乃至 2-bit 激进推进</div>
      <div class="t-body">
        NVFP4（FP4 量化）、Kitty（2-bit KV Cache）、IntAttention（全整数注意力）标志着量化前沿已从 FP16→FP8 进一步跨越至 FP4/INT4/INT2 区间。CAGE 针对 QAT 的曲率感知梯度估计、FP8-Flow-MoE 的零投射方案，体现了从"能量化"到"高质量量化"的深化。
      </div>
      <span class="t-horizon horizon-mid">1-2年内普及</span>
    </div>

    <div class="trend-card bc5">
      <div class="t-icon">📏</div>
      <div class="t-title">趋势五：超长上下文（1M+ Token）成为系统级挑战</div>
      <div class="t-body">
        MTraining（分布式动态稀疏注意力）、Efficient Long-Context LM Training（核注意力分离）、Unleashing Scalable Context Parallelism（FCP 上下文并行）、Stream2LLM（流式 Prefill）等多篇论文针对百万级 Token 的训练与推理展开攻关。长上下文将倒逼注意力算法、KV Cache 策略、通信拓扑的全栈重设计。
      </div>
      <span class="t-horizon horizon-mid">1-2年内主流</span>
    </div>

    <div class="trend-card bc6">
      <div class="t-icon">🌐</div>
      <div class="t-title">趋势六：异构硬件与跨设备训练系统化</div>
      <div class="t-body">
        Grolar（异构集群 LLM 训练）、HexiScale（异构硬件）、HetRL（异构 RL 环境）、FlexScale（弹性 FSDP）、BOute（异构 LLM/GPU 服务）、NEST（网络内存感知设备放置）。随着算力碎片化（不同代 GPU/TPU/自研芯片共存），异构系统将成为工业界的常态挑战。
      </div>
      <span class="t-horizon horizon-mid">2年内成标准</span>
    </div>

    <div class="trend-card bc7">
      <div class="t-icon">🔁</div>
      <div class="t-title">趋势七：强化学习训练系统专项优化兴起</div>
      <div class="t-body">
        随着 RLHF/RLVR 成为 LLM 后训练的核心，出现了多篇专门针对 RL 训练阶段的系统优化：HetRL（异构 RL）、NexSpec（RL 系统中的投机解码）、Beat the Long Tail（RL 训练投机解码）、Learning from Less（低数据/计算 RLVR 评估）。RL 训练系统将成为继预训练之后的下一个系统级难题。
      </div>
      <span class="t-horizon horizon-mid">正在快速增长</span>
    </div>

    <div class="trend-card bc8">
      <div class="t-icon">🛡️</div>
      <div class="t-title">趋势八：AI 安全与隐私进入系统级讨论</div>
      <div class="t-body">
        从经典的联邦学习（DisAgg、PLayer-FL、FLoRIST）扩展到 LLM 安全新领域：ZK-APEX（零知识遗忘）、G-HEMP（同态加密 GCN 推理）、ADS（Agentic AI 安全检测）、Toward Principled Safety Testing（越狱 Oracle 问题）、Blueprint（GPU 机密计算）。AI 安全正从算法层下沉至系统层。
      </div>
      <span class="t-horizon horizon-far">2-3年成熟</span>
    </div>

  </div>

  <!-- ==================== 5. PREDICTION TIMELINE ==================== -->
  <div class="section-title"><div class="dot"></div>技术演进时间轴预测（2026–2030）</div>
  <div class="timeline">

    <div class="timeline-item">
      <div class="tl-year" style="color:#e94560;">2026</div>
      <div class="tl-line">
        <div class="tl-dot" style="background:#e94560;"></div>
        <div class="tl-stem" style="background:linear-gradient(180deg,#e94560,#f97316);"></div>
      </div>
      <div class="tl-content">
        <h4>推理分离架构全面落地，FP8/FP4 成行业标配</h4>
        <p>Prefill-Decode 分离部署进入主流云服务；FlashAttention-4 推动各框架默认 Attention 实现更新；FP8 训练与推理在主流 GPU 平台标准化；MoE 成为新发布大模型的默认架构，对应服务系统随之成熟。</p>
      </div>
    </div>

    <div class="timeline-item">
      <div class="tl-year" style="color:#f97316;">2027</div>
      <div class="tl-line">
        <div class="tl-dot" style="background:#f97316;"></div>
        <div class="tl-stem" style="background:linear-gradient(180deg,#f97316,#0f3460);"></div>
      </div>
      <div class="tl-content">
        <h4>Agent OS 雏形出现，百万 Token 上下文成工程常态</h4>
        <p>Agent 记忆、工具调用、安全沙箱在主流框架（如 OpenHands）中统一；1M+ Token 的推理服务借助 FCP/稀疏注意力/流式 Prefill 可商业化部署；2-bit KV Cache 量化走向生产；RL 训练系统与预训练系统在框架层面统一。</p>
      </div>
    </div>

    <div class="timeline-item">
      <div class="tl-year" style="color:#0f3460;">2028</div>
      <div class="tl-line">
        <div class="tl-dot" style="background:#0f3460;"></div>
        <div class="tl-stem" style="background:linear-gradient(180deg,#0f3460,#533483);"></div>
      </div>
      <div class="tl-content">
        <h4>异构 AI 算力云成为主流，编译器智能化飞跃</h4>
        <p>跨厂商 GPU/TPU/定制 ASIC 的统一训推平台成熟；CATWILD/WAVE 类自动调优编译器集成到主要 MLOps 平台；Agentic Operator Generation 工具链进入 ASIC 研发标准流程；Serverless LLM 推理（FaaScale）成为云原生 AI 的主流交付模式。</p>
      </div>
    </div>

    <div class="timeline-item">
      <div class="tl-year" style="color:#533483;">2029–2030</div>
      <div class="tl-line">
        <div class="tl-dot" style="background:#533483;"></div>
        <div class="tl-stem" style="background:none;"></div>
      </div>
      <div class="tl-content">
        <h4>隐私计算与可信 AI 成为企业 AI 基础设施必选项</h4>
        <p>同态加密推理（G-HEMP）从研究走向实用；零知识遗忘（ZK-APEX）应对 GDPR 等合规需求；GPU 机密计算（Blueprint）成为云端 AI 服务的 SLA 一部分；Agentic AI 的安全检测系统（ADS 类）内置于主流 Agent 平台；MLCommons Chakra 类标准执行 Trace 推动 AI 硬件互操作性。</p>
      </div>
    </div>

  </div>

  <!-- ==================== 6. KEY INSIGHTS ==================== -->
  <div class="section-title"><div class="dot"></div>六大深度洞察</div>
  <div class="insight-grid">

    <div class="insight-card">
      <div class="insight-icon">🔭</div>
      <div class="insight-text">
        <h4>推理系统研究已超越传统 CV/NLP 系统</h4>
        <p>本届约 48% 的论文聚焦 LLM 推理，是过去 MLSys 各届会议中占比最高的一次，标志着 LLM 已从算法研究客体转变为系统研究的"新主机"。</p>
      </div>
    </div>

    <div class="insight-card">
      <div class="insight-icon">🏭</div>
      <div class="insight-text">
        <h4>顶级工业界主导研究议题</h4>
        <p>Google（CATWILD、ML Fleet、XProf）、Apple（AXLearn）、Meta（ExecuTorch、Agentic Operator Generation、Optimizing Deployment）、NVIDIA（NVFP4）等主导了大量高影响力论文，产学研边界继续模糊化。</p>
      </div>
    </div>

    <div class="insight-card">
      <div class="insight-icon">⚠️</div>
      <div class="insight-text">
        <h4>投机解码的"祛魅"时刻</h4>
        <p>"Speculative Decoding: Performance or Illusion?" 与 "Beyond the Buzz" 等论文开始对此前被过度热炒的技术路线进行理性审视，MLSys 研究社区正在走向更成熟的工程化批判思维。</p>
      </div>
    </div>

    <div class="insight-card">
      <div class="insight-icon">🔗</div>
      <div class="insight-text">
        <h4>系统研究与算法研究的耦合度史上最高</h4>
        <p>本届大量论文同时贡献算法创新与系统实现（FlashAttention-4、BLASST、MAC-Attention、MTraining），纯系统工程论文比例下降，"算法-系统协同设计"已成第一原则。</p>
      </div>
    </div>

    <div class="insight-card">
      <div class="insight-icon">📡</div>
      <div class="insight-text">
        <h4>端侧与 Serverless AI 形成新战场</h4>
        <p>ExecuTorch、AIRS、VRAM-Constrained xLM Inference、FaaScale、Rethinking DVFS for Mobile LLMs 等论文体现出推理战场向边缘延伸的强烈趋势，算力碎片化驱动系统设计多元化。</p>
      </div>
    </div>

    <div class="insight-card">
      <div class="insight-icon">🔬</div>
      <div class="insight-text">
        <h4>基准与可观测性研究补齐工具链缺口</h4>
        <p>MLCommons Chakra、XProf、DriftBench、OSWorld-Human、LLMInfer-Bench 等专门讨论评测与可观测性的论文数量增加，反映出行业对"如何度量 AI 系统"的重视程度显著上升。</p>
      </div>
    </div>

  </div>

  <!-- ==================== 7. HOT KEYWORD HEATMAP ==================== -->
  <div class="section-title"><div class="dot"></div>热词热度图</div>
  <div class="heatmap">
    <div class="hm-cell" style="background:#e94560;font-size:1.1rem;">KV Cache</div>
    <div class="hm-cell" style="background:#c73151;font-size:1.05rem;">LLM Serving</div>
    <div class="hm-cell" style="background:#b82347;">MoE</div>
    <div class="hm-cell" style="background:#e94560;font-size:1.08rem;">Speculative Decoding</div>
    <div class="hm-cell" style="background:#0f3460;font-size:1.0rem;">Distributed Training</div>
    <div class="hm-cell" style="background:#1a4a80;font-size:0.95rem;">FSDP</div>
    <div class="hm-cell" style="background:#533483;font-size:1.05rem;">Quantization</div>
    <div class="hm-cell" style="background:#6a42a0;font-size:0.95rem;">FP8/FP4</div>
    <div class="hm-cell" style="background:#ec4899;font-size:1.05rem;">Agentic AI</div>
    <div class="hm-cell" style="background:#c0356f;">Agent Memory</div>
    <div class="hm-cell" style="background:#06b6d4;font-size:0.95rem;">Auto-Tuning</div>
    <div class="hm-cell" style="background:#0891b2;font-size:1.0rem;">Compiler</div>
    <div class="hm-cell" style="background:#10b981;font-size:0.9rem;">Federated Learning</div>
    <div class="hm-cell" style="background:#0f766e;">Privacy Computing</div>
    <div class="hm-cell" style="background:#f59e0b;font-size:0.95rem;">Heterogeneous</div>
    <div class="hm-cell" style="background:#d97706;">ASIC Design</div>
    <div class="hm-cell" style="background:#64748b;font-size:0.95rem;">Benchmarking</div>
    <div class="hm-cell" style="background:#475569;">Profiling</div>
    <div class="hm-cell" style="background:#ef4444;font-size:1.0rem;">Long Context</div>
    <div class="hm-cell" style="background:#b91c1c;">SLO Optimization</div>
    <div class="hm-cell" style="background:#7c3aed;font-size:0.95rem;">RL for LLMs</div>
    <div class="hm-cell" style="background:#6d28d9;">RLHF/RLVR</div>
    <div class="hm-cell" style="background:#0369a1;font-size:0.9rem;">On-Device Inference</div>
    <div class="hm-cell" style="background:#1d4ed8;">Serverless</div>
    <div class="hm-cell" style="background:#9d174d;font-size:0.9rem;">RAG System</div>
    <div class="hm-cell" style="background:#831843;">Multi-Agent</div>
  </div>

</div>

<!-- FOOTER -->
<div class="footer">
  <strong>MLSys 2026 论文深度分析报告</strong><br>
  基于会议官网全部 135 篇录用论文 · 生成时间：2026年4月13日<br>
  <span style="font-size:0.75rem;margin-top:6px;display:block;color:#718096;">本报告由 AI 辅助分析生成，仅供研究参考</span>
</div>

</body>
</html>
