{extends file="cms/frontend/index"}

{block name="layout"}
    <div class="grid">
        <div class="grid--bp-med__4 region">
    {foreach $regions['column1'] as $widget}
        {$widget}
    {/foreach}
        </div>
        <div class="grid--bp-med__4 region">
    {foreach $regions['column2'] as $widget}
        {$widget}
    {/foreach}
        </div>
        <div class="grid--bp-med__4 region">
    {foreach $regions['column3'] as $widget}
        {$widget}
    {/foreach}
        </div>
    </div>
{/block}
