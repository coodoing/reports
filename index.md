---
layout: default
title: 深度报告
---

## 报告列表

<ul class="post-list">
  {% for post in site.posts %}
    <li>
      <span class="post-date">{{ post.date | date: "%Y-%m-%d" }}</span>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>

<!-- ## 统计

- 共 {{ site.posts.size }} 篇报告
- 最后更新：{{ site.time | date: "%Y-%m-%d %H:%M" }} -->

<!-- ## 订阅

- RSS 订阅：[点击这里](/feed.xml) -->