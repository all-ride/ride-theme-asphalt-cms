{if isset($filterWidgetId)}
    {if isset($app.cms.context["orm.filters.`$filterWidgetId`"])}
        {$bodyComponent = $app.cms.node->get('body.components')}
        {$app.cms.node->set('body.components', "`$bodyComponent` form")}
        {$filters = $app.cms.context["orm.filters.`$filterWidgetId`"]}
    {/if}
{/if}

<form action="{$app.cms.node->getUrl($app.locale, $app.url.script)}" method="GET" class="form form--filter filter">
    <div class="text--lead filter__lead">{translate key="label.filter"}:</div>
    {foreach $filters as $filterName => $filter}
        {$isMulti = $filter.type == "multi.or" || $filter.type == "multi.and"}
        <div class="form__item form__item--{$filterName} form__item--checkboxes">
            {* <h3>{$filterName}</h3> *}
            {if !$isMulti}
                <div class="form__checkbox-item">
                    <label class="form__label {if !$filter.value} form__label--selected{/if} form__label--checkbox">
                        <input name="{$filterName}" type="radio" value="" {if !$filter.value} checked="checked"{/if}>
                    </label>
                </div>
            {/if}
            {foreach $filter.options as $id => $label}
                {$isSelected = $filter.values.$label == $filter.value || (is_array($filter.value) && in_array($filter.values.$label, $filter.value))}
                <div class="form__checkbox-item">
                    <label for="{$filterName}{$id}" class="form__label {if $isSelected} form__label--selected{/if} form__label--checkbox">
                        <input{if $isSelected} checked="checked"{/if} type="{if $isMulti}checkbox{else}radio{/if}" id="{$filterName}{$id}" value="{$id}" name="{$filterName}{if $isMulti}[]{/if}" class="form__checkbox" /> {$label}
                    </label>
                </div>
            {/foreach}
            <button class="btn btn--default">{translate key="button.filter"}</button>
        </div>
    {/foreach}
</form>
