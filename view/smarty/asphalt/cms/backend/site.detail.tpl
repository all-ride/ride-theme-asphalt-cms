{extends file="cms/backend/index"}

{block name="head_title" prepend}{$site->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {url id="cms.site.detail.locale" parameters=["locale" => "%locale%", "site" => $site->getId()] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$site->getName($locale)}</h1>
    </div>
{/block}