{extends file="cms/backend/index"}

{block name="head_title" prepend}{if $node->getType() == 'site'}{translate key="title.site.`$type`"}{else}{translate key="title.node.`$type`"}{/if} - {$node->getName($locale)} - {/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$node->getName($locale)} <small>{if $node->getType() == 'site'}{translate key="title.site.`$type`"}{else}{translate key="title.node.`$type`"}{/if}</small></h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    {if $node->getId() == $node->getRootNodeId()}
        <div class="alert alert-warning">
            <p>{translate key="warning.site.delete"}</p>
        </div>
    {/if}

    <form action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            <p>{translate key="label.confirm.node.`$type`" node=$node->getName($locale)}</p>
        </div>

        <div class="form__actions">
            <input type="submit" class="btn btn--default" value="{translate key="button.`$type`"}" />
            <a class="btn btn--link" href="{$referer}">{translate key="button.cancel"}</a>
        </div>
    </form>
{/block}