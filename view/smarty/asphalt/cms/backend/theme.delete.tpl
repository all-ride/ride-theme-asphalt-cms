{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.theme.delete"} - {$theme->getDisplayName()} - {/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$theme->getDisplayName()} <small>{translate key="title.theme.delete"}</small></h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    <form action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            <p>{translate key="label.confirm.theme.delete" theme=$theme->getDisplayName()}</p>
        </div>

        <div class="form__group">
            <input type="submit" class="btn btn--default" value="{translate key="button.delete"}" />
            <a class="btn btn--link" href="{$referer}">{translate key="button.cancel"}</a>
        </div>
    </form>
{/block}
