{function name="layout_100" section=null widgets=null}
<div class="section {$style}">
    <div class="container">
        <div class="grid">
        {$block = '1'}
            <div class="grid--bp-med__12" id="block-{$section}-{$block}">
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
