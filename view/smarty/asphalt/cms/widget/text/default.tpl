<div class="widget widget-text text {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    {if $title}
        <h2 class="toc {$app.cms.properties->getWidgetProperty('style.title')}" id="{$title|safe}">{$title}</h2>
    {/if}
    {if $subtitle}
        <h3 class="toc {$app.cms.properties->getWidgetProperty('style.subtitle')}" id="{$subtitle|safe}">{$subtitle}</h3>
    {/if}

    <div class="text__inner clearfix">
        {if $image}
            {$imageClass = 'image'}
            {if $imageAlignment == 'left'}
                {$imageClass = "`$imageClass` image--responsive image--left"}
            {elseif $imageAlignment == 'right'}
                {$imageClass = "`$imageClass` image--responsive image--right"}
            {elseif $imageAlignment == 'justify'}
                {$imageClass = "`$imageClass` image--full-width"}
            {else}
                {$imageClass = "`$imageClass` image--responsive"}
            {/if}

            {if $html}
                <img src="{image src=$image width=300 height=300 transformation="resize"}" class="{$imageClass}" />
                {$html|text}
                {foreach $callToActions as $callToAction}
                    <a href="{$callToAction->getUrl()}" class="cta{if $callToAction->getType()} cta-{$callToAction->getType()}{/if}">{$callToAction->getLabel()}</a>
                {/foreach}
            {else}
                <img src="{image src=$image width=300 height=300 transformation="resize"}" class="{$imageClass}" />
                {foreach $callToActions as $callToAction}
                    <a href="{$callToAction->getUrl()}" class="cta{if $callToAction->getType()} cta-{$callToAction->getType()}{/if}">{$callToAction->getLabel()}</a>
                {/foreach}
            {/if}
        {else}
            {$html|text}
            {foreach $callToActions as $callToAction}
                <a href="{$callToAction->getUrl()}" class="text__cta cta{if $callToAction->getType()} cta-{$callToAction->getType()}{/if}">{$callToAction->getLabel()}</a>
            {/foreach}
        {/if}
    </div>
</div>
