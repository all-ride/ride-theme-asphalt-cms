{function renderNodeActions actions=null current=null}
    {$availableLocales = $node->getAvailableLocales()}
    {$hasAvailableLocales = $availableLocales|is_array || $availableLocales == "all"}
    {if $actions}
        {if isset($actions['go'])}
            {$baseUrl = $app.system->getConfig()->get("cms.url.`$site->getId()`.`$locale`", $app.url.script)}
            {$url = "`$baseUrl``$node->getRoute($locale)`"}
            <p class="locale__url">
                <small>
                    {$url}
                    {if $node->isAvailableInLocale($app.locale)}
                        <a class="" href="{if isset($actions.go)}{$actions.go}{else}{$url}{/if}" target="_blank">
                            {translate key="button.view.page"}
                            <span class="icon icon--external-link"></span>
                        </a>
                    {/if}
                </small>
            </p>
            {if $hasAvailableLocales}
                <div class="locale__label">
                    {call showLocaleLabels availableLocales=$availableLocales}
                </div>
            {/if}

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

{function showLocaleLabels availableLocales=null}
    {$hasSomeAvailableLocales = $availableLocales|is_array}
    {if $hasSomeAvailableLocales}
        {foreach $locales as $locale}
            {if $locale|in_array:$availableLocales}
                {* the available locales *}
                <span class="label label--success">{$locale}</span>
            {else}
                {* the unavailable locales  *}
                <span class="label label--warning">
                    <del>{$locale}</del>
                </span>
            {/if}
        {/foreach}
    {/if}
    {* don't show any labels when all the locales are available *}
{/function}
