function handleRedirectForm(){var a=$("#form-redirect input[type=radio]:checked").val();$(".redirect-type").hide(),a&&$(".redirect-type-"+a).show()}$(function(){$("#form-redirect input[type=radio]").on("change",function(){handleRedirectForm()}),handleRedirectForm()});