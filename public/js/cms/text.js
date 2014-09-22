function handleTitleUse(isChecked) {
    if (isChecked) {
        $('.row-title').removeClass('hide');
        $('.row-subtitle').removeClass('hide');
    } else {
        $('.row-title').addClass('hide');
        $('.row-subtitle').addClass('hide');
    }
}

function handleImageUse(isChecked) {
    if (isChecked) {
        $('.row-image-src').removeClass('hide');
        $('.row-image-align').removeClass('hide');
    } else {
        $('.row-image-src').addClass('hide');
        $('.row-image-align').addClass('hide');
    }
}

function handleTextReuse(isChecked) {
    if (isChecked) {
        $('.alert-warning').addClass('hide');
    } else {
        $('.alert-warning').removeClass('hide');
    }
}

$('#form-text-existing-new').change(function() {
    handleTextReuse($(this).is(':checked'));

    return false;
});
$('.row-title-use input').change(function() {
    handleTitleUse($(this).is(':checked'));

    return false;
});
$('.row-image-use input').change(function() {
    handleImageUse($(this).is(':checked'));

    return false;
});

handleTextReuse($('#form-text-existing-new').is(':checked'));
handleTitleUse($('.row-title-use input').is(':checked'));
handleImageUse($('.row-image-use input').is(':checked'));
$('.row-existing').addClass('hide');

$('#btn-text-reuse').click(function() {
    $('.tab').addClass('hide');
    $('.row-existing').removeClass('hide').data('id', $('.row-existing select').val());

    $('#btn-cancel').click(function() {
        $('.row-existing select').val($('.row-existing').data('id'));

        $('.tab').removeClass('hide');
        $('.row-existing').addClass('hide');

        $('#btn-cancel').unbind();
        $('#btn-submit').unbind();

        return false;
    });

    $('#btn-submit').click(function() {
        var oldTextId = $('.row-existing').data('id');
        var textId = $('.row-existing select').val();
        if (textId && textId != oldTextId) {
            var form = $('#form-text');

            var url = form.attr('action') + '?text=' + textId;
            if ($('#form-text-existing-new').is(':checked')) {
                url += '&new=1';
            }

            form.attr('action', url);
        } else {
            $('#btn-cancel').trigger('click');

            return false;
        }
    });
});
