{function name="layout_50_50" section=null widgets=null}
<div class="section {$style}">
    <div class="container">
        <div class="grid">
        {$block = '1'}
            <div class="grid--bp-med__6" id="block-{$section}-{$block}">
        {if isset($widgets[$block])}
            {foreach $widgets[$block] as $widget}
                {$widget}
            {/foreach}
        {/if}
            </div>
        {$block = '2'}
            <div class="grid--bp-med__6" id="block-{$section}-{$block}">
        {if isset($widgets[$block])}
            {foreach $widgets[$block] as $widget}
                {$widget}
            {/foreach}
        {/if}
            </div>
        </div>
    </div>
</div>
{/function}
