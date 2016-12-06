{function renderNodeActions actions=null current=null}
    {if $actions}
        {if $actions['go']}
            {$url = $node->getUrl($locale, $app.url.script)}
            <p><a href="{$url}" target="_blank">{$url}</a></p>
        {/if}
        <ul class="tabs">
            {foreach $actions as $action => $url}
                {if $action == "go"}
                    {continue}
                {/if}
                <li class="tabs__tab{if $action == $current} active{/if}"><a href="{$url}">{translate key="label.node.action.`$action`"}</a></li>
            {/foreach}
            {url id="cms.{$node->getType()}.edit" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId()] var='url'}
            {isGranted url=$url}
            <li class="tabs__tab {if $current == 'settings'}active{/if}"><a href="{$url}">{translate key="label.node.action.edit"}</a></li>
            {/isGranted}
        </ul>
    {/if}
{/function}
