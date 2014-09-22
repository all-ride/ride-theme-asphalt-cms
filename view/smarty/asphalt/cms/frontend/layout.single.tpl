{extends file="cms/frontend/index"}

{block name="layout"}
    <div class="row region">
    {foreach $regions['column1'] as $widget}
        {$widget}
    {/foreach}
    </div>
{/block}
