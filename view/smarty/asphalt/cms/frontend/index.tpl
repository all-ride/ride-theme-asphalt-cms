{extends file="base/index"}

{block name="head_title"}{$app.cms.context.title.node} - {$app.cms.context.title.site}{/block}

{block name="head" append}
    {$meta = $app.cms.node->getMeta($app.locale)}
    {if $meta}
        {foreach $meta as $metaName => $metaValue}
    <meta property="{$metaName}" content="{$metaValue}" />
        {/foreach}
    {/if}
{/block}

{block name="styles" append}
    <link href="{$app.url.base}/asphalt/css/cms/front.css" rel="stylesheet" media="screen">
{/block}

{block name="container"}
<div class="container">
    <div class="row region region-header">
    {if isset($regions.header)}
        {foreach $regions.header as $widget}
            {$widget}
        {/foreach}
    {/if}
    </div>
    <div class="grid">
        <div class="grid--bp-med__3 region region-menu">
        {if isset($regions.menu)}
            {foreach $regions.menu as $widget}
                {$widget}
            {/foreach}
        {/if}
        </div>
        <div class="grid--bp-med__9 region region-layout">
            {if isset($app.messages)}
                {$_messageTypes = ["error" => "danger", "warning" => "warning", "success" => "success", "information" => "info"]}
                {foreach $_messageTypes as $_messageType => $_messageClass}
                    {$_messages = $app.messages->getByType($_messageType)}
                    {if $_messages}
                        <div class="alert alert-{$_messageClass}">
                        {if $_messages|count == 1}
                            {$_message = $_messages|array_pop}
                            <p>{$_message->getMessage()}</p>
                        {else}
                            <ul>
                            {foreach $_messages as $_message}
                                <li>{$_message->getMessage()}</li>
                            {/foreach}
                            </ul>
                        {/if}
                        </div>
                    {/if}
                {/foreach}
            {/if}

            {block name="layout"}{/block}
        </div>
    </div>
    <div class="row region region-footer">
    {if isset($regions.footer)}
        {foreach $regions['footer'] as $widget}
            {$widget}
        {/foreach}
    {/if}
    </div>
</div>
{/block}
