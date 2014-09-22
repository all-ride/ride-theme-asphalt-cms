{extends file="cms/backend/index"}

{block name="head_title" prepend}{if $node->getId()}{translate key="title.site.edit"}{else}{translate key="title.site.add"}{/if} - {/block}

{block name="taskbar_panels" append}
    {if $node->getId()}
        {url id="cms.site.edit" parameters=["locale" => "%locale%", "site" => $node->getId()] var="url"}
    {else}
        {url id="cms.site.add" parameters=["locale" => "%locale%"] var="url"}
    {/if}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        {if $node->getId()}
        <h1>{$node->getName($locale)} <small>{translate key="title.site.edit"}</small></h1>
        {else}
        <h1>{translate key="title.site.add"}</h1>
        {/if}
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form">

        {call formRows form=$form}

        {call formActions referer=$referer}
    </form>
{/block}
