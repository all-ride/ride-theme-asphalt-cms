{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
<div class="form__group">
    <div class="tabbable">
        <ul class="tabs">
            <li class="tabs__tab active"><a href="#tabQuery" data-toggle="tab">{translate key="title.query"}</a></li>
            <li class="tabs__tab"><a href="#tabParameters" data-toggle="tab">{translate key="title.parameters.url"}</a></li>
            <li class="tabs__tab"><a href="#tabView" data-toggle="tab">{translate key="title.view"}</a></li>
        </ul>

        <div class="tabs__content">
            <div id="tabQuery" class="tabs__pane active">
                {call formRow form=$form row="model"}
                {call formRow form=$form row="field-id"}
                {call formRow form=$form row="include-unlocalized"}
            </div>

            <div id="tabParameters" class="tabs__pane">
                {call formRow form=$form row="parameters-none"}
            </div>

            <div id="tabView" class="tabs__pane">
                {call formRow form=$form row="template"}
                {call formRow form=$form row="view-processor"}
                {call formRow form=$form row="title"}

                <h4>{translate key="title.formats.data"}</h4>

                {call formRow form=$form row="format-title"}
                {call formRow form=$form row="format-teaser"}
                {call formRow form=$form row="format-image"}
                {call formRow form=$form row="format-date"}
            </div>
        </div>
    </div>

    <div class="form-group">
        <div class="col-lg-offset-2 col-lg-10">
            <input type="submit" class="btn btn--default" value="{translate key="button.save"}" />
            <input type="submit" name="cancel" class="btn btn-link" value="{translate key="button.cancel"}" />
        </div>
    </div>
</fieldset>
</form>
