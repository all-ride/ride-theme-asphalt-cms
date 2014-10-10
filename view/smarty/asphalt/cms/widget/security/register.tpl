<div class="widget widget-register {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
        <div class="form__group">
            {call formRows form=$form}

            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
                    <input type="submit" class="btn btn--default" value="{translate key="button.register"}" />
                </div>
            </div>
        </fieldset>
    </form>
</div>
