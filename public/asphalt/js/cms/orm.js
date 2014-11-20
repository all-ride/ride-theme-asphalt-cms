var filterFields;

function initializeNodeEntryForm(entriesAction) {
	$("#form-model").change(function() {
		updateEntryOptions(entriesAction);
	});
}

function updateEntryOptions(action) {
	var model = $("#form-model").val();
	var select = $("#form-entry");

	select.empty();
	select.append('<option value="">---</option>');

	if (model) {
		$.getJSON(action.replace('%25model%25', model), function(data) {
			for (var key in data) {
				select.append('<option value="' + key + '">' + data[key] + '</option>');
			}
		});
	}

	select.val('');
}

function joppaContentInitializeDetailProperties(selectFieldsAction, uniqueFieldsAction) {
	$("#form-content-properties-model").change(function() {
		joppaContentUpdateFields(selectFieldsAction);
		joppaContentUpdateIdFields(uniqueFieldsAction);
	});

	if ($('#form-content-properties-fields option').length == 0) {
		joppaContentUpdateFields(selectFieldsAction);
		joppaContentUpdateIdFields(uniqueFieldsAction);
	}
}

function joppaContentInitializeOverviewProperties(fieldsAction, orderFieldsAction, filterFieldsAction) {
	$("#form-content-properties-model").change(function() {
		joppaContentUpdateFields(fieldsAction);
		joppaContentUpdateOrderFields(orderFieldsAction);
		joppaContentUpdateFilterFields(filterFieldsAction);

		$("#form-content-properties-condition-expression").val('');
		$("#form-content-properties-order-expression").val('');
		$('.row-filters .collection-control').remove();
	});

	$("#form-content-properties-recursive-depth").change(function() {
		joppaContentUpdateOrderFields(orderFieldsAction);
	});

	$('.row-filters .prototype-add').click(function() {
		if (filterFields) {
			setTimeout(function() {
				$('.row-filters .row-field select').each(function() {
					var select = $(this);

					select.empty();
					for (var key in filterFields) {
						if (filterFields.hasOwnProperty(key)) {
							select.append('<option value="' + key + '">' + filterFields[key] + '</option>');
						}
					}
					select.val('');
				});
			}, 10);
		}
	});

	$("#form-content-properties-order-add").click(function() {
		var orderField = $("#form-content-properties-order-field").val();
		if (!orderField) {
			return false;
		}

		orderField = '{' + orderField + '} ' + $("#form-content-properties-order-direction").val();

		var orderExpression = $("#form-content-properties-order").val();
		if (orderExpression) {
			orderExpression += ', ';
		}

		orderExpression += orderField;

		$("#form-content-properties-order").val(orderExpression);
		$("#form-content-properties-order-field").val('');

		return false;
	});

	$("#form-content-properties-pagination-enable").change(function() {
		var usePagination = $("#form-content-properties-pagination-enable").is(':checked');

		var suffix = usePagination ? ':hidden' : ':visible';
		$("#form-content-properties #tabQuery .pagination-attribute" + suffix).slideToggle('fast');

		$("#form-content-properties #tabView .pagination-attribute").each(function() {
			var displayAttribute = $(this).css('display');
			if (usePagination && displayAttribute == 'none') {
				$(this).show();
			} else if (!usePagination || displayAttribute != 'none') {
				$(this).hide();
			}
		});

		if ($('#form-content-properties-pagination-show').is(':checked')) {
			if (usePagination) {
				$("#form-content-properties .pagination-ajax").first().show();
			} else {
				$("#form-content-properties .pagination-ajax").first().hide();
			}
		} else {
			$("#form-content-properties .pagination-ajax").first().hide();
		}

		if ($('#form-content-properties-more-show').is(':checked')) {
			$("#form-content-properties .more-attribute").each(function() {
				if (usePagination) {
					$(this).show();
				} else {
					$(this).hide();
				}
			});
		} else {
			$("#form-content-properties .more-attribute").hide();
		}
	});

	$("#form-content-properties-pagination-show").click(function() {
		var suffix = $("#form-content-properties-pagination-show").is(':checked') ? ':hidden' : ':visible';
		$("#form-content-properties .pagination-ajax" + suffix).first().slideToggle('fast');
	});

	$("#form-content-properties-more-show").change(function() {
		var suffix = $("#form-content-properties-more-show").is(':checked') ? ':hidden' : ':visible';
		$("#form-content-properties #tabView .more-attribute" + suffix).slideToggle('fast');
	});

	$("#form-content-properties-parameters-type-none").click(function() {
		$("#form-content-properties .parameters-enable:visible").slideToggle('fast');
	});

	$("#form-content-properties-parameters-type-numeric").click(function() {
		$("#form-content-properties .parameters-named:visible").slideToggle('fast');
		$("#form-content-properties .parameters-numeric:hidden").slideToggle('fast');
		$("#form-content-properties .row-parameters-none:hidden").slideToggle('fast');
	});

	$("#form-content-properties-parameters-type-named").click(function() {
		$("#form-content-properties .parameters-numeric:visible").slideToggle('fast');
		$("#form-content-properties .parameters-named:hidden").slideToggle('fast');
		$("#form-content-properties .row-parameters-none:hidden").slideToggle('fast');
	});

	if (!$("#form-content-properties-pagination-enable").is(':checked')) {
		$("#form-content-properties .pagination-attribute").hide();
	}

	if (!$("#form-content-properties-more-show").is(':checked')) {
		$("#form-content-properties .more-attribute").hide();
	}

	if (!$("#form-content-properties-pagination-show").is(':checked')) {
		$("#form-content-properties .pagination-ajax").first().hide();
	}

	if ($("#form-content-properties-parameters-type-none").is(':checked')) {
		$("#form-content-properties .parameters-enable").hide();
	} else if ($("#form-content-properties-parameters-type-named").is(':checked')) {
		$("#form-content-properties .parameters-enable").not('.parameters-named').not('.row-parameters-none').hide();
	} else if ($("#form-content-properties-parameters-type-numeric").is(':checked')) {
		$("#form-content-properties .parameters-enable").not('.parameters-numeric').not('.row-parameters-none').hide();
	}
}

function joppaContentUpdateFields(action) {
	var model = $("#form-content-properties-model").val();

	$.getJSON(action.replace('%25model%25', model), function(data) {
		var select = $("#form-content-properties-fields");
		select.empty();
		for (var key in data.fields) {
			if (data.fields.hasOwnProperty(key)) {
				select.append('<option value="' + key + '">' + data.fields[key] + '</option>');
			}
		}
		select.val('');
	});
}

function joppaContentUpdateOrderFields(action) {
	var model = $("#form-content-properties-model").val();
	var recursiveDepth = $("#form-content-properties-recursive-depth").val();

	$.getJSON(action.replace('%25model%25', model).replace('%25recursiveDepth%25', recursiveDepth), function(data) {
		var select = $("#form-content-properties-order-field");
		select.empty();
		select.append('<option value="">---</option>');
		for (var key in data.fields) {
			if (data.fields.hasOwnProperty(key)) {
				select.append('<option value="' + key + '">' + data.fields[key] + '</option>');
			}
		}
		select.val('');
		$("#form-content-properties .order-direction:visible").first().slideToggle('fast');
	});
}

function joppaContentUpdateFilterFields(action) {
	var model = $("#form-content-properties-model").val();

	$.getJSON(action.replace('%25model%25', model).replace('%25recursiveDepth%25', 1), function(data) {
		filterFields = data.fields;
	});
}

function joppaContentUpdateIdFields(action) {
	var model = $("#form-content-properties-model").val();

	$.getJSON(action.replace('%25model%25', model), function(data) {
		var select = $("#form-content-properties-field-id");
		select.empty();
		for (var key in data.fields) {
			if (data.fields.hasOwnProperty(key)) {
				select.append('<option value="' + key + '">' + data.fields[key] + '</option>');
			}
		}
		select.val('');
	});
}
