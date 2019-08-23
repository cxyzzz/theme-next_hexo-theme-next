{% macro render(posts) %}
{%- for post in posts %}

  {%- set year %}
  {%- set post.year = date(post.date, 'YYYY') %}

  {%- if post.year !== year %}
    {%- set year = post.year %}
    <div class="collection-year">
      <{%- if theme.seo %}h2{% else %}h1{%- endif %} class="collection-header">
      {{ year }}
      <div class="chinese-zodiac">
        {%- include '../../../../source/_data/chinese-zodiac.swig' %}
      </div>
      </{%- if theme.seo %}h2{% else %}h1{%- endif %}>
    </div>
  {%- endif %}

  {# Show month #}
  {%- set month %}
  {%- set post.month = date(post.date, 'MMM') %}

  {%- if post.month !== month %}
    {%- set month = post.month %}
    <div class="collection-month">
      <{%- if theme.seo %}h3{% else %}h2{%- endif %} class="collection-header">{{ month }}</{%- if theme.seo %}h3{% else %}h2{%- endif %}>
    </div>
  {%- endif %}
  {# endshow #}

  <article class="post" itemscope itemtype="http://schema.org/Article">
    <header class="post-header">

      <{%- if theme.seo %}h3{% else %}h2{%- endif %} class="post-title">
        {%- if post.link %}{# Link posts #}
          {%- set postTitleIcon = '<i class="fa fa-external-link"></i>' %}
          {%- set postText = post.title or post.link %}
          {{ next_url(post.link, postText + postTitleIcon, {class: 'post-title-link post-title-link-external', itemprop: 'url' }) }}
        {% else %}
          <a class="post-title-link" href="{{ url_for(post.path) }}" itemprop="url">
            <span itemprop="name">{{ post.title | default(__('post.untitled')) }}</span>
          </a>
        {%- endif %}
      </{%- if theme.seo %}h3{% else %}h2{%- endif %}>

      <div class="post-meta">
        <time class="post-time" itemprop="dateCreated"
              datetime="{{ moment(post.date).format() }}"
              content="{{ date(post.date, config.date_format) }}">
          {{ date(post.date, 'MM-DD') }}
        </time>
      </div>

    </header>
  </article>

{%- endfor %}
{% endmacro %}
