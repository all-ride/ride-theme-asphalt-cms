function joppaInitializeLayout(baseUrl, widgetDeleteMessage) {
	// make the available widget draggable
	$('#widgets .widget').draggable({
		helper: 'clone',
		cursor: 'move',
		activeClass: 'ui-state-hover',
		connectToSortable: '.droppable'
	});
	
	// handle the context menu of the widget actions
	$("#region .dropdown-toggle").dropdown();
	$("#region .dropdown-menu a").each(function () {
		joppaInitializeWidgetContextMenu(this, widgetDeleteMessage)
	});

	// create a drop region for new widgets
	$('#region .droppable').droppable({
		helper: 'clone',
		drop: function (event, ui) {
			id = ui.draggable.data('widget');
			if (id) {
				$.post(baseUrl + '/widget/' + id, function(data) {
				      var droppable = $('.droppable');

				      $('.ui-draggable', droppable).remove();
				      
				      droppable.append(data);
				      
				      $('.widget:last-child .dropdown-toggle', droppable).dropdown();
				      $(".widget:last-child .dropdown-menu a", droppable).each(function () {
				    	  joppaInitializeWidgetContextMenu(this, widgetDeleteMessage)
				      });
				      
				      $('#region .droppable').sortable('destroy');
				      joppaInitializeWidgetOrder(baseUrl);
				});				
			}
		}
	});
	
	// create a sortable from the set widgets
	joppaInitializeWidgetOrder(baseUrl);
}

function joppaInitializeWidgetContextMenu(a, widgetDeleteMessage) {
	var href = $(a).attr('href');
	
	if (href.indexOf('/delete') != -1) {			
		$(a).click(function() {
			if (confirm(widgetDeleteMessage)) {
				var action = $(a).attr('href');
				var container = $(a).parent().parent().parent().parent().parent();

				$.post(action, function(data) {
					container.remove();
				});
			}
			
			return false;
		});
	}	
}

function joppaInitializeWidgetOrder(baseUrl) {
	$('#region .droppable').sortable({
		containment: 'parent',
		handle: 'img.handle',
		update: function (event, ui) {
			id = ui.item.context.id;
			id = id.split('-');
			if (id[0] != 'page' && id[1] != 'widget') {
				return;
			}
			
			var order = '';
			$('#region .droppable > .widget').each(function(i) {
				order += this.id.replace('page-widget-', '') + ',';
			});
			
			$.post(baseUrl + '/order?widgets=' + escape(order));
	    } 			
	});	
}