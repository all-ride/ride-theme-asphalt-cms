{extends file="base/index"}

{block name="head_title" prepend}{if $theme}{translate key="title.theme.edit"} - {$theme->getDisplayName()}{else}{translate key="title.theme.add"}{/if} - {/block}

{block name="content_title" append}
    <div class="page-header">
    {if $theme}
        <h1>{$theme->getDisplayName()} <small>{translate key="title.theme.edit"}</small></h1>
    {else}
        <h1>{translate key="title.theme.add"}</h1>
    {/if}
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            {call formRows form=$form}

            <div class="form__group">
                <div class="col-lg-offset-2 col-lg-10">
                    <button type="submit" class="btn btn--default">{translate key="button.save"}</button>
                    <a href="{$referer}" class="btn">{translate key="button.cancel"}</a>
                    {if $urlDelete}
                        <a href="{$urlDelete}" class="btn">{translate key="button.theme.delete"}</a>
                    {/if}
                </div>
            </div>
        </div>
    </form>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/singles/form.js"></script>
{/block}
