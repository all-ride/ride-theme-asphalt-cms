{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form" action="{$app.url.request}" method="POST" role="form">
    <div class="form__group">
        <div class="tab">
            <div class="tabbable">
                <ul class="tabs">
                    <li class="tabs__tab active"><a href="#tabWidget" data-toggle="tab">{translate key="widget.assets"}</a></li>
                    <li class="tabs__tab"><a href="#tabView" data-toggle="tab">{translate key="title.view"}</a></li>
                </ul>
            </div>

            <div class="tabs__content">
                <div id="tabView" class="tabs__pane">
                    {call formRow form=$form row="template"}
                    {call formRow form=$form row="title"}
                </div>

                <div id="tabWidget" class="tabs__pane active">
                    {call formRows form=$form}
                </div>

            </div>
        </div>

        <div class="form__actions">
            <button type="submit" name="action" class="btn btn--default">{translate key="button.save"}</button>
            <a class="btn btn--link" href="{url id="cms.node.content.region" parameters=["locale" => $locale, "site" => $site->getId(), "revision" => $node->getRevision(), "node" => $node->getId(), "region" => $region]}">{translate key="button.cancel"}</a>
        </div>
    </div>
</form>
