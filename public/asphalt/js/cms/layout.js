function initializeContent(a){var b=$(document),c=$("body"),d=($(".form-widget-add"),$(".modal-widget-add")),e=$(".widget-add-submit"),f=$(".widget-add-submit-close"),g=$(".modal-section-action"),h=$(".section-action-submit"),i=$(".section .block"),j=$(".sections"),k=$(".widget--compact"),l=$(".js-toggle-available"),m=[$(".section-delete"),$(".section__handle"),$(".widget__handle"),$(".widget-add"),$(".section-add")],n=!1,o=function(){var b=$("input[name=widget]:checked").val();if(!b)return void alert("no widget selected");var c=$("input[name=section]").val(),d=$("input[name=block]").val(),g=$(".section[data-section="+c+"] .block[data-block="+d+"]",j);if(1!=g.length)return void alert("no block found");e.attr("disabled","disabled"),f.attr("disabled","disabled");var h=$.post(a+"/sections/"+c+"/block/"+d+"/widget/"+b,function(a){$lockedWidget=g.find(".widget--locked");$lockedWidget.before(a);q(),s(),e.removeAttr("disabled"),f.removeAttr("disabled")});rideApp.common.handleXHRCallback(h,"Widget added","Could not add widget")},p=function(){var b={};$(".section").each(function(){var a=$(this),c="section"+a.data("section");void 0==b[c]&&(b[c]={}),$(".block",a).each(function(){var a=$(this),d=a.data("block"),e=$(".widget:not(.widget--locked)",a);e.length?(b[c][d]=[],e.each(function(){b[c][d].push($(this).data("widget"))})):b[c][d]=0})});var c=$.post(a+"/order",{order:b},function(a){});rideApp.common.handleXHRCallback(c,"Order updated","Could not update order")},q=function(){i.each(function(){try{$(this).sortable("destroy")}catch(a){console.log(a)}}),i.sortable({handle:".handle",items:".widget:not(.widget--locked)",connectWith:i,update:function(a,b){this===b.item.parent()[0]&&p()},over:function(a,b){b.placeholder.insertBefore($(this).children(".widget.widget--locked:first"))},activate:function(a,b){c.addClass("is-sorting")},deactivate:function(a,b){c.removeClass("is-sorting")}})},r=function(){j.sortable({handle:".panel-heading .handle",items:"> .section",update:function(a,b){p()},activate:function(a,b){c.addClass("is-sorting")},deactivate:function(a,b){c.removeClass("is-sorting")}})},s=function(){$(".section:not(.is-initialized)").addClass("is-initialized").find(".section__actions .action").on("click",function(a){a.preventDefault();var b=$(this),c=b.attr("href");"#"!=c[0]&&g.find(".modal-body").load(c+" form",function(){g.find(".modal-title").text(b.attr("title")),g.find(".form__actions").hide(),g.modal("show")})})},t=function(){m.forEach(function(a){a.hide()}),n=!0},u=function(){m.forEach(function(a){a.show()}),n=!1},v=function(a){var b=$(".widget.is-locked");a.is(":checked")?(b.stop().hide("medium"),t()):(b.stop().show("medium"),r(),q(),u())},w=function(a){$("div.section").each(function(){var b=$(this).find("div.widget"),c=$(this).find("div.is-unavailable");b.length>0&&b.length===c.length&&(a.is(":checked")?$(this).stop().hide("medium"):$(this).stop().show("medium"))})};b.on("click",".section-add",function(b){if(!n){b.preventDefault();var c,d=$.post(a+"/sections",function(a){c=j.append(a),i=$(".section .block"),q(),s(),$(".section:last",j).scrollTop()});rideApp.common.handleXHRCallback(d,"Section added","Could not add section")}}),b.on("click",".section-delete",function(b){if(b.preventDefault(),!n){var c=$(this);if(confirm(c.data("confirm"))){var d=c.closest(".section"),e=$.ajax({url:a+"/sections/"+d.data("section"),type:"DELETE",success:function(a){d.remove(),q()}});rideApp.common.handleXHRCallback(e,"Section removed","Could not remove section")}}}),b.on("click",".section__layouts > a",function(b){if(b.preventDefault(),!n){var c=$(this),d=c.closest(".section"),e=$.post(a+"/sections/"+d.data("section")+"/layout/"+c.data("layout"),function(a){d=d.replaceWith(a),q(),s()});rideApp.common.handleXHRCallback(e,"Section layout changed","Could not change section layout")}}),b.on("click",".widget-add",function(a){if(!n){var b=$(this),c=b.parents(".block"),e=b.parents(".section");0==c.length&&(c=$(".block",e).first()),$("input[name=section]").val(e.data("section")),$("input[name=block]").val(c.data("block")),d.modal("show")}}),e.on("click",function(a){a.preventDefault(),o()}),f.on("click",function(a){a.preventDefault(),o(),d.modal("hide")}),b.on("click",".widget-delete",function(b){if(b.preventDefault(),!n){var c=$(this);if(confirm(c.data("confirm"))){var d=c.closest(".section"),e=c.closest(".block"),f=c.closest(".widget"),g=$.ajax({url:a+"/sections/"+d.data("section")+"/block/"+e.data("block")+"/widget/"+f.data("widget"),type:"DELETE",success:function(a){f.remove()}});rideApp.common.handleXHRCallback(g,"Widget removed","Could not remove widget")}}}),l.on("change",function(){w($(this)),v($(this))}),$("#filter-widgets").on("keyup",function(a){if(13==a.which)return!1;var b=$(this).val();k.parent().show();k.filter(function(){var a=$(this).text(),c=new RegExp(b,"i");return a.search(c)<0}).parent().hide()}),h.on("click",function(a){a.preventDefault();var b=g.find("form"),c=$.post(b.attr("action"),b.serialize(),function(){g.modal("hide")});rideApp.common.handleXHRCallback(c,"Updated section properties","Could not update section properties")}),r(),q(),s()}