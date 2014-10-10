{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
    <div class="form__group">
        <div class="tab">
            <div class="tabbable">
                <ul class="tabs">
                    <li class="tabs__tab active"><a href="#tabWidget" data-toggle="tab">{translate key="widget.google.analytics"}</a></li>
                    <li class="tabs__tab"><a href="#tabView" data-toggle="tab">{translate key="title.view"}</a></li>
                </ul>
            </div>

            <div class="tabs__content">
                <div id="tabWidget" class="tabs__pane active">
                    {call formRow form=$form row="code"}
                </div>

                <div id="tabView" class="tabs__pane">
                    {call formRow form=$form row="template"}
                </div>
            </div>
        </div>

        {call formRows form=$form}

        <div class="form-group">
            <div class="col-lg-offset-2 col-lg-10">
                <input type="submit" name="action" class="btn btn--default" value="{translate key="button.save"}" />
                <a class="btn btn--link" href="{url id="cms.node.layout" parameters=["locale" => $locale, "site" => $site->getId(), "node" => $node->getId(), "region" => $region]}">{translate key="button.cancel"}</a>
            </div>
        </div>
    </fieldset>
</form>
