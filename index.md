---
layout: default
title: 深度报告
---

## 报告列表

<div class="post-grid">
  {% for post in site.posts %}
    {% assign minutes = post.content | strip_html | size | divided_by: 260 | ceil %}
    <article class="post-card">
      <a href="{{ post.url | relative_url }}">
        <div class="card-meta">
          <span class="card-date">{{ post.date | date: "%Y年%m月%d日" }}</span>
          <span class="card-read-time">{{ minutes }} min read</span>
        </div>
        <h2 class="card-title">{{ post.title }}</h2>
        <p class="card-excerpt">{{ post.description }}</p>
        <div class="card-tags">
          {% if post.tags %}
            {% for tag in post.tags %}
              <span class="tag">{{ tag }}</span>
            {% endfor %}
          {% endif %}
        </div>
      </a>
    </article>
  {% endfor %}
</div>