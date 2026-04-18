---
layout: default
title: 项目报告列表
---

# 所有报告

{% comment %} 按修改时间倒序排列（最新的在前） {% endcomment %}
{% assign reports = site.static_files | where: "extname", ".html" | sort: "modified_time" | reverse %}

{% if reports.size == 0 %}
  <p>暂无报告，请稍后查看。</p>
{% else %}
  <ul>
  {% for file in reports %}
    <li>
      <a href="{{ file.path | relative_url }}">
        {{ file.basename | replace: "-", " " | replace: "_", " " }}
      </a>
      <span style="color: #666; font-size: 0.9em;">
        （{{ file.modified_time | date: "%Y-%m-%d %H:%M" }}）
      </span>
    </li>
  {% endfor %}
  </ul>
{% endif %}
