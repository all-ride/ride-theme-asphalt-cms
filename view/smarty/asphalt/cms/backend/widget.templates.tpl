{extends file="cms/backend/index"}

{block name="head_title" prepend}{translate key="title.widget.templates" widget=$widgetName} - {$node->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {url id="cms.widget.templates" parameters=["locale" => "%locale%", "site" => $site->getId(), "node" => $node->getId(), "region" => $region, "widget" => $widgetId] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$node->getName($locale)} <small>{translate key="title.widget.templates" widget=$widgetName}</small></h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

<form class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
    <div class="form__group">
    <div class="tabbable">
        <ul class="nav nav-tabs">
        {foreach $templates as $file => $content}
            <li{if $content@first} class="active"{/if}><a href="#{$file|replace:".":"-"}" data-toggle="tab">{$file}</a></li>
        {/foreach}
        </ul>

        <div class="tabs__content">
        {foreach $templates as $file => $content}
            <div id="{$file|replace:".":"-"}" class="tabs__pane clearfix{if $content@first} active{/if}">
                <br />
                {call formWidget form=$form row="content" part=$file}
                <br />

                {call formRow form=$form row="path" part=$file}
            </div>
        {/foreach}
        </div>

        <div class="form__group">
            <div class="col-lg-offset-2 col-lg-10">
                <input type="submit" class="btn btn--default" value="{translate key="button.save"}" />
                {if $referer}
                    <a href="{$referer}" class="btn">{translate key="button.cancel"}</a>
				{else}
                    <a class="btn" href="{url id="cms.node.layout" parameters=["locale" => $locale, "site" => $site->getId(), "node" => $node->getId(), "region" => $region]}">{translate key="button.cancel"}</a>
                {/if}
            </div>
        </div>
    </div>
</form>

{/block}
