{extends file="cms/backend/index"}

{block name="head_title" prepend}{translate key="title.section.properties"} - {$node->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="cms/backend/taskbar"}

        {url id="cms.node.content.section.style" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%", "node" => $node->getId(), "region" => $region, "section" => $section] var="url"}
        {call taskbarPanelPublish url=$url revision=$node->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.node.content.section.style" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region, "section" => $section] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$node->getName($locale)} <small>{translate key="title.section.properties"}</small></h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

<form class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
    <fieldset>
        {call formRows form=$form}

        <div class="form-group">
            <div class="col-lg-offset-2 col-lg-10">
                <input type="submit" class="btn btn-default" value="{translate key="button.save"}" />
                {if $referer}
                    <a href="{$referer}" class="btn">{translate key="button.cancel"}</a>
                {/if}
            </div>
        </div>
    </fieldset>
</form>

{/block}
