---
layout: default
title: 深度报告
---

<div class="home-layout">
  <div class="post-grid" id="postGrid">
    {% comment %}分离置顶和非置顶文章{% endcomment %}
{% assign sticky_posts = "" | split: "" %}
{% assign regular_posts = "" | split: "" %}
{% for post in site.posts %}
  {% if post.sticky %}
    {% assign sticky_posts = sticky_posts | push: post %}
  {% else %}
    {% assign regular_posts = regular_posts | push: post %}
  {% endif %}
{% endfor %}
{% assign sticky_sorted = sticky_posts | sort: "date" %}
{% assign regular_sorted = regular_posts | sort: "date" | reverse %}
{% assign sorted_posts = sticky_sorted | concat: regular_sorted %}
    {% for post in sorted_posts %}
      {% assign minutes = post.content | strip_html | size | divided_by: 600 | ceil %}
      <article class="post-card"
        data-title="{{ post.title | escape }}"
        data-description="{{ post.description | escape }}"
        data-tags='{{ post.tags | jsonify | escape }}'
        data-type="{% if post.type %}{{ post.type }}{% elsif post.title contains '日报' or post.title contains '周报' or post.title contains '月报' %}tech{% else %}deep{% endif %}">
        <a href="{{ post.url | relative_url }}">
          <div class="card-meta">
            <span class="card-date">{{ post.date | date: "%Y年%m月%d日" }}</span>
            <span class="card-read-time">{{ minutes }} min read</span>
          </div>
          <h2 class="card-title">
            {% if post.sticky %}<span class="sticky-icon">📌</span>{% endif %}
            {{ post.title }}
          </h2>
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
    <div class="pagination" id="pagination"></div>
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
  var postGrid = document.getElementById('postGrid');
  var paginationEl = document.getElementById('pagination');

  var pageSize = 20;
  var currentPage = 1;

  // 归一化函数 - 自动合并相似标签
  function normalizeTag(tag) {
    return tag
      .replace(/^(AI|AI\s+)/i, '')
      .replace(/系统$/, '')
      .replace(/&amp;/g, '')
.trim();
   }

  // 从所有 card 收集 tags，按归一化名分组，并统计频次
  var tagGroups = {};
  cards.forEach(function(card) {
    var tags = [];
    try { tags = JSON.parse(card.getAttribute('data-tags') || '[]'); } catch(e) {}
    tags.forEach(function(t) {
      var key = normalizeTag(t);
      if (!tagGroups[key]) tagGroups[key] = { display: t, variants: [], count: 0 };
      tagGroups[key].count++;
      if (tagGroups[key].variants.indexOf(t) === -1) tagGroups[key].variants.push(t);
      // 用最短的作为显示名
      if (t.length < tagGroups[key].display.length) tagGroups[key].display = t;
    });
  });

  // 按热度（出现频次）降序排序
  var sortedKeys = Object.keys(tagGroups).sort(function(a, b) {
    if (tagGroups[b].count !== tagGroups[a].count) {
      return tagGroups[b].count - tagGroups[a].count;
    }
    return a.localeCompare(b);
  });

  var TAG_DISPLAY_LIMIT = 30;
  var showHidden = false;

  // 渲染标签 checkbox
  sortedKeys.forEach(function(key, i) {
    var label = document.createElement('label');
    label.className = 'tag-filter';
    if (i >= TAG_DISPLAY_LIMIT) {
      label.style.display = 'none';
      label.setAttribute('data-collapsed', 'true');
    }
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

  // 展开更多按钮
  if (sortedKeys.length > TAG_DISPLAY_LIMIT) {
    var btn = document.createElement('button');
    btn.className = 'tag-expand-btn';
    btn.textContent = '展开更多 (' + (sortedKeys.length - TAG_DISPLAY_LIMIT) + ')';
    btn.addEventListener('click', function() {
      showHidden = !showHidden;
      var collapsed = tagFilters.querySelectorAll('[data-collapsed="true"]');
      collapsed.forEach(function(el) {
        el.style.display = showHidden ? '' : 'none';
      });
      btn.textContent = showHidden ? '收起' : '展开更多 (' + (sortedKeys.length - TAG_DISPLAY_LIMIT) + ')';
    });
    tagFilters.appendChild(btn);
  }

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
    var category = activeFilter ? activeFilter.getAttribute('data-filter') : 'all';
    var selectedKeys = getSelectedKeys();
    var expandedTags = expandKeys(selectedKeys);
    var searchText = searchInput ? searchInput.value.toLowerCase() : '';

    var visibleCards = [];
    cards.forEach(function(card) {
      var title = (card.getAttribute('data-title') || '').toLowerCase();
      var desc = (card.getAttribute('data-description') || '').toLowerCase();
      var tags = [];
      try { tags = JSON.parse(card.getAttribute('data-tags') || '[]'); } catch(e) {}

      // 分类过滤
      var cardType = card.getAttribute('data-type');
      var matchCategory = true;
      if (category === 'tech') {
        matchCategory = cardType === 'tech';
      } else if (category === 'deep') {
        matchCategory = cardType === 'deep';
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

      card.style.display = 'none';
      if (matchCategory && matchTag && matchSearch) {
        visibleCards.push(card);
      }
    });

    var totalPages = Math.max(1, Math.ceil(visibleCards.length / pageSize));
    if (currentPage > totalPages) currentPage = totalPages;

    var start = (currentPage - 1) * pageSize;
    var end = Math.min(start + pageSize, visibleCards.length);
    for (var i = start; i < end; i++) {
      visibleCards[i].style.display = '';
    }

    renderPagination(totalPages, visibleCards.length);
  }

  function renderPagination(totalPages, totalCount) {
    paginationEl.innerHTML = '';
    if (totalPages <= 1) return;

    var nav = document.createElement('div');
    nav.className = 'pagination-nav';

    // 上一页
    var prev = document.createElement('a');
    prev.className = 'page-link' + (currentPage <= 1 ? ' disabled' : '');
    prev.textContent = '← 上一页';
    if (currentPage > 1) {
      prev.addEventListener('click', function(e) {
        e.preventDefault();
        currentPage--;
        filterCards();
        document.querySelector('.post-grid').scrollIntoView({ behavior: 'smooth', block: 'start' });
      });
    }
    nav.appendChild(prev);

    // 页码
    var pageStart = Math.max(1, currentPage - 2);
    var pageEnd = Math.min(totalPages, pageStart + 4);
    pageStart = Math.max(1, pageEnd - 4);

    for (var p = pageStart; p <= pageEnd; p++) {
      var link = document.createElement('a');
      link.className = 'page-link' + (p === currentPage ? ' active' : '');
      link.textContent = p;
      link.addEventListener('click', (function(page) {
        return function(e) {
          e.preventDefault();
          currentPage = page;
          filterCards();
          document.querySelector('.post-grid').scrollIntoView({ behavior: 'smooth', block: 'start' });
        };
      })(p));
      nav.appendChild(link);
    }

    // 下一页
    var next = document.createElement('a');
    next.className = 'page-link' + (currentPage >= totalPages ? ' disabled' : '');
    next.textContent = '下一页 →';
    if (currentPage < totalPages) {
      next.addEventListener('click', function(e) {
        e.preventDefault();
        currentPage++;
        filterCards();
        document.querySelector('.post-grid').scrollIntoView({ behavior: 'smooth', block: 'start' });
      });
    }
    nav.appendChild(next);

    paginationEl.appendChild(nav);
  }

  // 导航点击
  navLinks.forEach(function(link) {
    link.addEventListener('click', function(e) {
      e.preventDefault();
      navLinks.forEach(function(l) { l.classList.remove('active'); });
      this.classList.add('active');
      currentPage = 1;
      filterCards();
    });
  });

  // 标签点击
  tagFilters.addEventListener('change', function() {
    currentPage = 1;
    filterCards();
  });

  // 搜索按钮点击
  if (searchBtn) {
    searchBtn.addEventListener('click', function() {
      currentPage = 1;
      filterCards();
    });
  }

  // 回车触发搜索
  if (searchInput) {
    searchInput.addEventListener('keydown', function(e) {
      if (e.key === 'Enter') {
        currentPage = 1;
        filterCards();
      }
    });
  }

  // 默认显示
  filterCards();
})();
</script>
