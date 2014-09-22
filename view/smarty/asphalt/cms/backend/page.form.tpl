{extends file="cms/backend/index"}

{block name="head_title" prepend}{if $node->getId()}{translate key="title.page.edit"}{else}{translate key="title.page.add"}{/if} - {/block}

{block name="taskbar_panels" append}
    {if $node->getId()}
        {url id="cms.page.edit" parameters=["locale" => "%locale%", "site" => $site->getId(), "node" => $node->getId()] var="url"}
    {else}
        {url id="cms.page.add" parameters=["locale" => "%locale%", "site" => $site->getId()] var="url"}
    {/if}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        {if $node->getId()}
        <h1>{$node->getName($locale)} <small>{translate key="title.page.edit"}</small></h1>
        {else}
        <h1>{translate key="title.page.add"}</h1>
        {/if}
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            {call formRow form=$form row="name"}

            <div class="form__group">
                <div class="col-lg-offset-2 col-lg-10">
                    <a href="#" class="btn-alternate-names">{translate key="button.names.alternate"}</a>
                </div>
            </div>

            <div class="alternate-names">
                {call formRow form=$form row="name-title"}
                {call formRow form=$form row="name-menu"}
                {call formRow form=$form row="name-breadcrumb"}
            </div>

            {call formRows form=$form}

            {call formActions referer=$referer}
        </div>
    </form>
{/block}

{block name="scripts" append}
    <script>
        $(function() {
            $('.btn-alternate-names').click(function() {
                $('.alternate-names').toggle();

                return false;
            });
        });
        $('.alternate-names').hide();
    </script>
{/block}
