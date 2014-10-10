function handleTitleUse(isChecked) {
    if (isChecked) {
        $('.form__item--title').removeClass('superhidden');
        $('.form__item--subtitle').removeClass('superhidden');
    } else {
        $('.form__item--title').addClass('superhidden');
        $('.form__item--subtitle').addClass('superhidden');
    }
}

function handleImageUse(isChecked) {
    if (isChecked) {
        $('.form__item--image-src').removeClass('superhidden');
        $('.form__item--image-align').removeClass('superhidden');
    } else {
        $('.form__item--image-src').addClass('superhidden');
        $('.form__item--image-align').addClass('superhidden');
    }
}

function handleTextReuse(isChecked) {
    if (isChecked) {
        $('.alert-warning').addClass('superhidden');
    } else {
        $('.alert-warning').removeClass('superhidden');
    }
}

$('#form-text-existing-new').change(function() {
    handleTextReuse($(this).is(':checked'));

    return false;
});
$('.form__item--title-use input').change(function() {
    handleTitleUse($(this).is(':checked'));

    return false;
});
$('.form__item--image-use input').change(function() {
    handleImageUse($(this).is(':checked'));

    return false;
});

handleTextReuse($('#form-text-existing-new').is(':checked'));
handleTitleUse($('.form__item--title-use input').is(':checked'));
handleImageUse($('.form__item--image-use input').is(':checked'));
$('.form__item--existing').addClass('superhidden');

$('#btn-text-reuse').click(function(e) {
    e.preventDefault();
    $('.tab').addClass('superhidden');
    $('.form__item--existing').removeClass('superhidden').data('id', $('.form__item--existing select').val());

    $('#btn-cancel').click(function() {
        $('.form__item--existing select').val($('.form__item--existing').data('id'));

        $('.tab').removeClass('superhidden');
        $('.form__item--existing').addClass('superhidden');

        $('#btn-cancel').unbind();
        $('#btn-submit').unbind();

        return false;
    });

    $('#btn-submit').click(function() {
        var oldTextId = $('.form__item--existing').data('id');
        var textId = $('.form__item--existing select').val();
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
