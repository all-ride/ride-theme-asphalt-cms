<div class="widget widget-contact {$app.cms.properties->getWidgetProperty('style.container')}" id="widget-{$app.cms.widget}">
    {include file="base/form.prototype"}

    <form action="{$app.url.request}" method="post" role="form">
        {call formRows form=$form}

        <div class="col-lg-offset-2 col-lg-10">
            <input type="submit" class="btn" value="{translate key="button.submit"}" />
        </div>
    </form>
</div>
