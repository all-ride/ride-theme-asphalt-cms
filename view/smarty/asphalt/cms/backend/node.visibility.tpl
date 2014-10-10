{extends file="cms/backend/index"}

{block name="head_title" prepend}{translate key="title.node.visibility"} - {$node->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {url id="cms.node.visibility" parameters=["locale" => "%locale%", "site" => $site->getId(), "node" => $node->getId()] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$node->getName($locale)} <small>{translate key="title.node.visibility"}</small></h1>
    </div>
{/block}

{block name="content_body" append}
    <p>{translate key="label.node.action.visibility.intro"}</p>
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form" class="form grid">
        <div class="form__group grid--bp-med__10">
            {call formRow form=$form row="published"}

            <div class="grid">
                <div class="grid--bp-med__6">
                    {call formRow form=$form row="publishStart"}
                </div>
                <div class="grid--bp-med__6">
                    {call formRow form=$form row="publishStop"}
                </div>
            </div>

            {call formRows form=$form}

            {call formActions referer=$referer}
        </div>
    </form>
{/block}
