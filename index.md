---
layout: default
title: 深度报告
---

<div class="home-layout">
  <div class="post-grid" id="postGrid">
    {% for post in site.posts %}
      {% assign minutes = post.content | strip_html | size | divided_by: 600 | ceil %}
      <article class="post-card"
        data-title="{{ post.title | escape }}"
        data-description="{{ post.description | escape }}"
        data-tags='{{ post.tags | jsonify | escape }}'>
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

  <aside class="sidebar">
    <div class="search-box">
      <input type="text" id="searchInput" placeholder="搜索文章...">
      <button id="searchBtn" class="search-btn">搜索</button>
    </div>
    <div class="tag-list">
      <h3>标签筛选</h3>
      <div id="tagFilters"></div>
    </div>
  </aside>
</div>

<script>
(function() {
  var cards = document.querySelectorAll('.post-card');
  var navLinks = document.querySelectorAll('.nav-link');
  var tagFilters = document.getElementById('tagFilters');
  var searchInput = document.getElementById('searchInput');
  var searchBtn = document.getElementById('searchBtn');

  // 归一化函数 - 自动合并相似标签
  function normalizeTag(tag) {
    return tag
      .replace(/^(AI|AI\s+)/i, '')
      .replace(/系统$/, '')
      .replace(/&amp;/g, '')
      .trim();
  }

  // 从所有 card 收集 tags，按归一化名分组
  var tagGroups = {};
  cards.forEach(function(card) {
    var tags = [];
    try { tags = JSON.parse(card.getAttribute('data-tags') || '[]'); } catch(e) {}
    tags.forEach(function(t) {
      var key = normalizeTag(t);
      if (!tagGroups[key]) tagGroups[key] = { display: t, variants: [] };
      if (tagGroups[key].variants.indexOf(t) === -1) tagGroups[key].variants.push(t);
      // 用最短的作为显示名
      if (t.length < tagGroups[key].display.length) tagGroups[key].display = t;
    });
  });

  // 排序并渲染标签 checkbox
  var sortedKeys = Object.keys(tagGroups).sort();
  sortedKeys.forEach(function(key) {
    var label = document.createElement('label');
    label.className = 'tag-filter';
    var cb = document.createElement('input');
    cb.type = 'checkbox';
    cb.value = key;
    cb.setAttribute('data-key', key);
    var span = document.createElement('span');
    span.textContent = tagGroups[key].display;
    label.appendChild(cb);
    label.appendChild(span);
    tagFilters.appendChild(label);
  });

  function getSelectedKeys() {
    var selected = [];
    tagFilters.querySelectorAll('input[type="checkbox"]').forEach(function(cb) {
      if (cb.checked) selected.push(cb.getAttribute('data-key'));
    });
    return selected;
  }

  // 展开归一化键为所有原始变体
  function expandKeys(keys) {
    var result = [];
    keys.forEach(function(key) {
      if (tagGroups[key]) {
        tagGroups[key].variants.forEach(function(v) {
          if (result.indexOf(v) === -1) result.push(v);
        });
      }
    });
    return result;
  }

  function filterCards() {
    var activeFilter = document.querySelector('.nav-link.active');
    var category = activeFilter ? activeFilter.getAttribute('data-filter') : 'daily';
    var selectedKeys = getSelectedKeys();
    var expandedTags = expandKeys(selectedKeys);
    var searchText = searchInput ? searchInput.value.toLowerCase() : '';

    cards.forEach(function(card) {
      var title = (card.getAttribute('data-title') || '').toLowerCase();
      var desc = (card.getAttribute('data-description') || '').toLowerCase();
      var tags = [];
      try { tags = JSON.parse(card.getAttribute('data-tags') || '[]'); } catch(e) {}

      // 分类过滤
      var matchCategory = true;
      if (category === 'daily') {
        matchCategory = title.indexOf('日报') > -1 || title.indexOf('周报') > -1;
      } else if (category === 'deep') {
        matchCategory = title.indexOf('日报') === -1 && title.indexOf('周报') === -1;
      }

      // 标签过滤（展开为所有变体匹配）
      var matchTag = true;
      if (expandedTags.length > 0) {
        matchTag = expandedTags.every(function(t) { return tags.indexOf(t) > -1; });
      }

      // 搜索过滤
      var matchSearch = true;
      if (searchText) {
        matchSearch = title.indexOf(searchText) > -1 || desc.indexOf(searchText) > -1;
      }

      card.style.display = (matchCategory && matchTag && matchSearch) ? '' : 'none';
    });
  }

  // 导航点击
  navLinks.forEach(function(link) {
    link.addEventListener('click', function(e) {
      e.preventDefault();
      navLinks.forEach(function(l) { l.classList.remove('active'); });
      this.classList.add('active');
      filterCards();
    });
  });

  // 标签点击
  tagFilters.addEventListener('change', filterCards);

  // 搜索按钮点击
  if (searchBtn) {
    searchBtn.addEventListener('click', filterCards);
  }

  // 回车触发搜索
  if (searchInput) {
    searchInput.addEventListener('keydown', function(e) {
      if (e.key === 'Enter') filterCards();
    });
  }

  // 默认显示
  filterCards();
})();
</script>
