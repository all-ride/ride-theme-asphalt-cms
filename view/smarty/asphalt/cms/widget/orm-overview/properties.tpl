{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
    <div class="form__group">
        <div class="tabbable">
            <ul class="tabs">
                <li class="tabs__tab active"><a href="#tabQuery" data-toggle="tab">{translate key="title.query"}</a></li>
                <li class="tabs__tab"><a href="#tabParameters" data-toggle="tab">{translate key="title.parameters.url"}</a></li>
                <li class="tabs__tab"><a href="#tabMapper" data-toggle="tab">{translate key="title.content.mapper"}</a></li>
                <li class="tabs__tab"><a href="#tabView" data-toggle="tab">{translate key="title.view"}</a></li>
            </ul>

            <div class="tabs__content">
                <div id="tabQuery" class="tabs__pane active">
                    {call formRow form=$form row="model"}
                    {call formRow form=$form row="include-unlocalized"}

                    <h4>{translate key="title.condition"}</h4>
                    {call formRow form=$form row="condition"}
                    {call formRow form=$form row="filters"}

                    <h4>{translate key="title.order"}</h4>
                    <div class="form-group grid clearfix">
                        <label class="grid--bp-med__2 control-label">{translate key="label.order.field"}</label>
                        <div class="grid--bp-med__10">
                            {call formWidget form=$form row="order-field"}
                            {call formWidget form=$form row="order-direction"}
                            <button class="btn btn--default btn-order-add" id="form-content-properties-order-add">{translate key="button.add"}</button>
                            <span class="help-block">{translate key="label.order.field.description"}</span>
                        </div>
                    </div>

                    {call formRow form=$form row="order"}

                    <h4>{translate key="title.pagination"}</h4>

                    {call formRow form=$form row="pagination-enable"}

                    {call formRow form=$form row="pagination-rows" class="pagination-attribute"}

                    {call formRow form=$form row="pagination-offset" class="pagination-attribute"}
                </div>

                <div id="tabParameters" class="tabs__pane">
                    <p>{translate key="label.parameters.description"}</p>
                    <div class="control-group grid">
                        <label class="grid--bp-med__2 control-label">{translate key="label.parameters"}</label>
                        <div class="grid--bp-med__10">
                            <div class="form__item form__item--radios form__item--radios">
                                <div class="form__radio-item">
                                    <label class="form__label form__label--radio">
                                        {call formWidget form=$form row="parameters-type" part="none"}
                                        {translate key="label.parameters.none"}
                                    </label>
                                </div>
                                <div class="form__radio-item">
                                    <label class="form__label form__label--radio">
                                        {call formWidget form=$form row="parameters-type" part="numeric"}
                                        {translate key="label.parameters.numeric"}
                                    </label>
                                    <div class="help-block">{translate key="label.parameters.numeric.description"}</div>
                                    {call formRow form=$form row="parameters-number" class="parameters-enable parameters-numeric"}
                                </div>
                                <div class="form__radio-item">
                                    <label class="form__label form__label--radio">
                                        {call formWidget form=$form row="parameters-type" part="named"}
                                        {translate key="label.parameters.named"}
                                    </label>
                                    <div class="help-block">{translate key="label.parameters.named.description"}</div>
                                    {call formRow form=$form row="parameters-name" class="parameters-enable parameters-named"}
                                </div>
                            </div>
                        </div>
                    </div>
                    {call formRow form=$form row="parameters-none"}
                </div>

                <div id="tabMapper" class="tabs__pane">
                    {call formRow form=$form row="content-mapper"}
                </div>

                <div id="tabView" class="tabs__pane">
                    {call formRow form=$form row="template"}
                    {call formRow form=$form row="view-processor"}
                    {call formRow form=$form row="title"}
                    {call formRow form=$form row="empty-result-message"}

                    <h4 class="pagination-attribute">{translate key="title.pagination"}</h4>

                    {call formRow form=$form row="pagination-show" class="pagination-attribute"}
                    {call formRow form=$form row="pagination-ajax" class="pagination-attribute pagination-ajax"}
                    {call formRow form=$form row="more-show" class="pagination-attribute"}
                    {call formRow form=$form row="more-label" class="pagination-attribute more-attribute"}
                    {call formRow form=$form row="more-node" class="pagination-attribute more-attribute"}

                    <h4>{translate key="title.formats.data"}</h4>

                    {call formRow form=$form row="format-title"}
                    {call formRow form=$form row="format-teaser"}
                    {call formRow form=$form row="format-image"}
                    {call formRow form=$form row="format-date"}
                </div>
            </div>
        </div>

        <div class="form__actions">
            <button type="submit" class="btn btn--default">{translate key="button.save"}</button>
            <button type="submit" name="cancel" class="btn btn--link">{translate key="button.cancel"}</button>
        </div>
    </div>
</form>
