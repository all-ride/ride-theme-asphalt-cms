function handleTextReuse(a){var b=$(".alert-warning");a?b.addClass("superhidden"):b.removeClass("superhidden")}$("#form-text-existing-new").change(function(){return handleTextReuse(this.checked),!1}),handleTextReuse($("#form-text-existing-new").is(":checked"));var $existing=$(".form__item--existing");$existing.addClass("superhidden").on("change",".form__select",function(){var a=$(this),b=$existing.data("url-text");b=b.replace("%25id%25",a.val()),$.get(b,function(a){var b="";a.title&&(b+="<h3>"+a.title+"</h3>"),a.subtitle&&(b+="<h4>"+a.subtitle+"</h4>"),a.body&&(b+=a.body),$(".preview",$existing).html(b)})}),$("#btn-text-reuse").click(function(a){a.preventDefault(),$(".tab").addClass("superhidden"),$(".form__item--existing").removeClass("superhidden").data("id",$(".form__item--existing select").val()),$("#btn-cancel").click(function(){return $(".form__item--existing select").val($(".form__item--existing").data("id")),$(".tab").removeClass("superhidden"),$(".form__item--existing").addClass("superhidden"),$("#btn-cancel").unbind(),$("#btn-submit").unbind(),!1}),$("#btn-submit").click(function(){var a=$(".form__item--existing").data("id"),b=$(".form__item--existing select").val();if(!b||b==a)return $("#btn-cancel").trigger("click"),!1;var c=$("#form-text"),d=c.attr("action")+"?text="+b;$("#form-text-existing-new").is(":checked")&&(d+="&new=1"),c.attr("action",d)})});