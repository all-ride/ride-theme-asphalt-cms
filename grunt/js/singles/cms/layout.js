/* ========================================================================
 * Bootstrap: modal.js v3.3.1
 * http://getbootstrap.com/javascript/#modals
 * ========================================================================
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 * ======================================================================== */


+function ($) {
  'use strict';

  // MODAL CLASS DEFINITION
  // ======================

  var Modal = function (element, options) {
    this.options        = options
    this.$body          = $(document.body)
    this.$element       = $(element)
    this.$backdrop      =
    this.isShown        = null
    this.scrollbarWidth = 0

    if (this.options.remote) {
      this.$element
        .find('.modal-content')
        .load(this.options.remote, $.proxy(function () {
          this.$element.trigger('loaded.bs.modal')
        }, this))
    }
  }

  Modal.VERSION  = '3.3.1'

  Modal.TRANSITION_DURATION = 300
  Modal.BACKDROP_TRANSITION_DURATION = 150

  Modal.DEFAULTS = {
    backdrop: true,
    keyboard: true,
    show: true
  }

  Modal.prototype.toggle = function (_relatedTarget) {
    return this.isShown ? this.hide() : this.show(_relatedTarget)
  }

  Modal.prototype.show = function (_relatedTarget) {
    var that = this
    var e    = $.Event('show.bs.modal', { relatedTarget: _relatedTarget })

    this.$element.trigger(e)

    if (this.isShown || e.isDefaultPrevented()) return

    this.isShown = true

    this.checkScrollbar()
    this.setScrollbar()
    this.$body.addClass('modal-open')

    this.escape()
    this.resize()

    this.$element.on('click.dismiss.bs.modal', '[data-dismiss="modal"]', $.proxy(this.hide, this))

    this.backdrop(function () {
      var transition = $.support.transition && that.$element.hasClass('fade')

      if (!that.$element.parent().length) {
        that.$element.appendTo(that.$body) // don't move modals dom position
      }

      that.$element
        .show()
        .scrollTop(0)

      if (that.options.backdrop) that.adjustBackdrop()
      that.adjustDialog()

      if (transition) {
        that.$element[0].offsetWidth // force reflow
      }

      that.$element
        .addClass('in')
        .attr('aria-hidden', false)

      that.enforceFocus()

      var e = $.Event('shown.bs.modal', { relatedTarget: _relatedTarget })

      transition ?
        that.$element.find('.modal-dialog') // wait for modal to slide in
          .one('bsTransitionEnd', function () {
            that.$element.trigger('focus').trigger(e)
          })
          .emulateTransitionEnd(Modal.TRANSITION_DURATION) :
        that.$element.trigger('focus').trigger(e)
    })
  }

  Modal.prototype.hide = function (e) {
    if (e) e.preventDefault()

    e = $.Event('hide.bs.modal')

    this.$element.trigger(e)

    if (!this.isShown || e.isDefaultPrevented()) return

    this.isShown = false

    this.escape()
    this.resize()

    $(document).off('focusin.bs.modal')

    this.$element
      .removeClass('in')
      .attr('aria-hidden', true)
      .off('click.dismiss.bs.modal')

    $.support.transition && this.$element.hasClass('fade') ?
      this.$element
        .one('bsTransitionEnd', $.proxy(this.hideModal, this))
        .emulateTransitionEnd(Modal.TRANSITION_DURATION) :
      this.hideModal()
  }

  Modal.prototype.enforceFocus = function () {
    $(document)
      .off('focusin.bs.modal') // guard against infinite focus loop
      .on('focusin.bs.modal', $.proxy(function (e) {
        if (this.$element[0] !== e.target && !this.$element.has(e.target).length) {
          this.$element.trigger('focus')
        }
      }, this))
  }

  Modal.prototype.escape = function () {
    if (this.isShown && this.options.keyboard) {
      this.$element.on('keydown.dismiss.bs.modal', $.proxy(function (e) {
        e.which == 27 && this.hide()
      }, this))
    } else if (!this.isShown) {
      this.$element.off('keydown.dismiss.bs.modal')
    }
  }

  Modal.prototype.resize = function () {
    if (this.isShown) {
      $(window).on('resize.bs.modal', $.proxy(this.handleUpdate, this))
    } else {
      $(window).off('resize.bs.modal')
    }
  }

  Modal.prototype.hideModal = function () {
    var that = this
    this.$element.hide()
    this.backdrop(function () {
      that.$body.removeClass('modal-open')
      that.resetAdjustments()
      that.resetScrollbar()
      that.$element.trigger('hidden.bs.modal')
    })
  }

  Modal.prototype.removeBackdrop = function () {
    this.$backdrop && this.$backdrop.remove()
    this.$backdrop = null
  }

  Modal.prototype.backdrop = function (callback) {
    var that = this
    var animate = this.$element.hasClass('fade') ? 'fade' : ''

    if (this.isShown && this.options.backdrop) {
      var doAnimate = $.support.transition && animate

      this.$backdrop = $('<div class="modal-backdrop ' + animate + '" />')
        .prependTo(this.$element)
        .on('click.dismiss.bs.modal', $.proxy(function (e) {
          if (e.target !== e.currentTarget) return
          this.options.backdrop == 'static'
            ? this.$element[0].focus.call(this.$element[0])
            : this.hide.call(this)
        }, this))

      if (doAnimate) this.$backdrop[0].offsetWidth // force reflow

      this.$backdrop.addClass('in')

      if (!callback) return

      doAnimate ?
        this.$backdrop
          .one('bsTransitionEnd', callback)
          .emulateTransitionEnd(Modal.BACKDROP_TRANSITION_DURATION) :
        callback()

    } else if (!this.isShown && this.$backdrop) {
      this.$backdrop.removeClass('in')

      var callbackRemove = function () {
        that.removeBackdrop()
        callback && callback()
      }
      $.support.transition && this.$element.hasClass('fade') ?
        this.$backdrop
          .one('bsTransitionEnd', callbackRemove)
          .emulateTransitionEnd(Modal.BACKDROP_TRANSITION_DURATION) :
        callbackRemove()

    } else if (callback) {
      callback()
    }
  }

  // these following methods are used to handle overflowing modals

  Modal.prototype.handleUpdate = function () {
    if (this.options.backdrop) this.adjustBackdrop()
    this.adjustDialog()
  }

  Modal.prototype.adjustBackdrop = function () {
    this.$backdrop
      .css('height', 0)
      .css('height', this.$element[0].scrollHeight)
  }

  Modal.prototype.adjustDialog = function () {
    var modalIsOverflowing = this.$element[0].scrollHeight > document.documentElement.clientHeight

    this.$element.css({
      paddingLeft:  !this.bodyIsOverflowing && modalIsOverflowing ? this.scrollbarWidth : '',
      paddingRight: this.bodyIsOverflowing && !modalIsOverflowing ? this.scrollbarWidth : ''
    })
  }

  Modal.prototype.resetAdjustments = function () {
    this.$element.css({
      paddingLeft: '',
      paddingRight: ''
    })
  }

  Modal.prototype.checkScrollbar = function () {
    this.bodyIsOverflowing = document.body.scrollHeight > document.documentElement.clientHeight
    this.scrollbarWidth = this.measureScrollbar()
  }

  Modal.prototype.setScrollbar = function () {
    var bodyPad = parseInt((this.$body.css('padding-right') || 0), 10)
    if (this.bodyIsOverflowing) this.$body.css('padding-right', bodyPad + this.scrollbarWidth)
  }

  Modal.prototype.resetScrollbar = function () {
    this.$body.css('padding-right', '')
  }

  Modal.prototype.measureScrollbar = function () { // thx walsh
    var scrollDiv = document.createElement('div')
    scrollDiv.className = 'modal-scrollbar-measure'
    this.$body.append(scrollDiv)
    var scrollbarWidth = scrollDiv.offsetWidth - scrollDiv.clientWidth
    this.$body[0].removeChild(scrollDiv)
    return scrollbarWidth
  }


  // MODAL PLUGIN DEFINITION
  // =======================

  function Plugin(option, _relatedTarget) {
    return this.each(function () {
      var $this   = $(this)
      var data    = $this.data('bs.modal')
      var options = $.extend({}, Modal.DEFAULTS, $this.data(), typeof option == 'object' && option)

      if (!data) $this.data('bs.modal', (data = new Modal(this, options)))
      if (typeof option == 'string') data[option](_relatedTarget)
      else if (options.show) data.show(_relatedTarget)
    })
  }

  var old = $.fn.modal

  $.fn.modal             = Plugin
  $.fn.modal.Constructor = Modal


  // MODAL NO CONFLICT
  // =================

  $.fn.modal.noConflict = function () {
    $.fn.modal = old
    return this
  }


  // MODAL DATA-API
  // ==============

  $(document).on('click.bs.modal.data-api', '[data-toggle="modal"]', function (e) {
    var $this   = $(this)
    var href    = $this.attr('href')
    var $target = $($this.attr('data-target') || (href && href.replace(/.*(?=#[^\s]+$)/, ''))) // strip for ie7
    var option  = $target.data('bs.modal') ? 'toggle' : $.extend({ remote: !/#/.test(href) && href }, $target.data(), $this.data())

    if ($this.is('a')) e.preventDefault()

    $target.one('show.bs.modal', function (showEvent) {
      if (showEvent.isDefaultPrevented()) return // only register focus restorer if modal will actually get shown
      $target.one('hidden.bs.modal', function () {
        $this.is(':visible') && $this.trigger('focus')
      })
    })
    Plugin.call($target, option, this)
  })
}(jQuery);

function initializeContent(baseUrl) {
    var $document = $(document);
    var $body = $('body');
    var $formWidgetAdd = $('.form-widget-add');
    var $modalWidgetAdd = $('.modal-widget-add');
    var $buttonWidgetAdd = $('.widget-add-submit');
    var $buttonWidgetAddAndClose = $('.widget-add-submit-close');
    var $modalSectionAction = $('.modal-section-action');
    var $buttonSectionAction = $('.section-action-submit');
    var $blocks = $('.section .block');
    var $sections = $('.sections');

    var $availabilityToggle = $('.js-toggle-available');
    var actionsDisabled = false;

    // perform a widget add to the cms
    var widgetAdd = function() {
        var widget = $('input[name=widget]:checked').val();
        if (!widget) {
            alert('no widget selected');
            return;
        }

        var section = $('input[name=section]').val();
        var block = $('input[name=block]').val();
        var $block = $('.section[data-section=' + section + '] .block[data-block=' + block + ']', $sections);

        if ($block.length != 1) {
            alert('no block found');
            return;
        }

        $buttonWidgetAdd.attr('disabled', 'disabled');
        $buttonWidgetAddAndClose.attr('disabled', 'disabled');

        var jqxhr = $.post(baseUrl + '/sections/' + section + '/block/' + block + '/widget/' + widget, function(html) {
            $lockedWidget = $block.find('.widget--locked');
            var $section = $lockedWidget.before(html);

            initWidgetOrder(baseUrl, true);
            initSectionActions();

            $buttonWidgetAdd.removeAttr('disabled');
            $buttonWidgetAddAndClose.removeAttr('disabled');
        });

        rideApp.common.handleXHRCallback(jqxhr, 'Widget added', 'Could not add widget');
    };

    // perform the order update to the cms
    var updateOrder = function(baseUrl) {
        // generate overview of the widgets in their blocks and sections
        var order = {};
        $('.section').each(function() {
            var $section = $(this);
            var section = 'section' + $section.data('section');

            if (order[section] == undefined) {
                order[section] = {};
            }

            $('.block', $section).each(function() {
                var $block = $(this);
                var block = $block.data('block');


                var $widgets = $('.widget:not(.widget--locked)', $block);
                if ($widgets.length) {
                    order[section][block] = [];
                    $widgets.each(function() {
                        order[section][block].push($(this).data('widget'));
                    });
                } else {
                    order[section][block] = 0;
                }
            });
        });

        // post the order the cms
        var jqxhr = $.post(baseUrl + '/order', {order: order}, function(data) {
        });
        rideApp.common.handleXHRCallback(jqxhr, 'Order updated', 'Could not update order');
    }

    // initialize the sortable for the widgets
    var initWidgetOrder = function (baseUrl, reset) {
        if (reset != undefined && reset) {
            $blocks.each(function() {
                try {
                    $(this).sortable('destroy');
                } catch (error) {
                    console.log(error);
                }
            });
        }

        $blocks.sortable({
            handle: '.handle',
            items: '> .widget:not(.widget--locked)',
            connectWith: $blocks,
            update: function (event, ui) {            // don't update twice
                if (this !== ui.item.parent()[0]) {
                    return;
                }
                updateOrder(baseUrl);
            },
            over: function (event, ui) {
                ui.placeholder.insertBefore($(this).children('.widget.widget--locked:first'));
            },
            activate: function (event, ui) {
                $body.addClass('is-sorting');
            },
            deactivate: function (event, ui) {
                $body.removeClass('is-sorting');
            }
        });
    };

    var lockOrder = function () {
        var $itemsToLock = $blocks.add($sections);

        $itemsToLock.each(function() {
            try {
                $(this).sortable('destroy');
            } catch (error) {
                console.log(error);
            }
        });
    };

    var disableActions = function () {
        actionsDisabled = true;
        console.log('disabled actions');
    };
    var enableActions = function () {
        actionsDisabled = false;
        console.log('enabled actions');
    };

    var initSectionOrder = function () {
        $sections.sortable({
            handle: '.panel-heading .handle',
            items: '> .section',
            update: function(event, ui) {
                updateOrder(baseUrl);
            },
            activate: function (event, ui) {
                $body.addClass('is-sorting');
            },
            deactivate: function (event, ui) {
                $body.removeClass('is-sorting');
            }
        });
    };

    // var sectionOrder = (function() {

    //     var init = function() {

    //     };

    //     var destroy = function() {

    //     };

    //     return {
    //         init: init,
    //         destroy: destroy
    //     };

    // })();

    //  Initialize section actions (style, properties) to open in modal
    var initSectionActions = function () {
      $('.section:not(.is-initialized)').addClass('is-initialized').find('.section__actions .action').on('click', function (e) {
        e.preventDefault();
        var $action = $(this);
        var href = $action.attr('href');
        if (href[0] == '#') {
            return;
        }
        $modalSectionAction.find('.modal-body').load(href + ' form', function () {
            $modalSectionAction.find('.modal-title').text($action.attr('title'));
            $modalSectionAction.find('.form__actions').hide();
            $modalSectionAction.modal('show');
        });
      });
    };

    // initialize sortable for the sections
    initSectionOrder();

    // add a new section
    $document.on('click', '.section-add', function(e) {
        if (actionsDisabled) { return; }

        e.preventDefault();
        var method = $(this).data('method');
        var $section;
        var jqxhr = $.post(baseUrl + '/sections', function(html) {
            switch(method) {
              case 'prepend':
                $section = $sections.prepend(html);
                break;
              case 'append':
              default:
                $section = $sections.append(html);
                break;
            }

            initWidgetOrder(baseUrl, true);
            initSectionActions();

            $('.section:last', $sections).scrollTop();
        });

        rideApp.common.handleXHRCallback(jqxhr, 'Section added', 'Could not add section');
    });

    // delete a section
    $document.on('click', '.section-delete', function(e) {
        e.preventDefault();

        if (actionsDisabled) { return; }

        var $this = $(this);
        if (!confirm($this.data('confirm'))) {
            return;
        }

        var $section = $this.closest('.section');
        var jqxhr = $.ajax({
            url: baseUrl + '/sections/' + $section.data('section'),
            type: 'DELETE',
            success: function(result) {
                $section.remove();

                initWidgetOrder(baseUrl, true);
            }
        });

        rideApp.common.handleXHRCallback(jqxhr, 'Section removed', 'Could not remove section');
    });

    // change section layout
    $document.on('click', '.section__layouts > a', function(e) {
        e.preventDefault();

        if (actionsDisabled) { return; }

        var $this = $(this);
        var $section = $this.closest('.section');

        var jqxhr = $.post(baseUrl + '/sections/' + $section.data('section') + '/layout/' +  $this.data('layout'), function(html) {
            $section = $section.replaceWith(html);

            initWidgetOrder(baseUrl, true);
            initSectionActions();
        });
        rideApp.common.handleXHRCallback(jqxhr, 'Section layout changed', 'Could not change section layout');
    });

    // add widget with double click
    // $document.on('dblclick', '.section .block', function() {
    //     var $this = $(this);
    //     var block = $this.data('block');
    //     var section = $this.parents('.section').data('section');

    //     $('input[name=section]').val(section);
    //     $('input[name=block]').val(block);

    //     $modalWidgetAdd.modal('show');
    // });

    // add widget through link
    $document.on('click', '.widget-add', function(event) {
        if (actionsDisabled) { return; }

        var $button = $(this);
        var $block = $button.parents('.block');
        var $section = $button.parents('.section');

        if ($block.length == 0) {
            $block = $('.block', $section).first();
        }

        $('input[name=section]').val($section.data('section'));
        $('input[name=block]').val($block.data('block'));

        $modalWidgetAdd.modal('show');
    });

    // widget add button
    $buttonWidgetAdd.on('click', function(e) {
        e.preventDefault();

        widgetAdd();
    });

    // widget add and close button
    $buttonWidgetAddAndClose.on('click', function(e) {
        e.preventDefault();

        widgetAdd();

        $modalWidgetAdd.modal('hide');
    });

    // delete a widget
    $document.on('click', '.widget-delete', function(e) {
        e.preventDefault();

        if (actionsDisabled) { return; }

        var $this = $(this);
        if (!confirm($this.data('confirm'))) {
            return;
        }

        var $section = $this.closest('.section');
        var $block = $this.closest('.block');
        var $widget = $this.closest('.widget');

        var jqxhr = $.ajax({
            url: baseUrl + '/sections/' + $section.data('section') + '/block/' + $block.data('block') + '/widget/' + $widget.data('widget'),
            type: 'DELETE',
            success: function(result) {
                $widget.remove();
            }
        });

        rideApp.common.handleXHRCallback(jqxhr, 'Widget removed', 'Could not remove widget');
    });

    // Toggle widgets
    var toggleAvailableWidgets = function($el) {
        var $widgetsToToggle = $('.widget.is-locked');

        if ($el.is(':checked')) {
            $widgetsToToggle.hide();
            disableActions();
            lockOrder();
        } else {
            $widgetsToToggle.show();
            initSectionOrder();
            initWidgetOrder();
            enableActions();
        }
    };

    toggleAvailableWidgets($availabilityToggle);
    $availabilityToggle.on('change', function(){
        toggleAvailableWidgets($(this));
    });

    // filter widgets
    var $widgets = $('.widget--compact');
    $('#filter-widgets').on('keyup', function(e) {
      if(e.which == 13) {
        return false;
      }
      var value = $(this).val();
      $widgets.parent().show();
      var widgets = $widgets.filter(function() {
        var string = $(this).text(),
            regexpres = new RegExp(value, 'i'),
            result = string.search(regexpres);

        return result < 0;
      }).parent().hide();
    });

    $buttonSectionAction.on('click', function (e) {
      e.preventDefault();
      var $form = $modalSectionAction.find('form');
      var jqxhr = $.post($form.attr('action'), $form.serialize(), function () {
        $modalSectionAction.modal('hide');
      });
      rideApp.common.handleXHRCallback(jqxhr, 'Updated section properties', 'Could not update section properties');
    });

    initWidgetOrder(baseUrl);
    initSectionActions();
}
