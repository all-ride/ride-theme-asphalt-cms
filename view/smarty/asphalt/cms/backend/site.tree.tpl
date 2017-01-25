{$treeIcons = [
    'site' => 'globe',
    'page' => 'file-o',
    'folder' => 'folder-open-o',
    'entry' => 'hdd-o',
    'reference' => 'share-square-o',
    'redirect' => 'refresh'
]}

{function name="renderTreeNode" treeNode=null level=null treeIcons=null}
    {$node = $treeNode->getNode()}
    {$nodeId = $node->getId()}
    {$nodeType = $node->getType()}
    {$children = $treeNode->getChildren()}
    {$actions = $treeNode->getActions()}
    {$isLocalized = $treeNode->isLocalized($locale)}

    <li class="node node-{$nodeType}{if !$treeNode->isLocalized($locale)} is-unavailable{/if}{if $treeNode->isSelected()} selected{/if}" id="node-{$node->getId()}">
        {if $children}
        <a href="#" class="toggle"><i class="icon icon--minus-square-o"></i></a>
        {else}
        <span class="toggle"></span>
        {/if}

        {if $treeNode->isHomePage()}
            {$iconClass = 'home'}
        {else if $treeNode->isHidden()}
            {$iconClass = 'eye-slash'}
        {else}
            {$iconClass = $treeIcons.$nodeType}
        {/if}
        {$nodeName = $node->getName($locale)}

        {$truncateLength = 20}
        {if $level > 3}
            {$truncateLength = 15}
        {/if}

        <div class="handle"><span class="icon icon--{$iconClass}"></span></div>
        <div class="dropdown">
            <a href="{$treeNode->getUrl()}" class="name" title="{$nodeName|escape}">{$nodeName|truncate:$truncateLength}</a>
            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon icon--angle-down"></i></a>
            <ul class="dropdown__menu" role="menu">
            {$hasDivider = false}
            {foreach $actions as $actionName => $actionUrl}
                {if !$hasDivider && ($actionName == 'edit' || $actionName == 'clone' || $actionName == 'delete')}
                    {$hasDivider = true}

                    <li class="dropdown__divider"></li>
                {/if}

                <li><a href="{$actionUrl}" class="action action-{$actionName}">{translate key="label.node.action.`$actionName`"}</a></li>
            {/foreach}
            </ul>
        </div>

        {if $children}
        <ul class="children">
            {$level = $level + 1}
            {foreach $children as $child}
                {call renderTreeNode treeNode=$child treeIcons=$treeIcons level=$level}
            {/foreach}
        </ul>
        {/if}
    </li>
{/function}

<ul id="node-tree">
   {call renderTreeNode treeNode=$siteTreeNode level=0 treeIcons=$treeIcons}
</ul>
