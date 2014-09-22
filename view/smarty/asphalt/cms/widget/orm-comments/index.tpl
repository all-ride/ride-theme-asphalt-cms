<div class="widget widget-comments {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
{if $title}
    <h2 class="toc {$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h2>
{/if}

{if $comments}
    {foreach $comments as $comment}
    <div class="comment {cycle values="odd,even"}">
        <div class="body">{$comment->body|escape}</div>
        <div class="info">{$comment->name|escape} - {$comment->dateAdded|date_format:"Y-m-d H:i:s"}</div>
    </div>
    {/foreach}
{else}
    <p>{translate key="label.comments.none"}</p>
{/if}

{if $form}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            {call formRows form=$form}

            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
                    <input type="submit" class="btn btn-default" value="{translate key="button.comment"}" />
                </div>
            </div>
        </fieldset>
    </form>
{else}
    <p>{translate key="label.comments.authenticated"}</p>
{/if}
</div>
