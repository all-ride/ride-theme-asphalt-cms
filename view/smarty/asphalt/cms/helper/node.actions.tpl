{function renderNodeActions actions=null current=null}
    {if $actions}
        {if $actions['go']}
            {$baseUrl = $app.system->getConfig()->get("cms.url.`$site->getId()`.`$locale`", $app.url.script)}
            {$url = "`$baseUrl``$node->getRoute($locale)`"}
            <p>
            <small>
                {$url}
                &nbsp;
                <a class="" href="{if isset($actions.go)}{$actions.go}{else}{$url}{/if}" target="_blank">
                    {translate key="button.view.page"}

                    <span class="icon icon--external-link"></span>
                </a>
            </small>
            </p>
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
