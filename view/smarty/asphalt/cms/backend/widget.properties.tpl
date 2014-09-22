{extends file="cms/backend/index"}

{block name="head_title" prepend}{translate key="title.widget.properties" widget=$widgetName} - {$node->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {url id="cms.widget.properties" parameters=["locale" => "%locale%", "site" => $site->getId(), "node" => $node->getId(), "region" => $region, "widget" => $widgetId] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title"}
    <div class="page-header">    
        <h1>{$node->getName($locale)} <small>{translate key="title.widget.properties" widget=$widgetName} ({$region})</small></h1>
    </div>
{/block}

{block name="content_body" append}
    {include file=$propertiesTemplate inline}
{/block}