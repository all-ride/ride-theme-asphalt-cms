{extends file="cms/backend/index"}

{block name="head_title" prepend}{translate key="title.widget.style" widget=$widgetName} - {$node->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {url id="cms.widget.style" parameters=["locale" => "%locale%", "site" => $site->getId(), "node" => $node->getId(), "region" => $region, "widget" => $widgetId] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$node->getName($locale)} <small>{translate key="title.widget.style" widget=$widgetName}</small></h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

<form class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
    <div class="form__group">
        {call formRows form=$form}

        {call formActions referer=$referer}
    </div>
</form>

{/block}
