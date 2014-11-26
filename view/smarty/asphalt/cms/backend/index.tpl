{extends file="base/index.sidebar"}

{block name="styles" append}
    <link href="{$app.url.base}/asphalt/css/cms/cms.css" rel="stylesheet" media="screen">
{/block}

{block name="sidebar"}
    {if isset($nodeCreateActions)}
    <div class="btn--group dropdown">
      <button type="button" class="btn btn--default" data-toggle="dropdown">{translate key="button.create"} <i class="icon icon--angle-down"></i></button>
      <ul class="dropdown__menu" role="menu">
        {foreach $nodeCreateActions as $nodeTypeName => $nodeActionUrl}
            <li><a href="{$nodeActionUrl}">{translate key="label.node.type.`$nodeTypeName`"}</a></li>
        {/foreach}
      </ul>
    </div>
    {/if}


    {if isset($siteTreeNode)}
        {$treeIcons = [
            'site' => 'globe',
            'page' => 'file-o',
            'folder' => 'folder-open-o',
            'entry' => 'hdd-o',
            'redirect' => 'share-square-o'
        ]}

        {function name="renderTreeNode" treeNode=null treeIcons=null}
            {$node = $treeNode->getNode()}
            {$nodeId = $node->getId()}
            {$nodeType = $node->getType()}
            {$children = $treeNode->getChildren()}
            {$actions = $treeNode->getActions()}

            <li class="node node-{$nodeType}{if !$treeNode->isLocalized($locale)} unlocalized{/if}{if $treeNode->isSelected()} selected{/if}" id="node-{$node->getId()}">
                {if $children}
                <a href="#" class="toggle"><i class="icon icon--{if $treeNode->isCollapsed()}minus{else}plus{/if}-square-o"></i></a>
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

                <div class="handle"><span class="icon icon--{$iconClass}"></span></div>
                <div class="dropdown">
                    <a href="{$treeNode->getUrl()}" class="name">{$node->getName($locale)|truncate:20}</a>
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
                    {foreach $children as $child}
                        {call renderTreeNode treeNode=$child treeIcons=$treeIcons}
                    {/foreach}
                </ul>
                {/if}
            </li>
        {/function}

        <ul id="node-tree">
           {call renderTreeNode treeNode=$siteTreeNode treeIcons=$treeIcons}
        </ul>
    {/if}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/jquery-ui.js"></script>
    <script src="{$app.url.base}/asphalt/js/cms/lib/jquery.mjs.nestedSortable.js"></script>
    <script src="{$app.url.base}/asphalt/js/cms/tree.js"></script>
    {if isset($site)}
    <script type="text/javascript">
        $(function() {
            joppaInitializeNodeTree('{url id="cms.node.collapse" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale, "node" => "%node%"]}', '{url id="cms.site.order" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale]}');
            });
    </script>
    {/if}
{/block}
