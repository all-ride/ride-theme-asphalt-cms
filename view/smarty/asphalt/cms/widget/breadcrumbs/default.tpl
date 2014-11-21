{* widget: breadcrumbs; action: index; translation: widget.breadcrumbs *}

<div class="widget widget-breadcrumbs {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    <ol class="breadcrumb {$app.cms.properties->getWidgetProperty('style.menu')}">
    {foreach $app.cms.context.breadcrumbs as $url => $label}
        {if $label@last}
            <li class="active">{$label}</li>
        {else}
            <li><a href="{$url}">{$label}</a></li>
        {/if}
    {/foreach}
    </ol>
</div>
