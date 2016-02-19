{function renderNodeActions actions=null current=null}
    {if $actions}
        <ul class="tabs">
            {foreach $actions as $action => $url}
                <li class="tabs__tab{if $action == $current} active{/if}"><a href="{$url}">{translate key="label.node.action.`$action`"}</a></li>
            {/foreach}
        </ul>
    {/if}
{/function}
