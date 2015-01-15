{extends file="base/index.sidebar"}

{block name="styles" append}
    <link href="{$app.url.base}/asphalt/css/cms/cms.css" rel="stylesheet" media="screen">
{/block}

{block name="content_title" append}
    <ol class="breadcrumb">
    {foreach $breadcrumbs as $url => $name}
        {if $name@last}
            <li class="active">{$name}</li>
        {else}
            <li><a href="{$url}">{$name}</a></li>
        {/if}
    {/foreach}
    </ol>
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

    <div class="site-tree">
        <div class="loading"></div>
    </div>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/asphalt/js/jquery-ui.js"></script>
    <script src="{$app.url.base}/asphalt/js/cms/lib/jquery.mjs.nestedSortable.js"></script>
    <script src="{$app.url.base}/asphalt/js/cms/tree.js"></script>
    {if isset($site)}
    <script type="text/javascript">
        $(function() {
            joppaInitializeNodeTree(
                '{url id="cms.site.tree" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale]}',
                '{url id="cms.node.collapse" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale, "node" => "%node%"]}',
                '{url id="cms.site.order" parameters=["site" => $site->getId(), "revision" => $site->getRevision(), "locale" => $locale]}',
                {$collapsedNodes},
                {if isset($node)}'{$node->getId()}'{else}null{/if}
            );
        });
    </script>
    {/if}
{/block}
