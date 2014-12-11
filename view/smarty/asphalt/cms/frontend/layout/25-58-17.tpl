{function name="layout_25_50_25" section=null widgets=null}
<div class="section {$style}">
    <div class="container">
        <div class="grid">
        {$block = '1'}
            <div class="grid--bp-med__3 block" id="block-{$section}-{$block}" data-section="{$section}" data-block="{$block}">
        {if isset($widgets[$block])}
            {foreach $widgets[$block] as $widget}
                {$widget}
            {/foreach}
        {/if}
            </div>
        {$block = '2'}
            <div class="grid--bp-med__7 block" id="block-{$section}-{$block}" data-section="{$section}" data-block="{$block}">
        {if isset($widgets[$block])}
            {foreach $widgets[$block] as $widget}
                {$widget}
            {/foreach}
        {/if}
            </div>
        {$block = '3'}
            <div class="grid--bp-med__2 block" id="block-{$section}-{$block}" data-section="{$section}" data-block="{$block}">
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
