<div class="widget widget-text row-fluid clearfix {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
{if $title}
    <h2 class="toc {$app.cms.properties->getWidgetProperty('style.title')}">{$title}</h2>
{/if}
{if $subtitle}
    <h3 class="toc {$app.cms.properties->getWidgetProperty('style.subtitle')}">{$subtitle}</h3>
{/if}
{if $image}
    {if $html}
    <div class="grid--bp-med__6">
        {if $imageAlignment == 'left'}
            <img src="{image src=$image}" class="img-responsive" />
        {else}
            {$html|text}
            {foreach $callToActions as $callToAction}
                <a href="{$callToAction->getUrl()}" class="btn btn--default cta{if $callToAction->getIcon()} cta-{$callToAction->getIcon()}{/if}">{$callToAction->getLabel()}</a>
            {/foreach}
        {/if}
    </div>
    <div class="grid--bp-med__6">
        {if $imageAlignment == 'left'}
            {$html|text}
            {foreach $callToActions as $callToAction}
                <a href="{$callToAction->getUrl()}" class="btn btn--default cta{if $callToAction->getIcon()} cta-{$callToAction->getIcon()}{/if}">{$callToAction->getLabel()}</a>
            {/foreach}
        {else}
            <img src="{image src=$image}" class="img-responsive" />
        {/if}
    </div>
    {else}
        <img src="{image src=$image}" class="img-responsive" />
    {/if}
{else}
    {$html|text}
    {foreach $callToActions as $callToAction}
        <a href="{$callToAction->getUrl()}" class="btn btn--default cta{if $callToAction->getType()} cta-{$callToAction->getType()}{/if}">{$callToAction->getLabel()}</a>
    {/foreach}
{/if}
</div>
