---
layout: default
title: 项目报告列表
---
# 所有报告
<ul>
{% for file in site.static_files %}
  {% if file.path contains 'reports/' and file.extname == '.html' %}
    <li><a href="{{ file.path | relative_url }}">{{ file.basename }}</a></li>
  {% endif %}
{% endfor %}
</ul>
