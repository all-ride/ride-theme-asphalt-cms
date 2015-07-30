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

{function name="sectionHeader" layouts=null layout=null}
    <div class="section__handle">
        <div class="handle"><i class="icon icon--arrows"></i></div>
    </div>
    <div class="section__layouts">
{foreach $layouts as $l}
    {$layoutName = $l->getName()}
        <a href="#" class="layout layout-{$layoutName}{if $layoutName == $layout} layout-active{/if}" title="{"layout.`$layoutName`"|translate|escape}" data-layout="{$layoutName}">
            <img src="{image src="img/cms/layout/`$layoutName`.png" transformation="resize" width=30 height=30}" />
        </a>
{/foreach}
    </div>
    <div class="section__actions text-right dropdown">
        <a href="#" class="dropdown" data-toggle="dropdown"><i class="icon icon--cog"></i></a>
        <ul class="dropdown__menu dropdown__menu--right">
            <li><a href="#" class="widget-add">{translate key="button.widget.add"}</a></li>
            <li>
                <a href="{url id="cms.node.content.section.properties" parameters=["site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "locale" => $locale, "region" => $region, "section" => $section]}?referer={$app.url.request|urlencode}">
                    {translate key="label.widget.action.properties"}
                </a>
            </li>
            <li>
                <a href="{url id="cms.node.content.section.style" parameters=["site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "locale" => $locale, "region" => $region, "section" => $section]}?referer={$app.url.request|urlencode}">
                    {translate key="label.widget.action.style"}
                </a>
            </li>
            <li class="divider"></li>
            <li><a class="section-delete" href="#" data-confirm="{"label.confirm.section.delete"|translate|escape}">{translate key="button.delete"}</a></li>
        </ul>
    </div>
{/function}

{function name="sectionContent" site=null node=null section=null layout=null widgets=null inheritedWidgets=null actions=null}
    <div class="section__content">
        {$functionName = "layout-`$layout`"|replace:"-":"_"}
        {call $functionName site=$site node=$node section=$section widgets=$widgets inheritedWidgets=$inheritedWidgets actions=$actions}
    </div>
{/function}

{function name="widgetPanel" site=null node=null widget=null widgetId=null inheritedWidgets=$inheritedWidgets actions=$actions}
<div class="widget {if isset($inheritedWidgets[$widgetId])} inherited{/if} clearfix" data-widget="{$widgetId}">
    <div class="widget__header clearfix">
        <div class="widget__handle">
            <div class="handle"><i class="icon icon--arrows"></i></div>
        </div>
        <div class="widget__actions text-right dropdown">
            <a href="#" class="dropdown" data-toggle="dropdown"><i class="icon icon--cog"></i></a>
            <ul class="dropdown__menu dropdown__menu--right">
                {$actionsAvailable = false}
                {foreach $actions as $actionName => $action}
                    {if $action->isAvailableForWidget($node, $widget)}
                        {url var="actionUrl" id=$action->getRoute() parameters=["site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "locale" => $locale, "region" => $region, "section" => $section, "block" => $block, "widget" => $widgetId]}
                        {isGranted url=$actionUrl}
                            {$actionsAvailable = true}
                            <li>
                                <a href="{$actionUrl}?referer={$app.url.request|urlencode}">
                                    {translate key="label.widget.action.`$actionName`"}
                                </a>
                            </li>
                        {/isGranted}
                    {/if}
                {/foreach}

                {url var="actionUrl" id="cms.node.content.widget.delete" parameters=["site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "locale" => $locale, "region" => $region, "section" => $section, "block" => $block, "widget" => $widgetId]}
                {isGranted url=$actionUrl}
                    {if $actionsAvailable}
                        <li class="divider"></li>
                    {/if}
                        <li>
                            <a class="widget-delete" href="{$actionUrl}" data-confirm="{"label.confirm.widget.delete"|translate|escape}">
                                {translate key="button.delete"}
                            </a>
                        </li>
                    </ul>
                {/isGranted}
            </ul>
        </div>
        <div class="widget__title text-left">
            <img src="{image src=$widget->getIcon() default="bootstrap/img/cms/widget.png"}" />
            {$name = $widget->getName()}
            {if $widget->getPropertiesCallback()}
                <a class="name" href="{url id="cms.node.content.widget.properties" parameters=["site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "locale" => $locale, "region" => $region, "section" => $section, "block" => $block, "widget" => $widgetId]}">
                    {translate key="widget.`$name`"}
                </a>
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
    </div>
</div>
{/function}
