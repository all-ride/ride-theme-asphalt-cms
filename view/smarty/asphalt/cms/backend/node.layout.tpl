{extends file="cms/backend/index"}

{block name="head_title" prepend}{translate key="title.node.layout"} - {$node->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="cms/backend/taskbar"}

        {url id="cms.node.layout.region" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%", "node" => $node->getId(), "region" => $region] var="url"}
        {call taskbarPanelPublish url=$url revision=$node->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.node.layout.region" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$node->getName($locale)} <small>{translate key="title.node.layout"}</small></h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    {if count($form->getRow('region')->getWidget()->getOptions()) > 1}
    <form id="{$form->getId()}" action="{url id="cms.node.layout" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId()]}" method="POST" class="form-inline" role="form">
        <p>{translate key="label.region.select"} {call formWidget form=$form row="region"}</p>
    </form>
    {/if}

    <div class="grid">
        <div id="region" class="grid--bp-med__6 clearfix">
            <h3>{translate key="title.widgets.content"}</h3>
            <p>{translate key="label.widgets.content.description"}</p>

            <div class="droppable">
                {foreach $regionWidgets as $widgetId => $widget}
                    {include file="cms/backend/widget.content"}
                {/foreach}
            </div>
        </div>

        <div id="widgets" class="grid--bp-med__6 clearfix">
            <h3>{translate key="title.widgets.available"}</h3>
            <p>{translate key="label.widgets.available.description"}</p>

            {foreach $availableWidgets as $name => $widget}
            <div class="widget" data-widget="{$name}">
                <img src="{image src=$widget->getIcon() default="asphalt/img/widget.png"}" class="handle" />
                {translate key="widget.`$name`"}
            </div>
           {/foreach}
        </div>
    </div>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/cms/layout.js"></script>
    <script type="text/javascript">
        $(function() {
            $('select[name=region]').change(function() {
                $('#form-region-select').submit();
            });

            joppaInitializeLayout('{$baseAction}', '{translate key="label.confirm.widget.delete"}');
        });
    </script>
{/block}
