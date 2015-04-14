!function(a){function b(a,b,c){return a>b&&b+c>a}a.widget("mjs.nestedSortable",a.extend({},a.ui.sortable.prototype,{options:{doNotClear:!1,expandOnHover:700,isAllowed:function(a,b,c){return!0},isTree:!1,listType:"ol",maxLevels:0,protectRoot:!1,rootID:null,rtl:!1,startCollapsed:!1,tabSize:20,branchClass:"mjs-nestedSortable-branch",collapsedClass:"mjs-nestedSortable-collapsed",disableNestingClass:"mjs-nestedSortable-no-nesting",errorClass:"mjs-nestedSortable-error",expandedClass:"mjs-nestedSortable-expanded",hoveringClass:"mjs-nestedSortable-hovering",leafClass:"mjs-nestedSortable-leaf",disabledClass:"mjs-nestedSortable-disabled"},_create:function(){if(this.element.data("ui-sortable",this.element.data("mjs-nestedSortable")),!this.element.is(this.options.listType))throw new Error("nestedSortable: Please check that the listType option is set to your actual list type");if(this.options.isTree&&this.options.expandOnHover&&(this.options.tolerance="intersect"),a.ui.sortable.prototype._create.apply(this,arguments),this.options.isTree){var b=this;a(this.items).each(function(){var a=this.item;a.children(b.options.listType).length?(a.addClass(b.options.branchClass),a.hasClass(b.options.collapsedClass)||a.hasClass(b.options.expandedClass)||a.addClass(b.options.startCollapsed?b.options.collapsedClass:b.options.expandedClass)):a.addClass(b.options.leafClass)})}},_destroy:function(){return this.element.removeData("mjs-nestedSortable").removeData("ui-sortable"),a.ui.sortable.prototype._destroy.apply(this,arguments)},_mouseDrag:function(b){var c,d,e,f,g=this.options,h=!1;this.position=this._generatePosition(b),this.positionAbs=this._convertPositionTo("absolute"),this.lastPositionAbs||(this.lastPositionAbs=this.positionAbs),this.options.scroll&&(this.scrollParent[0]!=document&&"HTML"!=this.scrollParent[0].tagName?(this.overflowOffset.top+this.scrollParent[0].offsetHeight-b.pageY<g.scrollSensitivity?this.scrollParent[0].scrollTop=h=this.scrollParent[0].scrollTop+g.scrollSpeed:b.pageY-this.overflowOffset.top<g.scrollSensitivity&&(this.scrollParent[0].scrollTop=h=this.scrollParent[0].scrollTop-g.scrollSpeed),this.overflowOffset.left+this.scrollParent[0].offsetWidth-b.pageX<g.scrollSensitivity?this.scrollParent[0].scrollLeft=h=this.scrollParent[0].scrollLeft+g.scrollSpeed:b.pageX-this.overflowOffset.left<g.scrollSensitivity&&(this.scrollParent[0].scrollLeft=h=this.scrollParent[0].scrollLeft-g.scrollSpeed)):(b.pageY-a(document).scrollTop()<g.scrollSensitivity?h=a(document).scrollTop(a(document).scrollTop()-g.scrollSpeed):a(window).height()-(b.pageY-a(document).scrollTop())<g.scrollSensitivity&&(h=a(document).scrollTop(a(document).scrollTop()+g.scrollSpeed)),b.pageX-a(document).scrollLeft()<g.scrollSensitivity?h=a(document).scrollLeft(a(document).scrollLeft()-g.scrollSpeed):a(window).width()-(b.pageX-a(document).scrollLeft())<g.scrollSensitivity&&(h=a(document).scrollLeft(a(document).scrollLeft()+g.scrollSpeed))),h!==!1&&a.ui.ddmanager&&!g.dropBehaviour&&a.ui.ddmanager.prepareOffsets(this,b)),this.positionAbs=this._convertPositionTo("absolute");var i=this.placeholder.offset().top;this.options.axis&&"y"===this.options.axis||(this.helper[0].style.left=this.position.left+"px"),this.options.axis&&"x"===this.options.axis||(this.helper[0].style.top=this.position.top+"px"),this.hovering=this.hovering?this.hovering:null,this.mouseentered=this.mouseentered?this.mouseentered:!1;var j=this.placeholder[0].parentNode.parentNode&&a(this.placeholder[0].parentNode.parentNode).closest(".ui-sortable").length?a(this.placeholder[0].parentNode.parentNode):null,k=this._getLevel(this.placeholder),l=this._getChildLevels(this.helper),m=document.createElement(g.listType);for(c=this.items.length-1;c>=0;c--)if(d=this.items[c],e=d.item[0],f=this._intersectsWithPointer(d),f&&d.instance===this.currentContainer){if(-1!==e.className.indexOf(g.disabledClass))if(2===f){var n=this.items[c+1];if(n&&-1!==n.item[0].className.indexOf(g.disabledClass))continue}else if(1===f){var o=this.items[c-1];if(o&&-1!==o.item[0].className.indexOf(g.disabledClass))continue}if(e!==this.currentItem[0]&&this.placeholder[1===f?"next":"prev"]()[0]!==e&&!a.contains(this.placeholder[0],e)&&("semi-dynamic"===this.options.type?!a.contains(this.element[0],e):!0)){if(this.mouseentered||(a(e).mouseenter(),this.mouseentered=!0),g.isTree&&a(e).hasClass(g.collapsedClass)&&g.expandOnHover&&!this.hovering){a(e).addClass(g.hoveringClass);var p=this;this.hovering=window.setTimeout(function(){a(e).removeClass(g.collapsedClass).addClass(g.expandedClass),p.refreshPositions(),p._trigger("expand",b,p._uiHash())},g.expandOnHover)}if(this.direction=1==f?"down":"up","pointer"!=this.options.tolerance&&!this._intersectsWithSides(d))break;if(a(e).mouseleave(),this.mouseentered=!1,a(e).removeClass(g.hoveringClass),this.hovering&&window.clearTimeout(this.hovering),this.hovering=null,!g.protectRoot||this.currentItem[0].parentNode==this.element[0]&&e.parentNode!=this.element[0])g.protectRoot||this._rearrange(b,d);else if(this.currentItem[0].parentNode!=this.element[0]&&e.parentNode==this.element[0]){a(e).children(g.listType).length||(e.appendChild(m),g.isTree&&a(e).removeClass(g.leafClass).addClass(g.branchClass+" "+g.expandedClass));var q="down"===this.direction?a(e).prev().children(g.listType):a(e).children(g.listType);void 0!==q[0]&&this._rearrange(b,null,q)}else this._rearrange(b,d);this._clearEmpty(e),this._trigger("change",b,this._uiHash());break}}var r=this.placeholder[0].previousSibling?a(this.placeholder[0].previousSibling):null;if(null!=r)for(;"li"!=r[0].nodeName.toLowerCase()||-1!==r[0].className.indexOf(g.disabledClass)||r[0]==this.currentItem[0]||r[0]==this.helper[0];){if(!r[0].previousSibling){r=null;break}r=a(r[0].previousSibling)}var s=this.placeholder[0].nextSibling?a(this.placeholder[0].nextSibling):null;if(null!=s)for(;"li"!=s[0].nodeName.toLowerCase()||-1!==s[0].className.indexOf(g.disabledClass)||s[0]==this.currentItem[0]||s[0]==this.helper[0];){if(!s[0].nextSibling){s=null;break}s=a(s[0].nextSibling)}return this.beyondMaxLevels=0,null==j||null!=s||g.protectRoot&&j[0].parentNode==this.element[0]||!(g.rtl&&this.positionAbs.left+this.helper.outerWidth()>j.offset().left+j.outerWidth()||!g.rtl&&this.positionAbs.left<j.offset().left)?null==r||r.hasClass(g.disableNestingClass)||!(r.children(g.listType).length&&r.children(g.listType).is(":visible")||!r.children(g.listType).length)||g.protectRoot&&this.currentItem[0].parentNode==this.element[0]||!(g.rtl&&this.positionAbs.left+this.helper.outerWidth()<r.offset().left+r.outerWidth()-g.tabSize||!g.rtl&&this.positionAbs.left>r.offset().left+g.tabSize)?this._isAllowed(j,k,k+l):(this._isAllowed(r,k,k+l+1),r.children(g.listType).length||(r[0].appendChild(m),g.isTree&&r.removeClass(g.leafClass).addClass(g.branchClass+" "+g.expandedClass)),i&&i<=r.offset().top?r.children(g.listType).prepend(this.placeholder):r.children(g.listType)[0].appendChild(this.placeholder[0]),this._trigger("change",b,this._uiHash())):(j.after(this.placeholder[0]),g.isTree&&j.children(g.listItem).children("li:visible:not(.ui-sortable-helper)").length<1&&j.removeClass(this.options.branchClass+" "+this.options.expandedClass).addClass(this.options.leafClass),this._clearEmpty(j[0]),this._trigger("change",b,this._uiHash())),this._contactContainers(b),a.ui.ddmanager&&a.ui.ddmanager.drag(this,b),this._trigger("sort",b,this._uiHash()),this.lastPositionAbs=this.positionAbs,!1},_mouseStop:function(b,c){this.beyondMaxLevels&&(this.placeholder.removeClass(this.options.errorClass),this.domPosition.prev?a(this.domPosition.prev).after(this.placeholder):a(this.domPosition.parent).prepend(this.placeholder),this._trigger("revert",b,this._uiHash())),a("."+this.options.hoveringClass).mouseleave().removeClass(this.options.hoveringClass),this.mouseentered=!1,this.hovering&&window.clearTimeout(this.hovering),this.hovering=null,a.ui.sortable.prototype._mouseStop.apply(this,arguments);var d=a(this.domPosition.parent).parent().attr("id"),e=this.domPosition.prev?a(this.domPosition.prev).next().index():0;(d!=this._uiHash().item.parent().parent().attr("id")||e!=this._uiHash().item.index())&&this._trigger("relocate",b,this._uiHash())},_intersectsWithSides:function(a){var c=this.options.isTree?.8:.5,d=b(this.positionAbs.top+this.offset.click.top,a.top+a.height*c,a.height),e=b(this.positionAbs.top+this.offset.click.top,a.top-a.height*c,a.height),f=b(this.positionAbs.left+this.offset.click.left,a.left+a.width/2,a.width),g=this._getDragVerticalDirection(),h=this._getDragHorizontalDirection();return this.floating&&h?"right"==h&&f||"left"==h&&!f:g&&("down"==g&&d||"up"==g&&e)},_contactContainers:function(b){this.options.protectRoot&&this.currentItem[0].parentNode==this.element[0]||a.ui.sortable.prototype._contactContainers.apply(this,arguments)},_clear:function(b,c){a.ui.sortable.prototype._clear.apply(this,arguments);for(var d=this.items.length-1;d>=0;d--){var e=this.items[d].item[0];this._clearEmpty(e)}},serialize:function(b){var c=a.extend({},this.options,b),d=this._getItemsAsjQuery(c&&c.connected),e=[];return a(d).each(function(){var b=(a(c.item||this).attr(c.attribute||"id")||"").match(c.expression||/(.+)[-=_](.+)/),d=(a(c.item||this).parent(c.listType).parent(c.items).attr(c.attribute||"id")||"").match(c.expression||/(.+)[-=_](.+)/);b&&e.push((c.key||b[1])+"["+(c.key&&c.expression?b[1]:b[2])+"]="+(d?c.key&&c.expression?d[1]:d[2]:c.rootID))}),!e.length&&c.key&&e.push(c.key+"="),e.join("&")},toHierarchy:function(b){function c(b){var e=(a(b).attr(d.attribute||"id")||"").match(d.expression||/(.+)[-=_](.+)/);if(e){var f={id:e[2]};return a(b).children(d.listType).children(d.items).length>0&&(f.children=[],a(b).children(d.listType).children(d.items).each(function(){var a=c(this);f.children.push(a)})),f}}var d=a.extend({},this.options,b),e=(d.startDepthCount||0,[]);return a(this.element).children(d.items).each(function(){var a=c(this);e.push(a)}),e},toArray:function(b){function c(b,g,h){var i,j,k=h+1;if(a(b).children(d.listType).children(d.items).length>0&&(g++,a(b).children(d.listType).children(d.items).each(function(){k=c(a(this),g,k)}),g--),i=a(b).attr(d.attribute||"id").match(d.expression||/(.+)[-=_](.+)/),g===e+1)j=d.rootID;else{var l=a(b).parent(d.listType).parent(d.items).attr(d.attribute||"id").match(d.expression||/(.+)[-=_](.+)/);j=l[2]}return i&&f.push({item_id:i[2],parent_id:j,depth:g,left:h,right:k}),h=k+1}var d=a.extend({},this.options,b),e=d.startDepthCount||0,f=[],g=1;return d.excludeRoot||(f.push({item_id:d.rootID,parent_id:null,depth:e,left:g,right:2*(a(d.items,this.element).length+1)}),g++),a(this.element).children(d.items).each(function(){g=c(this,e+1,g)}),f=f.sort(function(a,b){return a.left-b.left})},_clearEmpty:function(b){var c=this.options,d=a(b).children(c.listType);!d.length||d.children().length||c.doNotClear?c.isTree&&d.length&&d.children().length&&d.is(":visible")?a(b).removeClass(c.leafClass).addClass(c.branchClass+" "+c.expandedClass):c.isTree&&d.length&&d.children().length&&!d.is(":visible")&&a(b).removeClass(c.leafClass).addClass(c.branchClass+" "+c.collapsedClass):(c.isTree&&a(b).removeClass(c.branchClass+" "+c.expandedClass).addClass(c.leafClass),d.remove())},_getLevel:function(a){var b=1;if(this.options.listType)for(var c=a.closest(this.options.listType);c&&c.length>0&&!c.is(".ui-sortable");)b++,c=c.parent().closest(this.options.listType);return b},_getChildLevels:function(b,c){var d=this,e=this.options,f=0;return c=c||0,a(b).children(e.listType).children(e.items).each(function(a,b){f=Math.max(d._getChildLevels(b,c+1),f)}),c?f+1:f},_isAllowed:function(a,b,c){var d=this.options,e=this.placeholder.closest(".ui-sortable").nestedSortable("option","maxLevels");d.isAllowed(this.placeholder,a,this.currentItem)?c>e&&0!=e?(this.placeholder.addClass(d.errorClass),this.beyondMaxLevels=c-e):(this.placeholder.removeClass(d.errorClass),this.beyondMaxLevels=0):(this.placeholder.addClass(d.errorClass),c>e&&0!=e?this.beyondMaxLevels=c-e:this.beyondMaxLevels=1)}})),a.mjs.nestedSortable.prototype.options=a.extend({},a.ui.sortable.prototype.options,a.mjs.nestedSortable.prototype.options)}(jQuery);