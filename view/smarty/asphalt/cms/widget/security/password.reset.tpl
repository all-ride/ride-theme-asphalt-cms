{include file="base/form.prototype"}

<form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
    <div class="form__group">
        {call formRow form=$form row="username"}

        <div class="form-group or">
            <div class="col-lg-offset-2 col-lg-10">
                {translate key="label.or"}
            </div>
        </div>

        {call formRow form=$form row="email"}

        <div class="form-group">
            <div class="col-lg-offset-2 col-lg-10">
                <input type="submit" class="btn btn--default" value="{translate key="button.submit"}" />
            </div>
        </div>
    </fieldset>
</form>
