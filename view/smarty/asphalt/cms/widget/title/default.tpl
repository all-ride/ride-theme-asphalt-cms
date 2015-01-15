{* widget: title; action: index; translation: widget.title *}

<div class="widget widget-title {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    <h1 class="{$app.cms.properties->getWidgetProperty('style.title')}">{$app.cms.context.title.node|text}</h1>
</div>
