{extends file="cms/backend/index"}

{block name="head_title" prepend}{translate key="title.node.layout"} - {$node->getName($locale)} - {/block}

{block name="taskbar_panels" append}
    {if !$site->isAutoPublish()}
        {include file="cms/backend/taskbar"}

        {url id="cms.node.content.region" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => "%revision%", "node" => $node->getId(), "region" => $region] var="url"}
        {call taskbarPanelPublish url=$url revision=$node->getRevision() revisions=$site->getRevisions()}
    {/if}

    {url id="cms.node.content.region" parameters=["locale" => "%locale%", "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region] var="url"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{$node->getName($locale)} <small>{translate key="title.node.layout"}</small></h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="cms/backend/content.prototype"}
    {foreach $layouts as $layout}
        {include file=$layout->getBackendResource() inline}
    {/foreach}
    {include file="base/form.prototype"}

    {if count($form->getRow('region')->getWidget()->getOptions()) > 1}
    <form id="{$form->getId()}" action="{url id="cms.node.content" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId()]}" method="POST" class="form-inline" role="form">
        <p>{translate key="label.region.select"} {call formWidget form=$form row="region"}</p>
    </form>
    {/if}

    <p><button class="btn btn--default section-add"><i class="glyphicon glyphicon-plus"></i> {translate key="button.section.add"}</button></p>

    <div class="sections">
    {foreach $sections as $section => $layout}
        {call sectionPanel site=$site node=$node section=$section layouts=$layouts layout=$layout widgets=$regionWidgets[$section] inheritedWidgets=$inheritedWidgets[$section] actions=$actions}
    {/foreach}
    </div>

    <p><button class="btn btn--default section-add"><i class="glyphicon glyphicon-plus"></i> {translate key="button.section.add"}</button></p>

    <div class="modal modal-widget-add fade" id="modalWidgetAdd" tabindex="-1" role="dialog" aria-labelledby="modalWidgetAddLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">{translate key="button.close"}</span></button>
                    <h4 class="modal-title" id="modalWidgetAddLabel">{translate key="button.widget.add"}</h4>
                </div>
                <div class="modal-body">
                    <form action="#" class="form-widget-add">
                        <input name="section" type="hidden" />
                        <input name="block" type="hidden" />

                        <p>{translate key="label.widgets.available.description"}</p>

                        <div class="grid">
                        {foreach $availableWidgets as $name => $widget}
                        <div class="grid--bp-med__6 widget" data-widget="{$name}">
                            <div class="radio">
                                <label>
                                    <input name="widget" value="{$name}" type="radio">
                                    <img src="{image src=$widget->getIcon() default="img/widget.png"}" class="handle" />
                                    {translate key="widget.`$name`"}
                                </label>
                            </div>
                        </div>
                            {if $widget@iteration is div by 2}
                        </div><div class="row">
                            {/if}
                       {/foreach}
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn--link" data-dismiss="modal">{translate key="button.cancel"}</button>
                    <button type="button" class="btn btn--default widget-add-submit">{translate key="button.add"}</button>
                    <button type="button" class="btn btn--default widget-add-submit-close">{translate key="button.add.close"}</button>
                </div>
            </div>
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

            initializeContent('{$baseAction}', '{translate key="label.confirm.widget.delete"}');
        });
    </script>
{/block}
