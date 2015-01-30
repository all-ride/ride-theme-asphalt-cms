function joppaInitializeNodeTree(nodeTreeAction, nodeToggleAction, nodeOrderAction, collapsedNodes, node) {
    $('.site-tree').load(nodeTreeAction, function() {
        var $tree = $('#node-tree');

        // select current node
        if (node) {
            $('.node').removeClass('selected');
            $('#node-' + node).addClass('selected');
        }

        // implement the expand/collapse function of the node tree
        for (var collapsedNode in collapsedNodes) {
            $('#node-' + collapsedNode).addClass('collapsed');
        }

        // implement the expand/collapse function of the node tree
        $tree.find(".node a.toggle").each(function(i) {
            $(this).click(function() {
                var $that = $(this),
                    $parent  = $that.parent(),
                    $icon = $that.find('.icon');

                var nodeId = $parent.attr('id').replace('node-', '');

                $parent.toggleClass('closed');
                $icon.toggleClass('icon--plus-square-o').toggleClass('icon--minus-square-o');

                $.post(nodeToggleAction.replace('%25node%25', nodeId));

                return false;
            });
        });

        // implement the sortable tree
        var nestedSortableConfig = {
            listType: 'ul',
            items: 'li',
            handle: '.handle',
            helper: 'clone',
            opacity: 0.6,
            placeholder: 'placeholder',
            protectRoot: true,
            isTree: true,
            update: function(){
                var order = $tree.nestedSortable('serialize');
                $tree
                  .nestedSortable('destroy')
                  .addClass('disabled');
                $.post(nodeOrderAction, {data: order}, function(data) {
                  $tree
                    .nestedSortable(nestedSortableConfig)
                    .removeClass('disabled');
                });
            }
        };
        $tree.nestedSortable(nestedSortableConfig);

    });


}