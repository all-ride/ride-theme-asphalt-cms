{*
    Renders a section header
*}

{function name="sectionPanel" site=null node=null section=null layouts=null layout=null widgets=null inheritedWidgets=null actions=null}
<div class="section section--no-padding panel panel-default clearfix" data-section="{$section}">
    <div class="panel-heading clearfix">
        {call sectionHeader layouts=$layouts layout=$layout}
    </div>
    <div class="panel-body">
        {call sectionContent site=$site node=$node section=$section layout=$layout widgets=$widgets inheritedWidgets=$inheritedWidgets actions=$actions}
    </div>
</div>
{/function}

{function 'sectionHeader' layouts=null layout=null}
    <div class="section__handle">
        <div class="handle"><i class="icon icon--arrows"></i></div>
    </div>
    <div class="section__layouts">
    {$enabledLayouts = $app.system->getConfig()->get('cms.layouts')}
    {foreach $layouts as $l}
        {$layoutName = $l->getName()}
        {if !$enabledLayouts || $enabledLayouts[$layoutName] || $layoutName == $layout}
        {$layoutTitle = "layout.$layoutName"|translate|escape}
        <a href="#" class="layout layout-{$layoutName}{if $layoutName == $layout} layout-active{/if}" title="{$layoutTitle}" data-layout="{$layoutName}">
        </a>
        {/if}
    {/foreach}
    </div>
    <div class="section__actions text-right">

        {url id='cms.node.content.section.properties' parameters=[
            'site' => $site->getId(),
            'revision' => $node->getRevision(),
            'node' => $node->getId(),
            'locale' => $locale,
            'region' => $region,
            'section' => $section
        ] var='propertyActionUrl'}

        {url id='cms.node.content.section.style' parameters=[
            "site" => $site->getId(),
            "revision" => $node->getRevision(),
            "node" => $node->getId(),
            "locale" => $locale,
            "region" => $region,
            "section" => $section
        ] var='styleActionUrl'}

        <a href="{$propertyActionUrl}?referer={$app.url.request|urlencode}" class="action" title="{'label.widget.action.properties'|translate}">
            <i class="icon icon--cog"></i>
            <span class="visuallyhidden">{'label.widget.action.properties'|translate}</span>
        </a>

        <a href="{$styleActionUrl}?referer={$app.url.request|urlencode}" class="action" title="{'label.widget.action.style'|translate}">
            <i class="icon icon--paint-brush"></i>
            <span class="visuallyhidden">{'label.widget.action.style'|translate}</span>
        </a>

        <a href="#" class="action section-delete" title="{'button.delete'|translate}" data-confirm="{'label.confirm.section.delete'|translate|escape}">
            <i class="icon icon--close"></i>
            <span class="visuallyhidden">{'button.delete'|translate}</span>
        </a>
    </div>
{/function}

{function name="sectionContent" site=null node=null section=null layout=null widgets=null inheritedWidgets=null actions=null}
    <div class="section__content">
        {$functionName = "layout-$layout"|replace:'-':'_'}
        {call $functionName site=$site node=$node section=$section widgets=$widgets inheritedWidgets=$inheritedWidgets actions=$actions}
    </div>
{/function}

{function name="widgetPanel" site=null node=null widget=null widgetId=null inheritedWidgets=$inheritedWidgets actions=$actions}
    {$availableActions = []}
    {foreach $actions as $actionName => $action}
        {if $action->isAvailableForWidget($node, $widget)}
            {url var="actionUrl" id=$action->getRoute() parameters=["site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "locale" => $locale, "region" => $region, "section" => $section, "block" => $block, "widget" => $widgetId]}
            {isGranted url=$actionUrl permission="cms.widget.`$widget->getName()`.`$actionName`" var="isGranted"}{/isGranted}
            {if $isGranted}
                {$availableActionName = "label.widget.action.`$actionName`"|translate}
                {$availableActionUrl = $app.url.request|urlencode}
                {$availableActionUrl = "`$actionUrl`?referer=`$availableActionUrl`"}
                {$availableActions[$availableActionUrl] = $availableActionName}
            {/if}
        {/if}
    {/foreach}
    {url var="actionUrl" id="cms.node.content.widget.delete" parameters=["site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "locale" => $locale, "region" => $region, "section" => $section, "block" => $block, "widget" => $widgetId]}
    {isGranted url=$actionUrl permission="cms.widget.`$widget->getName()`.manage" var="isGranted"}{/isGranted}
    {if $isGranted}
        {if $availableActions}
            {$availableActions[] = '-'}
        {/if}

        {$deleteAction = ["label" => "button.delete"|translate, "class" => "widget-delete", "data-confirm" => "label.confirm.widget.delete"|translate|escape]}
        {$availableActions[(string) $actionUrl] = $deleteAction}
    {/if}

<div class="widget{if isset($inheritedWidgets[$widgetId])} inherited{/if}{if !$availableActions} locked{/if} clearfix" data-widget="{$widgetId}">
    <div class="widget__header clearfix">
        <div class="widget__handle">
            <div class="handle"><i class="icon icon--arrows"></i></div>
        </div>
        <div class="widget__actions text-right dropdown">
            {if isset($inheritedWidgets[$widgetId])}
                <i class="icon icon--exclamation-circle" title="{translate key="warning.widget.inherited"}"></i>
            {/if}

            {if $availableActions}
            <a href="#" class="dropdown" data-toggle="dropdown"><i class="icon icon--cog"></i></a>
            <ul class="dropdown__menu dropdown__menu--right">
                {foreach $availableActions as $actionUrl => $action}
                    {if $action == '-'}
                        <li class="dropdown__divider"></li>
                    {elseif !is_array($action)}
                        <li>
                            <a href="{$actionUrl}">{$action}</a>
                        </li>
                    {else}
                        <li>
                            <a{foreach $action as $attribute => $attributeValue}{if $attribute != 'label'} {$attribute}="{$attributeValue}"{/if}{/foreach}>
                                {$action["label"]}
                            </a>
                        </li>
                    {/if}
                {/foreach}
            </ul>
            {/if}
        </div>
        <div class="widget__title text-left">
            <img src="{image src=$widget->getIcon() default="asphalt/img/cms/widget.png"}" />
            {$name = $widget->getName()}
            {if $widget->getPropertiesCallback()}
                {isGranted permission="cms.widget.`$name`.properties"}
                <a class="name" href="{url id="cms.node.content.widget.properties" parameters=["site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "locale" => $locale, "region" => $region, "section" => $section, "block" => $block, "widget" => $widgetId]}">
                    {translate key="widget.`$name`"}
                </a>
                {/isGranted}
                {isNotGranted permission="cms.widget.`$name`.properties"}
                    <span class="name">{translate key="widget.`$name`"}</span>
                {/isNotGranted}
            {else}
                <span class="name">{translate key="widget.`$name`"}</span>
            {/if}
        </div>
    </div>
    <div class="widget__content">
        {$widget->getPropertiesPreview()}
        {if !$widget->getProperties()->isPublished()}
            <span class="label label--warning">{translate key="widget.published.not"}</span>
        {/if}
        {if $widget->getProperties()->getAvailableLocales()|is_array}
            <span class="label label--warning">{translate key="widget.locales.available"}: {', '|implode:$widget->getProperties()->getAvailableLocales()}</span>
        {/if}
    </div>
</div>
{/function}
